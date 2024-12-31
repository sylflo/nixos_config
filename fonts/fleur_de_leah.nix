{ lib, fetchurl, stdenv, fontconfig }:

stdenv.mkDerivation {
  name = "fleur-de-leah-font";
  src = fetchurl {
    url = "https://github.com/google/fonts/raw/main/ofl/fleurdeleah/FleurDeLeah-Regular.ttf";
    sha256 = "0zdsrjdxvvzym1z48ryny62jmab7lihg0y6gyrnccd98sndw3xhi";
  };
  nativeBuildInputs = [ fontconfig ]; # Add fontconfig as a native build input
  phases = [ "installPhase" ]; # Skip unpackPhase
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/FleurDeLeah-Regular.ttf
    # TODO
    #fc-cache -f -v
  '';
}

