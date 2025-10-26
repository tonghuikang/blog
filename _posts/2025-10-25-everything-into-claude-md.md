---
layout: post
title: You should not stuff everything into CLAUDE.md
---
In this article, I argue that CLAUDE.md / AGENTS.md should be short.

In some ways, this is a rehash of my previous writings, but I wanted to put all my arguments in this document[^writings].

[^writings]: My previous writings. In my [Claude Code template](https://github.com/tonghuikang/claude-code-template/) where I wrote about hooks, I wrote about the issues of solely depending on CLAUDE.md. I also wrote about how else instructions [could be delivered to AI models](https://blog.huikang.dev/2025/10/20/delivering-ai-instructions.html). I also wrote about how I wrote the [first](https://blog.huikang.dev/2025/05/31/writing-claude-md.html) CLAUDE.md file for the company monorepo.



### How did you end up with a huge CLAUDE.md

You got Claude Code to [generate](https://docs.claude.com/en/docs/claude-code/memory#set-up-project-memory) a CLAUDE.md that looks good. When faced with issues, you just asked Claude Code to [add](https://docs.claude.com/en/docs/claude-code/memory#quickly-add-memories-with-the-%23-shortcut) to CLAUDE.md. Other engineers did the same. CLAUDE.md was being edited without scrutiny and moderation.

You may also have taken one from [Github](https://github.com/search?q=path%3ACLAUDE.md&type=code) or an SEO-optimized site from Google [search](https://www.google.com/search?q=claude.md+example).




### CLAUDE.md always has to be ground truth

You should read each and every statement in CLAUDE.md. Is it really the ground truth? Are you sure it will continue to be the ground truth?




### CLAUDE.md is tokens that you always pay for

At current prices, Sonnet models are $0.30 per million input tokens with the prompt caching discount. A 10,000-token system instruction would cost 0.3 cents per message—and note that in an agentic loop you send multiple messages.

If an engineer spends $200 per month on Claude Code API costs, the 10,000 token system instruction could have been 20% of the LLM costs. Maybe cost is a strong enough argument to switch away from having huge CLAUDE.md files.




### Someone needs to own CLAUDE.md

An engineer finds something annoying with Claude Code and decides to add something to CLAUDE.md. Another engineer argues that the new statement will cause confusion. Someone needs to be the arbiter.

Ideally, we should not even need to make frequent changes to CLAUDE.md. The longer CLAUDE.md is, the harder it is to maintain.




### Someone needs to test CLAUDE.md

Instructions could break other instructions. An instruction asking the coding agent to be more rigorous in their work may cause the coding agent to take an unnecessarily long time to answer a simple question. Building a rigorous evaluation is not easy. If CLAUDE.md is short and only made of statements that are very necessary and could never be misinterpreted 




## The way forward

One way forward (or backward) is to not maintain one CLAUDE.md. The CLAUDE.md is put in `.gitignore`. Everyone uses their own CLAUDE.md. Similar to how companies do not standardize the code editors engineers use, the same could be done for CLAUDE.md. But this is [not ideal](https://blog.huikang.dev/2025/05/31/writing-claude-md.html).

My recommendation is to defer instructions to other places. CLAUDE.md [is not the only place](https://blog.huikang.dev/2025/10/20/delivering-ai-instructions.html) to provide instructions to the model. For Claude Code, there are hooks. CLAUDE.md should also be more of a short directory—this is similar to how the idea of skills works.

[^local]:Note that you can add CLAUDE.md files in places other than the repository root. When Claude Code reads a file, it will also read all CLAUDE.md files in the current directory and all parent directories that it has not read. This means that if Claude Code is reading many files, it will be accumulating all the CLAUDE.md files in memory. If each CLAUDE.md file is long, you will quickly fill up the context. Hence, my recommendation is that local CLAUDE.md files must be short. I do not recommend adding a lot of local CLAUDE.md files either—only for the files that you need a reminder about when reading them.

I hope coding tools should be designed to be better at educating their users. The product should alert the user if the CLAUDE.md file is too long. The coding tool providers should also provide good examples of effective CLAUDE.md files[^examples].

[^examples]:The only public CLAUDE.md files from Anthropic I am aware of are from the MCP SDK — [Python](https://github.com/modelcontextprotocol/python-sdk/blob/main/CLAUDE.md) and [Typescript](https://github.com/modelcontextprotocol/typescript-sdk/blob/main/CLAUDE.md).




# Footnotes
