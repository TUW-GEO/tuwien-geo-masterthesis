{
  description = "Tools required by this repository that are not packaged in nixpkgs";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        gotpm = pkgs.callPackage ./gotpm.nix { };
        tytanic = pkgs.callPackage ./tytanic.nix { };
        typst-package-check = pkgs.callPackage ./typst-package-check.nix { };
      });
    };
}
