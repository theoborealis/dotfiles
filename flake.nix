{
  inputs = {
    nixpkgs.url = "nixpkgs/d599e459065269b8e0de294ccc73b28ba30ab480";
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
        "${linuxUser}@vps" = import ./vps {
          inherit inputs;
          username = linuxUser;
        };
      };
    };
}
