---
layout: post
title: Writing CLAUDE.md for mature codebases
---
I am recently working on writing CLAUDE.md my organization's monorepo.
This will affect the performance Claude Code for both better and worse.

I write some thoughts behind what should be included in CLAUDE.md.

There are also other coding rules [files](https://x.com/HanchungLee/status/1918920355709673887).
I will collectively call them "rulefiles" in this doc (CLAUDE.md is too many syllables).
Ideas in this doc should also apply to other AI coding tools.


## Scope of the coding rules

This is what Anthropic has written about write their rulefiles.
- https://www.anthropic.com/engineering/claude-code-best-practices

Note that you can place the Anthropic rulefile (CLAUDE.md) in multiple locations
- The root of your repository
- In a child folder of your repository
- In the parent of your repository
- Your home folder `~/.claude/CLAUDE.md`

I will focus on the rulefiles that occurs at the root of your repo, where is it the most controversial.

Rulefiles at other locations are not that controversial.
Individual teams or developers could decide for themselves that to put in those files, since they are likely to be the only ones benefitting or suffering from the consequences.


## Why would you want to standardize rulefiles

The natural state of affairs is that you commit `CLAUDE.md` at root to `.gitignore` and they everyone is free to do whatever they want, and also not accidentally commit `CLAUDE.md` to root.

This is not ideal for multiple scenarios
- You want to onboard an engineer (or soon, the AI). There is no standardized rulefile to get started with.
- Issues faced by one engineer might be faced by another engineer. The instruction to remedy the issue is not effectively shared.
- (TODO: add a few more)



## Principles for the rulefile


#### Write instructions that you want to be instructed with

- Think of how you are onboarded. You should not be required to read through pages of instructions before committing your first piece of code.
- There are prompting tricks from 2024 where it claims you can get better performance from the model by "bribing" the model. Do not do this.


#### Codify the globally applicable processes

- What processes do every engineer working on the codebase should know?
	- How do you lint, format and typecheck?
	- How do you run a single test
	- How do you run all the tests
- The Anthropic quickstart [repo](https://github.com/anthropics/anthropic-quickstarts/blob/99502f5d33df22b3e88bd3c2a52691414e8994e4/CLAUDE.md#testing--code-quality) is a good example.


#### Guide the model to avoid mistakes

- If the model frequently makes a mistake, instructions can be written to address the mistakes, subject to the principles below.
- Many of the instructions in the Anthropic MCP [CLAUDE.md](https://github.com/modelcontextprotocol/python-sdk/blob/2210c1be18d66ecf5553ee8915ad1338dc3aecb9/CLAUDE.md) might be intended to mitigate mistakes.


#### Minimize instructions

- The longer the instruction, the harder it is to maintain.
- Only include instructions if it is necessary.
- You want to each of your instructions nudges the model to strictly produce better output.


#### Defer to other sources of information

- Instead of saying "document your code" or "avoid meaningless comments", ask the model to follow convention in the code base. In a large monorepo, the amount of ideal documentation can vary a lot.
- This means you could improve the documentation on the codebase. The improvements carry over to other coding tools and human software engineers.


#### Defer to processes

- Instead of asking the model to always write docstrings in the exact correct format, defer to the linting process instead. The linting process will provide instructions on how to fix the docstring. If you are a human writing the docstring, you write the docstring first and run the linting process too. Deferring the linting process helps the linting process serve as a single source of truth. You have to tell the processes that the model should follow, and enforce the processes - for example the code should fail unit tests it has not been linted.
- This also means that you could improve the process. Again, the improvements carry over to other coding tools and human software engineers.


#### Be specific where your instructions apply

- Let's say you frequently work on a config file, and editing the config file requires running a bash command, something like `regen_graphql_schema`. You probably might have a macro that runs `regen_graphql_schema` before every git commit. You should not add an instruction like `Run regen_graphql_schema on every commit`, because most of the people of the organization does not work with `regen_graphql_schema`.




## How I would maintain the rulefile

I will maintain a document in another place with the following columns

Failure cases | Remedying instructions | Contributor | Status
------------- | ---------------------- | ----------- | ------
Summarize the failure | Instruction that is included | Who contributed this, so that we can contact them | What is the status

We would be editing this pretty often, so this table will live in a Google / Notion / Quip doc.
This will not be committed to the codebase.

Before I commit the updated rulefiles, I think I will
- Get people to agree on the changes
	- Make sure that the changes follow the principles above (so that it is unlikely will not cause regressions for all reasonable interpretations of the rulefile)
- Some trial period of two days
- Commit the updated rulefile and send a notification to interested people

Should I run evaluations on the updated rulefile? I do not think it is worth the effort. I will defer this to the AI that we will hire in the future.



## Predictions

Currently a pain point I have is that the environment that has access to production data is separated from the environment that I write code with (which is where Claude Code is installed).


I predict that AI would be making suggestions on how to improve their own process.
This involves suggesting improvements to the rulefiles, and improve the code documentation.
After completing the task, the AI may want to reflect on what instructions could have been added, that could have improved their performance.
Improvements includes requiring fewer back-and-forth with the human, shorter search and thought process, fewer use of tools.




