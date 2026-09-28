class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.40"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.40/cloudx_0.40_darwin_arm64.tar.gz"
      sha256 "efa1f75d4fd15fedee7cbb9b07361f6180577ab6044ae35e198780c3e268e760"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.40/cloudx_0.40_darwin_amd64.tar.gz"
      sha256 "5590167a82b41bd124787786a598a7730caed9b4505a426846bf1145a7913808"
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
