class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.31"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.31/cloudx_0.31_darwin_arm64.tar.gz"
      sha256 "4994722d06e0f9be1d0914ee47b0ae718dc52f29ca86664c83758f7b9aa17196"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.31/cloudx_0.31_darwin_amd64.tar.gz"
      sha256 "b5ed9f10b2a558ab78ff1c7e1e25eca2235abfa0d32caf95bad5463720cb0b79"
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
