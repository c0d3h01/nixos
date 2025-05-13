{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  home.sessionVariables.MOZ_USE_XINPUT2 = "1";
  programs.firefox = lib.mkForce {
    enable = true;
    package = pkgs.firefox-esr;

    profiles.${userConfig.username} = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        link-cleaner
      ];

      settings = {
        # Core privacy settings
        "browser.send_pings" = false;
        "network.cookie.cookieBehavior" = 1;
        "privacy.resistFingerprinting" = false;
        "network.http.referer.XOriginPolicy" = 0;
        "dom.security.https_only_mode_ever_enabled" = true;
        "geo.enabled" = false;

        # Disable telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";

        # Disable Pocket
        "extensions.pocket.enabled" = false;

        # Performance settings
        "browser.cache.disk.enable" = true;
        "browser.cache.memory.enable" = true;

        # Media and DRM (for streaming services)
        "media.eme.enabled" = true;
        "media.gmp-widevinecdm.enabled" = true;

        # UI preferences
        "browser.uidensity" = 0; # Compact mode for more screen space
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab"; # Only show on new tab
        "browser.tabs.inTitlebar" = false; # Separate tabs from title bar for cleaner look
        "browser.compactmode.show" = true; # Enable compact mode option

        # Minimize UI
        "browser.chrome.toolbar_tips" = false;
        "browser.tabs.firefox-view" = false; # Disable Firefox View button
        "browser.tabs.tabClipWidth" = 140; # Ensure tabs aren't too narrow
        "browser.tabs.tabMinWidth" = 100;

        # Colorful vibrant UI settings
        "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # Clean new tab
        "browser.theme.content-theme" = 0; # Let our custom theme control colors
        "browser.theme.toolbar-theme" = 0;

        # Smooth scrolling
        "general.smoothScroll" = true;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 400;
        "general.smoothScroll.mouseWheel.durationMinMS" = 200;

        # Animation settings
        "toolkit.cosmeticAnimations.enabled" = true;
      };

      userChrome = "
          * {
              box-shadow: none !important;
              border: 0px solid !important;
          }

          #tabbrowser-tabs {
              --user-tab-rounding: 8px;
          }

          .tab-background {
              border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important;
              margin-block: 1px 0 !important;
          }

          #scrollbutton-up, #scrollbutton-down {
              border-top-width: 1px !important;
              border-bottom-width: 0 !important;
          }

          .tab-background:is([selected], [multiselected]):-moz-lwtheme {
              --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
              border-bottom-color: transparent !important;
          }

          [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
              --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
              border-bottom-color: transparent !important;
          }

          /* Container color bar visibility */
          .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
              margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
          }

          #TabsToolbar, #tabbrowser-tabs {
              --tab-min-height: 29px !important;
          }

          #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar,
          #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
              --tab-min-height: 30px !important;
          }

          #scrollbutton-up,
          #scrollbutton-down {
              border-top-width: 0 !important;
              border-bottom-width: 0 !important;
          }

          #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
              max-height: calc(var(--tab-min-height) + 1px) !important;
          }

          #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon,
          #TabsToolbar-customization-target .toolbarbutton-text,
          #TabsToolbar-customization-target .toolbarbutton-badge-stack,
          #scrollbutton-up,#scrollbutton-down {
              padding-top: 7px !important;
              padding-bottom: 6px !important;
          }
        ";
    };
  };
}
