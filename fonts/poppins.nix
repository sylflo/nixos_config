{ lib, fetchurl, stdenv, fontconfig }:

stdenv.mkDerivation {
  name = "poppins-regular";
  src = fetchurl {
    url = "https://raw.githubusercontent.com/google/fonts/refs/heads/main/ofl/poppins/Poppins-Regular.ttf";
    sha256 = "7e65201e9b79159e2300267cc885e16c8dcef2424cdfa09a29bfb0980a94a7ba";
  };
  nativeBuildInputs = [ fontconfig ]; # Add fontconfig as a native build input
  phases = [ "installPhase" ]; # Skip unpackPhase
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/Poppins-Regular.ttf
    # TODO
    #fc-cache -f -v
  '';
}

