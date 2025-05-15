{
  stdenv,
  lib,
  fetchurl,
  patchedFonts ? ./patched-fonts/patched,
}:
stdenv.mkDerivation rec {
  pname = "iosevka-nf";
  version = "1.0.0";

  src = patchedFonts;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp ${src}/*.ttf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Pre-patched Iosevka Nerd Font";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
