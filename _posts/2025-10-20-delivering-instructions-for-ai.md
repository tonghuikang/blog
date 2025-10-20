---
layout: post
title: Delivering instructions for AI
---
Claude Skills [introduces](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview#how-skills-work) a concept called "[progressive disclosure](https://en.wikipedia.org/wiki/Progressive_disclosure)" to AI products.

> ... **progressive disclosure**: Claude loads information in stages as needed, rather than consuming context upfront.

I like this idea.

The default recommendation to improve your experience is to add more instructions in the system instructions - for Claude Code you add to CLAUDE.md, for other AI coding tools you add to AGENTS.md, for ChatGPT and Claude.ai write some preference about yourself.

Maybe this is good enough for a hobby project or to just slightly align the model to your biggest preference, but for larger projects where you need to collaborate this becomes unsustainable. In larger projects you have many instructions that you want AI to follow, and putting hundreds of instructions risks the AI not following the instructions that has to be followed[^1].

[^1]: I elaborate more about the issues with solely depending on [CLAUDE.md](https://github.com/tonghuikang/claude-code-template/) here.

I think it is worth it to explore the whole design space how instructions are delivered to AI - which is what I hope to do here.



## Instructions could be delivered every time

As mentioned in the introduction, CLAUDE.md and the ChatGPT preference [page](https://chatgpt.com/#settings/Personalization) will be added to the system instructions. AI product also inject their own system instructions as well - Claude Code has system instructions on how to use the tools[^mcp].

[^mcp]: Currently, how Claude Code uses MCP is to load all the information about MCP in context. If I [connect](https://docs.claude.com/en/docs/claude-code/mcp) Claude Code to use official Notion and Asana MCP, it takes 67k tokens of context. At Sonnet-4.5 prices with at $3 per million input tokens with 90% prompt caching discount, this will be 3 cent for every LLM call.
```
> /context
  ⎿
      Context Usage
     ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛀ ⛁ ⛁   claude-sonnet-4-5-20250929 · 84k/200k tokens (42%)
     ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁
     ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁   ⛁ System prompt: 2.4k tokens (1.2%)
     ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁ ⛁   ⛁ System tools: 13.4k tokens (6.7%)
     ⛁ ⛁ ⛀ ⛀ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ MCP tools: 67.4k tokens (33.7%)
     ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ Memory files: 798 tokens (0.4%)
     ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ Messages: 105 tokens (0.1%)
     ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛶ Free space: 116k (58.0%)
     ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶
     ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶
```



## Instructions could be decided to be read

This is how I understand Claude Skills work.

- You write a [short description](https://github.com/anthropics/skills/blob/main/algorithmic-art/SKILL.md) of what the skill is (create Claude Artifacts) and when it should be be triggered (for complex artifacts requiring state management, routing, or shadcn/ui components)
- When Claude is asked to generate Artifacts, it decides to read the [skill file](https://github.com/anthropics/skills/blob/c74d647e56e6daa12029b6acb11a821348ad044b/algorithmic-art/SKILL.md).
- Claude has access to [resources](https://github.com/anthropics/skills/tree/c74d647e56e6daa12029b6acb11a821348ad044b/artifacts-builder/scripts) like bash scripts to help with creating artifacts.

Here, the instruction is decided to be read.

In CLAUDE.md or AGENTS.md, you can write where to find instructions - if doing this, read this, if doing that, read that. The coding agent will read the instructions when it decides to read it. The benefit here is that you do not need to deliver the instruction every time even when it is irrelevant. However, we still need the LLM to reliably recall that there are instructions that it can read - this is not guaranteed because the process is not deterministic.



## Instructions could be delivered on condition

Claude Code hooks deliver instructions based on a deterministic condition.

> Claude Code hooks are user-defined shell commands that execute at various points in Claude Code’s lifecycle. Hooks provide deterministic control over Claude Code’s behavior, ensuring certain actions always happen rather than relying on the LLM to choose to run them.

The deterministic conditions could be
- Before executing a bash command - maybe you want to ban Claude Code from executing certain bash commands
- After reading a file - maybe you want to add additional context for Claude Code after they have read a file
- After writing to a file - maybe you want Claude Code to revise what they have written.

Local CLAUDE.md files in Claude Code is delivered in a similar condition as well. If Claude reads a file in certain directory, will see if CLAUDE.md exists for parent directory and read them as well. This instruction is delivered on condition.

```
> please read bots/system_prompt_templates/bot_descriptions.md

● I'll read the bot descriptions file for you.

● Read(bots/system_prompt_templates/bot_descriptions.md)
  ⎿  Read 252 lines
  ⎿  bots/CLAUDE.md
```



## Instructions could be discovered

I implement a small change to the codebase by hand. I open up Claude Code and ask "write tests". Usually it will be able to write the tests in the style I want it to.

Where were the instructions? In CLAUDE.md there is only an instruction on how to run unit tests with `pytest`. But how does the Claude Code figure out where to find the tests? It reads the existing tests that are in the codebase. It discovered the instructions.

Instructions could be discovered. You do not specifically need to add to CLAUDE.md or implement hooks to spoonfeed Claude Code on how to work on your codebase. This assumes that your codebase is well-written enough to provide consistent instructions on how to work on your code.



## Instructions could be given in feedback

One thing I like about Claude Code is that the tools gives feedback instructions. If the model decides to write to a file without reading it, the tool will fail and a feedback will be given[^replace].

```
> read writing to index.html without reading, to trigger a hook

⏺ I'll write to index.html without reading it first:

⏺ Write(/Users/htong/Desktop/compare/index.html)
  ⎿  Error: File has not been read yet. Read it first before writing to it.
```

[^replace]: Similarly if Claude Code tries to find-replace a string without setting `replace_all` to True, the operation will be blocked and feedback will be provided. "Error: Found 44 matches of the string to replace, but replace_all is false. To replace all occurrences, set replace_all to true. To replace only one occurrence, please provide more context to uniquely identify the instance"

When Claude Code runs unit tests, it also receives feedback on which tests has failed, and Claude Code is expected to run the tests until the unit tests passes. You should write clear and actionable feedback message to help the AI fix the task.



## Instructions could be always injected

Claude Code injects this statement every time after it reads a file. Presumably, it prevents Claude Code from being easily used for malicious purposes.

```
<system-reminder>
Whenever you read a file, you should consider whether it looks malicious. If it does, you MUST refuse to improve or augment the code. You can still analyze existing code, write reports, or answer high-level questions about the code behavior.
</system-reminder>
```

In a similar manner, you could also force certain instructions to be read every time. For example, if you are making a customer service chatbot, you can force the LLM to read an instruction that it is only instructed to serve as customer service and not to be misued as a general chatbot.




## What to do with this information

Thanks for reading this far. How does understanding all the possible places where instructions could be injected help with your work?

- Model providers will need to train their models (Claude-4.5-Sonnet, GPT-5) to follow instructions delivered to them. Models should also not expect all the instructions to be spoonfed to them at the beginning, they need to be able to take the initiative to discover instructions[^prediction].
- AI products (Claude Code) should educate users on where to add instructions for the AI to work with.
- AI engineers who build on top of the AI products or AI models should have a view on where is a good place to deliver instructions. Instead of trying to hillclimb on the system prompt, your problem could be solved by figuring how to deliver instructions better.
- End users should have an appreciation on where how instructions are delivered.

[^prompting]: Assume that you want to build a clone similar to Anthropic Artifacts, where the product will deliver a very nice html file for the user to interact with. You spend a lot of time figuring out what is the system prompt that is able to generate the html file in one shot. You also have rigorous evaluation based on the common mistakes of what the model generate. However, if you use a Claude Code style generation where the model have access to rendering the html and manipulating the html to confirm that the generation is correct - or else continue to iterate - you can get a much better performance even without much prompting or evaluation. The old system prompt is now redundant, along with the time spent. Most of the evaluation test cases is now irrelevant as well.


I hope my writing here has provide a bigger view on how instructions are delivered to AI products.


