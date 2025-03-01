{
  description = "pbrt devenv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = {
    nixpkgs
    , ...
  }:
  {
    devShells."aarch64-darwin".default = let
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
      };
    in pkgs.mkShell {
      packages = []
        ++ (with pkgs; [
          clang
          lldb
          cmake
        ])
        ++ (with pkgs.darwin.apple_sdk.frameworks; [
          Cocoa
          IOKit
          CoreFoundation
          Kernel
        ]);
      shellHook = ''
        exec zsh
      '';
    };

    devShells."x86_64-linux".default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        clang
        lldb
        cmake
        pkg-config
        wayland
        wayland-protocols
        wayland-scanner
        libGL
        libxkbcommon
        zlib
      ];
      shellHook = ''
        exec elvish
      '';
    };
  };
}
