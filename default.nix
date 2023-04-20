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

  sourceRoot = ".";


  installPhase = ''
    # install -m755 -D studio-link-standalone-v${version} $out/bin/studio-link
    install -v -b -Dm644 src/skfde.conf "$(DESTDIR)/etc/skfde.conf"

    install -Dm644 src/hooks/skfde "$out/lib/initcpio/hooks/skfde"
    install -Dm644 src/install/skfde "$out/lib/initcpio/install/skfde"
    install -Dm755 src/skfde-enroll "$out/bin/skfde-enroll"
    install -Dm755 src/skfde-format "$out/bin/skfde-format"
    install -Dm755 src/skfde-open "$out/bin/skfde-open"
    install -Dm755 src/skfde-load "$out/bin/skfde-load"
    install -Dm755 src/skfde-cred "$out/bin/skfde-cred"
    #install -Dm644 README.md "$out/share/doc/skfde/README.md"
  '';

  postInstall = ''
    wrapProgram $out/bin/skfde --prefix PATH : '${lib.makeBinPath [ pkgs.pandoc ]}'
  '';
}
