{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      crane,
      treefmt-nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        craneLib = crane.mkLib pkgs;
        src = craneLib.cleanCargoSource ./.;
        libs = [ ];
        commonArgs = {
          inherit src;
          strictDeps = true;

          buildInputs = libs;
        };

        cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        crate = craneLib.buildPackage (
          commonArgs
          // {
            inherit cargoArtifacts;
          }
        );
      in
      {
        packages = {
          default = crate;
        };

        devShell = craneLib.devShell {
          packages = [
            pkgs.rust-analyzer
            pkgs.just
          ];

          env = {
            # Required by rust-analyzer
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            # Required to make `cargo run` work.
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
          };
        };

        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
        };
      }
    );
}
