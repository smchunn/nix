{
  stdenv,
  fetchurl,
  unzip,
  docker,
  iosevka-sc,
}:
stdenv.mkDerivation rec {
  pname = "iosevka-nf";
  version = "1.0.0";

  src = iosevka-sc;

  nativeBuildInputs = [unzip docker];

  buildPhase = ''
    mkdir -p fonts patched
    cp ${src}/share/fonts/truetype/*.ttf fonts/
    docker run --rm -v $(pwd)/fonts:/in:Z -v $(pwd)/patched:/out:Z nerdfonts/patcher --complete --progressbars
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp patched/*.ttf $out/share/fonts/truetype/
  '';

  meta = with stdenv.lib; {
    description = "Iosevka font patched with Nerd Fonts";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
  };
}
