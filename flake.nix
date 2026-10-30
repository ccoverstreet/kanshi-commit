{
  description = "Utility for configuring display settings";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    perSystem = { config, pkgs, inputs',... }:
    let 
      dependencies = [
      ];
    in rec {
      packages.default = pkgs.rustPlatform.buildRustPackage {
        pname = "kanshi-commit";
        version = "0.1.0";

        src = self;
        cargoLock = {
          lockFile = ./Cargo.lock;
        };

        nativeBuildInputs = dependencies ++ [ ];
        buildInputs = dependencies;

        postInstall = ''
        '';
      };


      devShells.default = pkgs.mkShell {
        buildInputs = [ pkgs.cargo ]; 
      };
    };
  });
}
