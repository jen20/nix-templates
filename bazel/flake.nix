{
  description = "Bazel development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        bazel = pkgs.symlinkJoin {
          name = "bazel";
          paths = [ pkgs.bazelisk ];
          postBuild = ''
            ln -s $out/bin/bazelisk $out/bin/bazel
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.bazelisk
            bazel
          ];
        };
      }
    );
}
