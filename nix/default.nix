{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  zlib,
  openexr,
  pkg-config,
  wayland,
  wayland-protocols,
  wayland-scanner,
  libGL,
  libxkbcommon,
  apple-sdk,
}:
stdenv.mkDerivation {
  pname = "pbrt-v4";
  version = "dev";

  src = fetchFromGitHub {
    owner = "mmp";
    repo = "pbrt-v4";
    rev = "f140d7c";
    fetchSubmodules = true;
    sha256 = "sha256-xFKRoH3M4O1sUGtZCWJBL7MiXQGEBw1sk5N0NMzgasM=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  cmakeFlags = [
    "-DBUILD_TESTING=ON"
  ];

  buildInputs =
    [
      zlib
      openexr
    ]
    ++ lib.optional stdenv.hostPlatform.isLinux [
      pkg-config
      wayland
      wayland-protocols
      wayland-scanner
      libxkbcommon
      libGL
    ]
    ++ lib.optional stdenv.hostPlatform.isDarwin [
      apple-sdk
    ];

  meta = with lib; {
    description = "Source code to pbrt, the ray tracer described in the forthcoming 4th edition of the \"Physically Based Rendering: From Theory to Implementation\" book.";
    homepage = "github.com/mmp/pbrt-v4";
    license = licenses.asl20;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
