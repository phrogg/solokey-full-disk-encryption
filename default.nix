{ pkgs ? import <nixpkgs> { }
, lib ? import <nixpkgs/lib>
}:
pkgs.stdenv.mkDerivation rec {
  pname = "skfde";
  version = "0.1.1";

  src = [ ./. ];

  #cargoDeps = pkgs.rustPlatform.importCargoLock {
  #  lockFile = ./Cargo.lock;
  #  outputHashes = {
  #    "nix-data-0.0.2" = "sha256-8j3j+Bk90eBBqQkguwU0tTtMU7Zecjhr1SbW5hnptFY=";
  #  };
  #};

  nativeBuildInputs = with pkgs; [
    git
    gnumake
  ];

  buildInputs = with pkgs; [
    #glib
  ];

  postInstall = ''
    wrapProgram $out/bin/skfde --prefix PATH : '${lib.makeBinPath [ pkgs.pandoc ]}'
  '';
}
