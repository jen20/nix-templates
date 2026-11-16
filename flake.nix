{
  description = "Nix flake templates for my projects";

  outputs =
    { self }:
    {
      templates = {
        bazel = {
          path = ./bazel;
          description = "Bazel project with Bazelisk and a Bazel module";
          welcomeText = ''
            Next steps:

            - Change the module name in `MODULE.bazel`.
            - Run `git init` if this is not a Git repository yet.
            - Run `git add -A` to stage the files. Nix ignores files that Git does not track.
            - Run `direnv allow` to enter the development shell.
          '';
        };

        go = {
          path = ./go;
          description = "Go module with the go-overlay toolchain and tools, and prek hooks for Go";
          welcomeText = ''
            Next steps:

            - Change the module path in `go.mod`.
            - Run `git init` if this is not a Git repository yet.
            - Run `git add -A` to stage the files. Nix ignores files that Git does not track.
            - Run `direnv allow` to enter the development shell. It installs the prek hooks.
          '';
        };

        rust = {
          path = ./rust;
          description = "Rust crate with the rust-overlay toolchain, and prek hooks for Rust";
          welcomeText = ''
            Next steps:

            - Change the package name in `Cargo.toml`.
            - Run `git init` if this is not a Git repository yet.
            - Run `git add -A` to stage the files. Nix ignores files that Git does not track.
            - Run `direnv allow` to enter the development shell. It installs the prek hooks.
          '';
        };
      };
    };
}
