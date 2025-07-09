{
  pkgs,
  ...
}:

{
  security.acme.acceptTerms = true;
  security.acme.email = "harshalswant.dev@gmail.com";
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "c0d3h01" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          root = "${pkgs.nginx}/html";
          proxyPass = "http://localhost:3000";
          # extraConfig = ''
          #   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          #   proxy_set_header X-Forwarded-Proto $scheme;
          # '';
        };
      };
    };
  };
}
