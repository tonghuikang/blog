---
layout: post
title: Writing CLAUDE.md for mature codebases
---

I have recently been working on writing CLAUDE.md for my organization's monorepo.
This will affect the performance of [Claude Code](https://www.anthropic.com/claude-code), for both better and worse.

I'll share some thoughts on what should be included in CLAUDE.md.

There are also other coding rules [files](https://x.com/HanchungLee/status/1918920355709673887).
I will collectively call them "rulefiles" in this doc (CLAUDE.md is too many syllables, and I don't work for Anthropic).
Ideas in this doc should also apply to other AI coding tools.


## Scope of the coding rules

Anthropic has [written](https://www.anthropic.com/engineering/claude-code-best-practices) on how to use `CLAUDE.md`.

Note that you can place the Anthropic rulefile (CLAUDE.md) in multiple locations:
- The root of your repository
- In a child folder of your repository
- In a parent folder of your repository
- Your home folder `~/.claude/CLAUDE.md`

I will focus on the rulefiles that occur at the root of your repository, where it is the most controversial.

Rulefiles at other locations are not that controversial.
Individual teams or developers could decide for themselves what to put in those files, since they are likely to be the only ones benefiting or suffering from the consequences.


## Why would you want to standardize rulefiles

The natural state of affairs is that you add `CLAUDE.md` at root to `.gitignore` and then everyone is free to do whatever they want, and also not accidentally commit `CLAUDE.md` to root.

This is not ideal. There are multiple scenarios illustrating this:
- New engineers do not know which rulefile to get started with.
- When one engineer solves an issue with AI coding, others hit the same problem without knowing the solution exists.
- Every engineer spends time finding the same effective prompts that colleagues already discovered.
- AI-generated code varies wildly in style and approach depending on whose local rulefile was used.

However, agreeing on a standard rulefile is not easy
- You want rules that work for everyone, not just yourself
- You want to understand why every line of instruction is added
- Nobody should need to prompt against the existing rulefile to get things done


## Principles for the rulefile


#### Write instructions that you would want to receive

- Think of how you are onboarded. You should not be required to read through pages of instructions before committing your first piece of code. You are expected to have common sense, and should not require an instruction like "do not commit OpenAI API key".
- Model providers should be thinking a lot about how they want their models to be prompted. You should design your instructions in this direction.
- There are prompting tricks from 2024 that claim you can get better performance from the model by "bribing" the model. Do not do this.


#### Codify the globally applicable processes

- What processes should every engineer working on the codebase know?
	- How do you lint, format and typecheck?
	- How do you run a single test?
	- How do you run all the tests?
- The Anthropic quickstart [repo](https://github.com/anthropics/anthropic-quickstarts/blob/99502f5d33df22b3e88bd3c2a52691414e8994e4/CLAUDE.md#testing--code-quality) is a good example.


#### Guide the model to avoid mistakes

- Mistakes generally belong to three categories
	- Lack of context - there aren't instructions in the code and CLAUDE.md
	- Lack of instructions - the user could have written a clearer instruction
	- Model capability - the model is not that good yet
- You should document the mistakes.
- If the model frequently makes a mistake, instructions can be written to address the mistakes, subject to the principles below.
- Many of the instructions in the Anthropic MCP [CLAUDE.md](https://github.com/modelcontextprotocol/python-sdk/blob/2210c1be18d66ecf5553ee8915ad1338dc3aecb9/CLAUDE.md) might be intended to mitigate mistakes.


#### Minimize instructions

- The longer the instruction, the harder it is to maintain.
- Only include instructions if it is necessary.
- You want each of your instructions to nudge the model toward strictly better output.


#### Defer to other sources of information

- Instead of saying "document your code" or "avoid meaningless comments", ask the model to follow conventions in the codebase. In a large monorepo, the amount of ideal documentation can vary a lot.
- This means you could improve the documentation on the codebase. The improvements carry over to other coding tools and human software engineers.


#### Defer to processes

- Instead of asking the model to always write docstrings in the exact correct format, defer to the linting process instead. The linting process will provide instructions on how to fix the docstring. If you are a human writing the docstring, you write the docstring first and run the linting process too. Deferring to the linting process helps the linting process serve as a single source of truth. You have to tell the model which processes to follow, and enforce the processes - for example, the code should fail unit tests if it has not been linted.
- This also means that you could improve the process. Again, the improvements carry over to other coding tools and human software engineers.


#### Be specific where your instructions apply

- Linting, formatting, typechecking and testing procedures should be universal, and you should include them in your instructions.
- Some instructions are specific to certain workflows. You should be aware that this is the case.
	- Let's say you frequently work on a config file, and editing the config file requires running a bash command, something like `regen_graphql_schema`. You probably might have a macro that runs `regen_graphql_schema` before every git commit. You should not add an instruction like `Run ``regen_graphql_schema`` on every commit`, because most of the people in the organization do not work with `regen_graphql_schema`.
- Specific cases should be part of general instructions.
	- For the ``regen_graphql_schema`` example, instead of writing `When libsomething/schema.py is edited, run ``regen_graphql_schema``.`, I will write something like - `When editing a config file, read the top of the file for follow-up instructions to follow. For example, in libsomething/schema.py, there is an instruction to run ``regen_graphql_schema`` after every file change.` I am deferring instructions to other sources. When there is another file with similar behavior where you need to run a certain script after editing the file, I will get the model to follow instructions for free.


## How I would maintain the rulefile

I will maintain a document in another place with the following columns:

Failure cases | Remedying instructions | Contributor | Status
------------- | ---------------------- | ----------- | ------
Summarize the failure with the existing AI coding tool | Instruction that is included in rulefile | Who contributed this, so that we can contact them | The instruction may be included, or we have decided this has to be somewhere else

We will be editing this pretty often, so this table will live in a Google / Notion / Quip doc.
People can add comments too.
This table will not be committed to the codebase.

Before I commit the updated rulefiles, I think I will:

- Get some people to agree on all the changes. Make sure that the changes follow the principles above (so that they are unlikely to cause regressions for all reasonable interpretations of the rulefile)
- Commit the updated rulefile
- Send a notification to interested people
- Receive reports on issues with the new rulefile

Should I run evaluations on the updated rulefile?

- If we are confident that every instruction is strictly a good direction, I don't think we need to.
- I do not think it is worth the effort.
- Maybe an AI coding tool will build this feature.
- Maybe try out the new rulefile for a few days (but this is logistically not easy, because I will need to stash the changed rulefile before every commit).


## Where are we headed

I predict that AI will be making suggestions on how to improve their own process. After completing the task, the AI may want to reflect on what instructions could have been added, that could have improved their performance. Improvements include requiring fewer back-and-forth interactions with the human, shorter search and thought processes, and fewer uses of tools. [^1]

[^1]: Currently in Claude Code, you can press the `#` key to ask Claude to "remember" something which will then be incorporate into the relevant `CLAUDE.md` file.


## Footnotes


