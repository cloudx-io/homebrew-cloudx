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
      raise CurlDownloadStrategyError, url
    end

    downloaded_file = download_dir/@filename
    raise CurlDownloadStrategyError, url unless downloaded_file.exist?

    cached_location.dirname.mkpath
    FileUtils.mv(downloaded_file, cached_location)
    symlink_download
  ensure
    download_dir.rmtree if download_dir&.exist?
  end

  private

  def find_gh!
    gh = ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).filter_map do |path|
      next if path.empty?

      candidate = Pathname(path)/"gh"
      candidate.to_s if candidate.file? && candidate.executable?
    end.first

    return gh if gh

    odie <<~EOS
      Additional GitHub authentication tooling is required to install this formula.
    EOS
  end

  def symlink_download
    symlink_location.dirname.mkpath
    FileUtils.ln_sf(cached_location.relative_path_from(symlink_location.dirname), symlink_location)
  end
end
