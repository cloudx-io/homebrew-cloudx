class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.39"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.39/cloudx_0.39_darwin_arm64.tar.gz"
      sha256 "307f31a5dfba4ec761dd3731a5a5b525c5c6c5d092417ba3e72fa4b2d6a7e73c"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.39/cloudx_0.39_darwin_amd64.tar.gz"
      sha256 "36c6490ebffec98b4c3abe4e8053c958bdb26735af819e068422ba2922cca12d"
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
