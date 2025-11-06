{
  inputs, ...
}:
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          notion-app-enhanced = prev.notion-app-enhanced.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
              final.asar
              final.dos2unix
              final.patch
            ];

            postExtract = (old.postExtract or "") + ''
              ${final.asar}/bin/asar extract $out/resources/app.asar app
              ${final.dos2unix}/bin/dos2unix app/renderer/preload.js
              patch app/renderer/preload.js ${./loading.patch}
              ${final.dos2unix}/bin/unix2dos app/renderer/preload.js
              ${final.asar}/bin/asar pack app $out/resources/app.asar
              rm -rf app
            '';
          });
        })
      ];
    };
  };
}
