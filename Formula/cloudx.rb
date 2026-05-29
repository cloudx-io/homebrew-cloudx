class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.34"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.34/cloudx_0.34_darwin_arm64.tar.gz"
      sha256 "9ae7c3f91062b09e99b9a4afde22524f9e3f5750f3ac96f6eaf7c973d19b2cc9"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.34/cloudx_0.34_darwin_amd64.tar.gz"
      sha256 "ee00af8ee30089ceea2745549788f4dd8cf07d9115ec037bac414b0e0b661b5e"
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
