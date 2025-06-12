{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Enable Android development tools
  android = {
    enable = true;

    # Enable Flutter specific setup
    flutter = {
      enable = true;
      # package = pkgs.flutter; # This is the default Flutter SDK package
    };

    # Optionally enable Android Studio for a more complete IDE experience
    # and device management, though VS Code with Flutter extension is also common.
    # android-studio = {
    #   enable = true;
    #   # package = pkgs.android-studio; # This is the default Android Studio package
    # };

    # Most Android SDK component versions (buildTools, cmdLineTools, platformTools, platforms, NDK, CMake)
    # are automatically configured to be compatible with Flutter when android.flutter.enable is true.
    # You can override them if specific versions are needed, for example:
    buildTools.version = [ "34.0.0" ];
    # platforms.version = [ "34" ];

    # Emulator, NDK, and System Images are enabled by default which is generally desired for Flutter.
    emulator.enable = true;
    ndk.enable = true;
    # systemImages.enable = true;
  };

  # You might want to add other useful packages for development
  packages = [
    # pkgs.git # For version control
    # pkgs.vscode # If you use VS Code as your primary editor
  ];

  enterShell = ''
    echo "Flutter development environment is ready."
    echo "Run 'flutter doctor' to check your setup and see if any additional steps are needed."
    # flutter doctor # Uncomment to run flutter doctor automatically on shell entry
  '';
}
