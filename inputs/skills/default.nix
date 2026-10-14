{
  lib,
  agent-skills,
  anthropic,
  vercel,
  find-skills,
  mattpocock,
  karpathy,
  mermaid-architect,
  file-search-skill,
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
      mattpocock-engineering = {
        path = mattpocock;
        subdir = "skills/engineering";
      };
      karpathy = {
        path = karpathy;
        subdir = "skills";
      };
      mermaid-architect = {
        path = mermaid-architect;
	# subdir = "skills";
      };
      file-search-skill = {
        path = file-search-skill;
        subdir = "skills";
      };
    };
    skills.enable = [
      # vercel-labs/skills
      # "find-skills"
      # vercel-labs/agent-skills
      "web-design-guidelines"
      "react-view-transitions"
      "react-best-practices"
      # mattpocock/skills - productivity
      "grill-me"
      "grilling"
      "handoff"
      "teach"
      "to-questionnaire"
      "wait-what"
      "writing-for-agents"
      # mattpocock/skills - engineering
      "ask-matt"
      "grill-with-docs"
      "triage"
      "improve-codebase-architecture"
      "setup-matt-pocock-skills"
      "to-spec"
      "to-tickets"
      "implement"
      "implement-spec"
      "wayfinder"
      "prototype"
      "diagnosing-bugs"
      "research"
      "tdd"
      "domain-modeling"
      "codebase-design"
      "code-review"
      "pr"
      "retro"
      "wizard"
      # forrestchang/andrej-karpathy-skills
      "karpathy-guidelines"
      "mermaid-architect"
      # file-search-skill
      "file-search"
    ];
    targets = {
      claude = {
        dest = "~/.claude/skills";
        structure = "copy-tree";
      };
      claude-work = {
        dest = "~/.claude-work/skills";
        structure = "copy-tree";
      };
      claude-personal = {
        dest = "~/.claude-personal/skills";
        structure = "copy-tree";
      };
      agents = {
        dest = "~/.agents/skills";
        structure = "copy-tree";
      };
      bob = {
        dest = "~/.bob/skills";
        structure = "copy-tree";
      };
    };
  };
}
