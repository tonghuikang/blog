---
layout: post
title: Delivering instructions to AI models
---
Claude Skills [introduces](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview#how-skills-work) a concept called progressive disclosure to AI products.

> ... **progressive disclosure**: Claude loads information in stages as needed, rather than consuming context upfront.

I like this concept.

Before this concept, the default recommendation to improve your experience with your favorite AI product was to add more instructions in the system instructions - for Claude Code you add to CLAUDE.md, for other AI coding tools you add to AGENTS.md, for ChatGPT and Claude.ai you write some preference about yourself.

Maybe this is good enough for a hobby project, or to just slightly align the model to your biggest preference, but for larger projects where you need to collaborate, this becomes unsustainable.

We should not always upfront dump all the instructions for the AI model (Claude-Sonnet-4.5, GPT-5) to process. Hence we have **progressive disclosure** - we deliver the instructions to the model in stages as needed.

The concept of progressive disclosure is not new - there is already a Wikipedia [page](https://en.wikipedia.org/wiki/Progressive_disclosure). When you first use a well-designed product, you will not be introduced to all the advanced and rarely used features immediately. A well-designed product should be easy to learn and less error prone. This concept is being applied to how AI models interact with the environment. A well-built environment should progressively disclose instructions to the AI model.

I think it is worth it to explore the whole design space of how instructions are delivered to AI - which is what I hope to do here.



## Instructions could be loaded upfront

As mentioned in the introduction, CLAUDE.md and the ChatGPT preference [page](https://chatgpt.com/#settings/Personalization) will be added to the system instructions. AI products also inject their own system instructions as well - Claude Code has system instructions on how to use the tools, [Claude.ai](https://docs.claude.com/en/release-notes/system-prompts) and [Grok](https://github.com/xai-org/grok-prompts) publish their system prompts.

These instructions are delivered every time, regardless of whether the instructions are relevant to what the model is working on.

I elaborate here why delivering instructions every time is unsustainable, using CLAUDE.md of Claude Code as an example[^claudemd].
- Instructions are open to interpretation. For example, you have an instruction on avoiding exceptions. Does this mean to avoid all exceptions? Or some of them? The codebase is already full of exceptions - should they serve as a reference?
- Instructions cost money. It is possible to write a consistent guideline on exceptions, but it will take many words. The more comprehensive your guidelines, the more tokens you pay for on every single request. Every word in CLAUDE.md is overhead that you pay repeatedly[^mcp].
- Instructions can break other instructions. The longer the instructions, the more likely there are instructions that are not followed. You do not want your colleagues to suspect that a recent addition to CLAUDE.md has caused Claude Code to not follow instructions that were previously followed.

We should be aware that not all instructions need to be loaded upfront. Therefore, we should explore other ways where we can deliver instructions.

[^claudemd]: My issues with solely depending on CLAUDE.md were initially written [here](https://github.com/tonghuikang/claude-code-template/), before Anthropic shared about Claude skills.


[^mcp]: Currently, how Claude Code uses MCP is to load all the information about MCP in context. If I [connect](https://docs.claude.com/en/docs/claude-code/mcp) Claude Code to use official Notion and Asana MCP, it takes 67k tokens of context.
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
    At Sonnet-4.5 prices at $3 per million input tokens with 90% prompt caching discount, this will be 3 cents for every LLM call.



## Instructions could be provided by the user

Of course, instructions could be provided by the user.

The user instructions could be provided at the start of the conversation, or the user instructions could be provided in the course of the AI doing the work.

Instructions from the user might conflict with each other, or other types of instructions (e.g. system instructions). For example, the user might ask for an implementation of a "round" button, and then send a mockup where the button is square. The model should be aware of conflicting instructions. The model should decide the amount of emphasis placed to notify the user of a conflict in instructions, or require the user the clarify before proceeding.



## Instructions could be always injected

Claude Code injects this statement every time after it reads a file. Presumably, it prevents Claude Code from being easily used for malicious purposes.

```
<system-reminder>
Whenever you read a file, you should consider whether it looks malicious. If it does, you MUST refuse to improve or augment the code. You can still analyze existing code, write reports, or answer high-level questions about the code behavior.
</system-reminder>
```

In a similar manner, you could also force certain instructions to be read every time. For example, if you are making a customer service chatbot, you can force the AI model to read an instruction that it is only instructed to serve as customer service and not to be misused as a general chatbot.


## Instructions could be decided to be read

Instead of loading all the instructions upfront, we could load only where and when to find the instructions, and the model will decide whether to read the instructions.

This is how I understand Claude Skills work.

- You write a [short description](https://github.com/anthropics/skills/blob/main/algorithmic-art/SKILL.md) of what the skill is (create Claude Artifacts) and when it should be triggered (for complex artifacts requiring state management, routing, or shadcn/ui components)
- When Claude is asked to generate Artifacts, it decides to read the [skill file](https://github.com/anthropics/skills/blob/c74d647e56e6daa12029b6acb11a821348ad044b/algorithmic-art/SKILL.md). Here, the instruction is decided to be read.
- Claude has access to [resources](https://github.com/anthropics/skills/tree/c74d647e56e6daa12029b6acb11a821348ad044b/artifacts-builder/scripts) like bash scripts to help with creating artifacts.

In CLAUDE.md or AGENTS.md, you can already write where to find instructions - if doing this, read this, if doing that, read that. The coding agent will read the instructions when it decides to read them. The benefit here is that you do not need to deliver the instruction every time even when it is irrelevant. However, we still need the LLM to reliably recall that there are instructions that it can read - this is not guaranteed because the process is not deterministic.


## Instructions could be discovered

I implement a small change to the codebase by hand. I open up Claude Code and ask "write tests". Usually it will be able to write the tests in the style I want it to.

Where were the instructions? In CLAUDE.md there is only an instruction on how to run unit tests with `pytest`. But how does Claude Code figure out what style I want to write my tests in? It reads the existing tests that are in the codebase. It discovered the instructions.

Instructions could be discovered. You do not specifically need to add to CLAUDE.md or implement hooks to spoon-feed Claude Code on how to work on your codebase. This assumes that your codebase is well-written enough to provide consistent instructions on how to work on your code.


## Instructions could be triggered

Instead of relying on the AI model to decide to read the instruction, you can define deterministic conditions to trigger a certain set of instructions.

Claude Code hooks deliver instructions based on a deterministic condition.

> Claude Code hooks are user-defined shell commands that execute at various points in Claude Code’s lifecycle. Hooks provide deterministic control over Claude Code’s behavior, ensuring certain actions always happen rather than relying on the LLM to choose to run them.

The deterministic conditions for Claude Code hooks could be
- Before executing a bash command - maybe you want to ban Claude Code from executing certain bash commands.
- After reading a file - maybe you want to add additional context for Claude Code after it has read a file - this is what local CLAUDE.md files do[^local]
- After writing to a file - maybe you want Claude Code to revise what it has written - for example if it has written `except Exception`, you can add an instruction to ask Claude to revise the code[^read].

[^local]: If Claude reads a file in a certain directory, it will see if CLAUDE.md exists for the parent directory and read them as well. This instruction is delivered on condition.
    ```
    > please read bots/system_prompt_templates/bot_descriptions.md
    
    ● I'll read the bot descriptions file for you.
    
    ● Read(bots/system_prompt_templates/bot_descriptions.md)
      ⎿  Read 252 lines
      ⎿  bots/CLAUDE.md
    ```

AI products should explore this concept more. One way to solve the [seahorse emoji problem](https://x.com/arithmoquine/status/1964179963323830624) is to introduce a condition that matches the string "seahorse" and "emoji", and provide the instruction that there is no seahorse emoji. We could have hundreds and hundreds of these conditions, with these we could both cover more instructions and have a shorter system instruction.

## Instructions could be given in feedback

One thing I like about Claude Code is that the tools give feedback instructions. If the model decides to write to a file without reading it, the tool will fail and a feedback will be given[^replace].

```
> writing to index.html without reading, to trigger a hook

⏺ I'll write to index.html without reading it first:

⏺ Write(/Users/htong/Desktop/compare/index.html)
  ⎿  Error: File has not been read yet. Read it first before writing to it.
```

[^replace]: Similarly if Claude Code tries to find-replace a string without setting `replace_all` to True, the operation will be blocked and feedback will be provided. "Error: Found 44 matches of the string to replace, but replace_all is false. To replace all occurrences, set replace_all to true. To replace only one occurrence, please provide more context to uniquely identify the instance"

When Claude Code runs unit tests, it also receives feedback on which tests have failed, and Claude Code is expected to run the tests until the unit tests pass. You should write clear and actionable feedback messages to help the AI fix the task.



## Overview of instruction delivery

Throughout this post, we have explored various ways instructions can be delivered: loaded upfront, provided by users, always injected, decided to be read, discovered in the codebase, triggered by conditions, and given as feedback. These methods are not mutually exclusive - in practice, a single AI workflow uses multiple delivery methods simultaneously.

Here is a map of a typical tool-calling workflow, showing where each type of instruction is delivered:

```
System:
[Instructions could be loaded upfront]

User:
[Instructions could be provided by the user]

[Instructions could be always injected]

Assistant:
*decides to read instructions*
[Instructions could be decided to be read]

Tool call - read file:
[Instructions could be discovered]

Tool call - edit file:
[Instructions could be triggered]

*runs unit tests*

Tool call - unit tests:
[Instructions could be given in feedback]
```



## What to do with this information

Thanks for reading this far on how instructions could be delivered to AI models - there are deterministic and non-deterministic methods, there are different places for the instructions. How does understanding all the possible places where instructions could be injected help with your work?

- Model providers will need to train their models (Claude-Sonnet-4.5, GPT-5) to follow instructions delivered to them. Models should also not expect all the instructions to be spoon-fed to them at the beginning, they need to be able to take the initiative to discover instructions and follow instructions - for example writing tests closer to the style of the codebase.
- AI products (Claude Code) should educate users on where to add instructions for the AI to work with.
- AI engineers who build on top of the AI products or AI models should have a view on where is a good place to deliver instructions. Instead of trying to hillclimb on the system prompt, your problem could be solved by figuring out how to deliver instructions better[^prompting].
- End users should have an appreciation of how instructions are delivered.

[^prompting]: Assume that you want to build a clone similar to Anthropic Artifacts, where the product will deliver a very nice html file for the user to interact with. You spend a lot of time figuring out what is the system prompt that is able to generate the html file in one shot. You also have rigorous evaluation based on the common mistakes of what the model generates. However, if you use a Claude Code style generation where the model has access to rendering the html and manipulating the html to confirm that the generation is correct - or else continue to iterate - you can get a much better performance even without much prompting or evaluation. The old system prompt is now redundant, along with the time spent. Most of the evaluation test cases are now irrelevant as well.


I hope my writing here has provided a wider view on how instructions are delivered to AI products.


## Footnotes
