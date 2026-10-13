class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.41"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.41/cloudx_0.41_darwin_arm64.tar.gz"
      sha256 "7c6a90870838bc338f9451d299935e05f25e1561f2bca4ede3a88d31f925f9db"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.41/cloudx_0.41_darwin_amd64.tar.gz"
      sha256 "ee2688458c89dd7c60cebd48f108e32ba72c36aec1d911e4e719453374169c42"
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
