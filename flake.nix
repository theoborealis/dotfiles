{
  inputs = {
    nixpkgs.url = "nixpkgs/14f7db3ba24eed9e904a2ed004aec78c2fcb8af2";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ ... }:
    let
      linuxUser = "admin";
      androidUser = "u0_a305";
    in {
      homeConfigurations = {
        "${androidUser}@android" = import ./android {
          inherit inputs;
          username = androidUser;
        };
        "${linuxUser}@linux" = import ./linux {
          inherit inputs;
          username = linuxUser;
        };
      };
    };
}
