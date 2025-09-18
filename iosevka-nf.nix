{
  lib,
  stdenv,
  iosevka-sc,
  nerd-font-patcher,
  fontforge,
  python3,
}:
stdenv.mkDerivation rec {
  pname = "iosevka-scnf";
  version = "1.0.0";

  src = iosevka-sc;

  nativeBuildInputs = [unzip fontforge python3 nerd-font-patcher];

  buildPhase = ''
    mkdir -p fonts patched
    cp ${src}/share/fonts/truetype/*.ttf fonts/
    for f in fonts/*.ttf; do
      font-patcher --complete --quiet --outputdir patched "$f"
    done
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp patched/*.ttf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Iosevka font patched with Nerd Fonts symbols";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
