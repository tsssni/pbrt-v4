{
  description = "pbrt devenv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      lib = nixpkgs.lib;

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      mapSystems = f: systems |> lib.map f |> lib.mergeAttrsList;

      packages = mapSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          "${system}".default = pkgs.callPackage ./nix { cudaSupport = true; };
        }
      );

    in
    {
      inherit packages;
    };
}
