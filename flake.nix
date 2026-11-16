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
      };
    };
}
