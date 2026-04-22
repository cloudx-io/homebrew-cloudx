class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.27"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.27/cloudx_0.27_darwin_arm64.tar.gz"
      sha256 "e0b108a8236d2fb2c371b1fb4a0aa26952b9631c8fed851035bce422c213b498"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.27/cloudx_0.27_darwin_amd64.tar.gz"
      sha256 "6308828861943b6e0645164cc04ed8a93d60fd30fca6e06cbb03cede737b5a17"
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
