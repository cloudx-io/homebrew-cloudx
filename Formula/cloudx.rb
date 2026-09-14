class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.38"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.38/cloudx_0.38_darwin_arm64.tar.gz"
      sha256 "57526c36b5a0476149132f8eccd42338cfa7dc6df6c9e97776fe35bc953fd49a"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.38/cloudx_0.38_darwin_amd64.tar.gz"
      sha256 "a3fcc77cd2b396b44e7e1aeb1777a05fd4d75874ca17d761c3d28ad16890bdc8"
    end
  end

  def install
    bin.install "cloudx"
    generate_completions_from_executable(bin/"cloudx", "completion")
  end

  def caveats
    <<~EOS
      Shell completions were installed for bash, zsh, and fish.

      Homebrew does not automatically link completions for external tap commands.
      If completion is not active yet, run:
        brew completions link
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
