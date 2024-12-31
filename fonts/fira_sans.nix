{ lib, fetchurl, stdenv, fontconfig }:

stdenv.mkDerivation {
  name = "fira-sans";
  src = fetchurl {
    url = "https://github.com/google/fonts/raw/main/ofl/firasans/FiraSans-Regular.ttf";
    sha256 = "c29556a2719bf613ef3d5e070e40d903a8965d9c081beca1375dc1e6e0f93c23";
  };
  nativeBuildInputs = [ fontconfig ]; # Add fontconfig as a native build input
  phases = [ "installPhase" ]; # Skip unpackPhase
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/FiraSans-Regular.ttf
    # TODO
    #fc-cache -f -v
  '';
}

