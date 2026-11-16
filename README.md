# nix-templates

This repository holds Nix flake templates for different types of project. Each template sets up a new project with the tools, layout, and configuration that I prefer.

The templates reflect my personal preferences. They are not general-purpose defaults, but you can use them or adapt them for your own projects.

## Usage

To see the available templates, run:

```sh
nix flake show github:jen20/nix-templates
```

To start a new project from a template, run this command in an empty directory:

```sh
nix flake init -t github:jen20/nix-templates#<template>
```

To create the project in a new directory instead, run:

```sh
nix flake new -t github:jen20/nix-templates#<template> <directory>
```

Replace `<template>` with the name of a template.

## Templates

| Template | Description |
| -------- | ----------- |
| [`bazel`](#bazel) | Bazel project with Bazelisk in the development shell and an empty Bazel module. |

### bazel

To start a project from this template, run:

```sh
nix flake init -t github:jen20/nix-templates#bazel
```

The template contains these files:

| File | Purpose |
| ---- | ------- |
| `flake.nix` | Development shell with Bazelisk, and a `bazel` command that runs Bazelisk. |
| `.envrc` | Loads the development shell through direnv. |
| `.bazelversion` | Sets the Bazel version that Bazelisk downloads. |
| `.bazelrc` | Puts the Bazel output symlinks in `.bazel/`. |
| `MODULE.bazel` | Bazel module named `project`, with `bazel_lib` as its only dependency. |
| `.gitignore` | Ignores `.direnv/`, `.bazel/`, and `.idea/`. |

After you create the project, change the module name in `MODULE.bazel`. If the directory is not a Git repository, run `git init`. Then run `git add -A` to stage the template files. In a Git repository, Nix reads only the files that Git tracks, so the development shell does not load before you stage `flake.nix`. Then run `direnv allow` to enter the development shell.

## Adding a template

1. Create a directory for the template at the repository root.
2. Add a `flake.nix` and the other starter files to that directory.
3. Add an entry for the template under `templates` in the root `flake.nix`.
4. Add a row for the template to the table in this README.
5. Add a section for the template under the table. Give the command to start a project and list the files in the template.
6. Add the template to the matrix in `.github/workflows/templates.yml`. Give the commands that build the project.

## Continuous integration

The `Templates` workflow creates a project from each template on Linux and macOS. It enters the development shell of the project and builds the project.

The templates do not commit a `flake.lock`, so each run uses the latest inputs. The workflow also runs each night, to find breakage that comes from upstream changes.
