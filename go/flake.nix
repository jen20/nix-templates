{
  description = "Go development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    go-overlay.url = "github:purpleclay/go-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      go-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ go-overlay.overlays.default ];
        };

        go = pkgs.go-bin.fromGoMod ./go.mod;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # Go toolchain (version per go.mod file), with delve, gofumpt,
            # golangci-lint, gopls, govulncheck and staticcheck.
            go.withDefaultTools

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
