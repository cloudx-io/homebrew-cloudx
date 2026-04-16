require "download_strategy"
require "fileutils"
require "pathname"
require "system_command"

class PrivateGitHubReleaseStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super

    match = %r{^https?://github\.com/(?<owner>[^/]+)/(?<repo>[^/]+)/releases/download/(?<tag>[^/]+)/(?<filename>[^/?#]+)$}.match(url)
    raise CurlDownloadStrategyError, url unless match

    @owner = match[:owner]
    @repo = match[:repo]
    @tag = match[:tag]
    @filename = match[:filename]
  end

  def fetch(timeout: nil)
    opoo "Ignoring unsupported timeout argument in #{self.class}#fetch" if timeout

    if cached_location.exist?
      puts "Already downloaded: #{cached_location}"
      symlink_download
      return
    end

    gh = find_gh!
    download_dir = temporary_path.dirname/"private-github-release"
    download_dir.rmtree if download_dir.exist?
    download_dir.mkpath

    begin
      system_command!(
        gh,
        args: [
          "release",
          "download",
          "-R", "#{@owner}/#{@repo}",
          @tag,
          "--pattern", @filename,
          "--dir", download_dir.to_s,
        ],
        print_stderr: true
      )
    rescue ErrorDuringExecution
      odie <<~EOS
        Failed to download the CloudX CLI release asset from GitHub.

        Make sure the GitHub CLI is authenticated and has access to:
          - #{@owner}/#{@repo}

        Then try again:
          gh auth status
          gh auth login
      EOS
    end

    downloaded_file = download_dir/@filename
    unless downloaded_file.exist?
      odie <<~EOS
        GitHub CLI ran, but the expected release asset was not downloaded.

        Expected:
          - repository: #{@owner}/#{@repo}
          - tag: #{@tag}
          - asset: #{@filename}

        Check that the release exists and that your GitHub account can access it.
      EOS
    end

    cached_location.dirname.mkpath
    FileUtils.mv(downloaded_file, cached_location)
    symlink_download
  ensure
    download_dir.rmtree if download_dir&.exist?
  end

  private

  def find_gh!
    candidates = []

    candidates.concat(
      ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).filter_map do |path|
        next if path.empty?

        candidate = Pathname(path)/"gh"
        candidate.to_s if candidate.file? && candidate.executable?
      end
    )

    %w[
      /opt/homebrew/bin/gh
      /usr/local/bin/gh
      /opt/local/bin/gh
      /usr/bin/gh
    ].each do |candidate|
      candidates << candidate if File.executable?(candidate)
    end

    which_output = `command -v gh 2>/dev/null`.strip
    candidates << which_output unless which_output.empty?

    gh = candidates.find { |candidate| File.executable?(candidate) }
    return gh if gh

    odie <<~EOS
      GitHub CLI (`gh`) is required to install this formula from a private GitHub release.

      Install it first, then authenticate with an account that has access to the CloudX repositories:
        brew install gh
        gh auth login
    EOS
  end

  def symlink_download
    symlink_location.dirname.mkpath
    FileUtils.ln_sf(cached_location.relative_path_from(symlink_location.dirname), symlink_location)
  end
end
