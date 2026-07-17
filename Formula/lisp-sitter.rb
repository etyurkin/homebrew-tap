class LispSitter < Formula
  desc "Structural editing CLI for Emacs Lisp, Scheme, and Common Lisp"
  homepage "https://github.com/etyurkin/lisp-sitter"
  url "https://github.com/etyurkin/lisp-sitter/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "19fa3efa10a586296a04bbb7d91d15e084d1051238f4b95e06204fe228dbb6e0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/lisp-sitter")
    elisp.install "editor/lisp-sitter.el"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lisp-sitter --version")

    (testpath/"test.el").write("(defun hello () 42)\n")
    assert_match "hello", shell_output("#{bin}/lisp-sitter tree #{testpath}/test.el")
  end
end
