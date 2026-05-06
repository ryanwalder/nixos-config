{...}: {
  flake.modules.homeManager.program_discord = {...}: {
    programs.nixcord = {
      enable = true;
      discord.equicord.enable = true;
      discord.vencord.enable = false;

      config = {
        autoUpdate = false;

        plugins = {
          BlurNSFW.enable = false;
          fixYoutubeEmbeds.enable = true;
          noF1.enable = true;
          noSystemBadge.enable = true;
          selfForward.enable = true;
          youtubeAdblock.enable = true;

          declutter = {
            enable = true;
            removeGiftButton = true;
            removeNameplate = true;
            removeProfileEffect = true;
            removeQuestsAboveDM = true;
            removeShopAboveDM = true;
            removeUnavailableEmojiPicker = true;
          };

          fakeNitro = {
            enable = true;
            enableEmojiBypass = false;
            enableStickerBypass = false;
            enableStreamQualityBypass = true;
          };

          memberCount = {
            enable = true;
            memberList = false;
            toolTip = true;
          };

          newGuildSettings = {
            enable = true;
            events = true;
            everyone = true;
            guild = true;
            messages = 2;
            showAllChannels = true;
          };

          questify = {
            enable = true;
            questButtonDisplay = "never";
            disableQuestsEverything = true;
          };

          replaceGoogleSearch = {
            enable = true;
            customEngineName = "Kagi";
            customEngineURL = "https://kagi.com/search?q=";
            replacementEngine = "custom";
          };

          sendTimestamps = {
            enable = true;
          };
        };
      };
    };
  };
}
