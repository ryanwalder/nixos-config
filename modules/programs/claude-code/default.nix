{...}: {
  flake.modules.homeManager.program_claude-code = {pkgs, ...}: {
    home.packages = with pkgs; [
      claude-code
    ];

    home.file.".claude/memory".source = ./memory;

    home.file.".claude/CLAUDE.md".source =
      pkgs.runCommand "claude-global-md" {} ''
        cat ${./memory}/feedback_*.md > $out
      '';
  };
}
