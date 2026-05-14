class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.32"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.32/cloudx_0.32_darwin_arm64.tar.gz"
      sha256 "fad59851c3ea8e37134efdd7985662e0824041b144b782d0385350b2bab77186"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.32/cloudx_0.32_darwin_amd64.tar.gz"
      sha256 "55f251b1675bc57f108589e6699cd81ce1527db0f3c4cbfd77d56eb099cdd644"
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
