{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = with inputs.stylix.nixosModules; [ stylix ];

  stylix = {
    enable = true;
    image = ../../assets/wallpapers/image1.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
}
