{
  lib,
  agent-skills,
  anthropic,
  vercel,
  find-skills,
  mattpocock,
  karpathy,
  mermaid-architect,
  ...
}:
{
  imports = [
    (import "${agent-skills.outPath}/modules/home-manager/agent-skills.nix" {
      inherit lib;
      inputs = { };
    })
  ];

  programs.agent-skills = {
    enable = true;
    sources = {
      anthropic = {
        path = anthropic;
        subdir = "skills";
      };
      vercel = {
        path = vercel;
        subdir = "skills";
      };
      find-skills = {
        path = find-skills;
        subdir = "skills";
      };
      mattpocock = {
        path = mattpocock;
        subdir = "skills/productivity";
      };
      karpathy = {
        path = karpathy;
        subdir = "skills";
      };
      mermaid-architect = {
        path = mermaid-architect;
	# subdir = "skills";
      };
    };
    skills.enable = [
      # vercel-labs/skills
      "find-skills"
      # vercel-labs/agent-skills
      "web-design-guidelines"
      "react-view-transitions"
      "react-best-practices"
      # mattpocock/skills
      "grill-me"
      "grilling"
      # forrestchang/andrej-karpathy-skills
      "karpathy-guidelines"
      "mermaid-architect"
    ];
    targets = {
      claude = {
        dest = ".claude/skills";
        structure = "copy-tree";
      };
      agents = {
        dest = ".agents/skills";
        structure = "copy-tree";
      };
    };
  };
}
