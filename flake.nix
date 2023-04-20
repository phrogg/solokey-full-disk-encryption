{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages = let
          skfde = pkgs.callPackage ./default.nix {};
        in {
          inherit skfde;
          default = skfde;
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            fido2luks
            #cargo
          ];
          #RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
        };
      });
}
