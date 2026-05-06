class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.30"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.30/cloudx_0.30_darwin_arm64.tar.gz"
      sha256 "6d90e35638402cb490150687bfae8e2a75ea1d34b2e6cd2804faa88eb60312a7"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.30/cloudx_0.30_darwin_amd64.tar.gz"
      sha256 "62c7bf37d47b84999b550c12c5ad1b54e863b7bcf4b8f80332b3ef73106ffdc2"
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
