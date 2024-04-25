{ lib, stdenv, fetchFromGitHub, autoreconfHook, allegro, libsamplerate, libX11, libXext, SDL, SDL_mixer, SDL2, SDL2_mixer, readline }:

stdenv.mkDerivation rec {
  pname = "1oom";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "1oom-fork";
    repo = "1oom";
    rev = "refs/tags/f${version}";
    hash = "sha256-sBVcPR4+MDjyOLgrB4VcVy0cDyyG5MVY9vNhWwqAhBA=";
  };

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ allegro libsamplerate libX11 libXext SDL SDL_mixer SDL2 SDL2_mixer readline ];

  outputs = [ "out" "doc" ];

  postInstall = ''
    install -d $doc/share/doc/${pname}
    install -t $doc/share/doc/${pname} \
      HACKING NEWS PHILOSOPHY README.md doc/*.txt
  '';

  meta = with lib; {
    homepage = "https://kilgoretroutmaskreplicant.gitlab.io/plain-html/";
    description = "Master of Orion (1993) game engine recreation";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = [ maintainers.AndersonTorres ];
  };
}
