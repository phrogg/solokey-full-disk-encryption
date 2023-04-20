{ pkgs ? import <nixpkgs> { }
, lib ? import <nixpkgs/lib>
, autoPatchelfHook
}:
pkgs.stdenv.mkDerivation rec {
  pname = "skfde";
  version = "0.1.1";

  #src = [ ./. ];

  src = pkgs.fetchgit {
    url = "https://github.com/phrogg/solokey-full-disk-encryption";
    rev = "e60d41d0fbb6f26fd5f702e731516affc0bbfcd2";
    sha256 = "sha256-mzNERqOPxjojVR1jGe+1luPwNN5QrZUsxESirpR8cuM=";
  };


  tiveBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    #glib
  ];

  # sourceRoot = ".";


  installPhase = ''
    # install -m755 -D studio-link-standalone-v${version} $out/bin/studio-link
    install -v -b -Dm644 src/skfde.conf "$out/etc/skfde.conf"
    print $src
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
    # wrapProgram $out/bin/skfde --prefix PATH : '${lib.makeBinPath [ pkgs.pandoc ]}'
  '';
}
