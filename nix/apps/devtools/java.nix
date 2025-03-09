{ pkgs
, ...
}:

{
  environment.systemPackages = (with pkgs; [
    zulu23 # java
    jdt-language-server
  ]);
}

