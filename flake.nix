{
  description = "pbrt devenv";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

  outputs = { 
    nixpkgs
    , ...
  }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells."${system}".default = pkgs.mkShell {
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
  };
}
