{
  stdenv,
  lib,
  fetchFromGitHub,
  python3,
  fontforge,
}:
stdenv.mkDerivation rec {
  pname = "nerd-font-patcher";
  version = "3.2.1";

  src = fetchFromGitHub {
    owner = "ryanoasis";
    repo = "nerd-fonts";
    rev = "v${version}";
    sha256 = "10jmpbmrd05v04pai4gc82wlyjzg9jv7ckzr25xwbv8cjp1d8qx8"; # Update if necessary
  };

  nativeBuildInputs = [python3 fontforge];

  installPhase = ''
    mkdir -p $out/bin
    cp font-patcher $out/bin/nerd-font-patcher
    chmod +x $out/bin/nerd-font-patcher
  '';

  meta = with lib; {
    description = "Nerd Fonts font patcher";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
