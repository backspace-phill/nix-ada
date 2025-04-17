{
  #inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?rev=310c5c4d3fd457d80365f52c71ac80b9d54a7cc4";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        # system = "x86_64-linux";
        # system = builtins.currentSystem;

        pkgs = import nixpkgs {
          inherit system;
          overlays = (import ./overlays.nix { });
        };

        nix-ada = import ./default.nix { inherit pkgs; };
      in
      {
        packages.${system} = nix-ada;

        devShells.default = import ./shell.nix { inherit nix-ada; };
      }
    );
}
