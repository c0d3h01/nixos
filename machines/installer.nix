{
  inputs,
  lib,
  ...
}:

let
  autoImportModules =
    dir:
    let
      contents = builtins.readDir dir;
      filteredContents = lib.attrsets.filterAttrs (
        name: type: !(lib.strings.hasPrefix "_" name)
      ) contents;

      # Process each item
      modules = lib.attrsets.mapAttrsToList (
        name: type:
        let
          path = "${dir}/${name}";
        in
        if type == "directory" then
          autoImportModules path
        else if type == "regular" && lib.strings.hasSuffix ".nix" name then
          import path
        else
          null
      ) filteredContents;
    in
    lib.lists.flatten (lib.lists.filter (x: x != null) modules);
  theImports = ./installer;

in
{
  imports = [ inputs.disko.nixosModules.disko ] ++ (autoImportModules theImports);
}
