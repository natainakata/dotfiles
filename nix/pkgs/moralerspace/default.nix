{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "moralerspace";
  version = "1.0.2";

  src = fetchzip {
    url = "https://github.com/yuru7/moralerspace/releases/download/v${version}/Moralerspace_v${version}.zip";
    hash = "sha256-lOfEq9HDjUMDJ+whAr/0jmcA/ftmJCz41FeMvBGclH8=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 *.ttf -t $out/share/fonts/moralerspace
    runHook postInstall
  '';

  meta = with lib; {
    description = "Programming font that combines IBM Plex Sans JP and Monaspace ";
    homepage = "https://github.com/yuru7/moralerspace";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
