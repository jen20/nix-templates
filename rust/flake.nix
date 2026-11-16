{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

        # Rust toolchain (channel and components per rust-toolchain.toml).
        rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rust

            # Pre-commit lint runner
            pkgs.prek

            # Shell script linter
            pkgs.shellcheck
          ];

          shellHook = ''
            # Install the prek Git shim if it is not there yet.
            if hooks_dir=$(git rev-parse --git-path hooks 2>/dev/null) \
              && ! grep -qs prek "$hooks_dir/pre-commit"; then
              prek install --config prek.toml \
                || echo "Could not install the prek hooks; run 'prek install --config prek.toml' to see why." >&2
            fi
          '';
        };
      }
    );
}
