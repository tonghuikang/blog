---
layout: post
title: Writing CLAUDE.md for mature codebases
---

I have recently been working on writing CLAUDE.md for my organization's monorepo.
This will affect the performance of [Claude Code](https://www.anthropic.com/claude-code), for both better and worse.

I'll share some thoughts on what should be included in CLAUDE.md.

There are also other coding rules [files](https://x.com/HanchungLee/status/1918920355709673887).
I will collectively call them "rulefiles" in this doc since CLAUDE.md is too many syllables, and I don't work for Anthropic.
Ideas in this doc should also apply to other AI coding tools.


## Scope of the coding rules

Anthropic has [written](https://www.anthropic.com/engineering/claude-code-best-practices) on how to use `CLAUDE.md`.

Note that you can place the Anthropic rulefile (CLAUDE.md) in multiple locations:
- The root of your repository
- In a child folder of your repository
- In a parent folder of your repository
- Your home folder `~/.claude/CLAUDE.md`

I will focus on the rulefiles that occur at the root of your repository, where they are the most controversial.

Rulefiles at other locations are not that controversial.
Individual teams or developers could decide for themselves what to put in those files, since they are likely to be the only ones benefiting or suffering from the consequences.


## Why would you want to standardize rulefiles

The natural state of affairs is that you add `CLAUDE.md` at root to `.gitignore` so everyone is free to do whatever they want and won't accidentally commit `CLAUDE.md` to root.

This is not ideal. There are multiple scenarios illustrating this:
- New engineers do not know which rulefile to get started with.
- When one engineer solves an issue with AI coding, others hit the same problem without knowing the solution exists.
- Every engineer spends time finding the same effective prompts that colleagues already discovered.
- AI-generated code varies wildly in style and approach depending on whose local rulefile was used.

However, agreeing on a standard rulefile is not that easy:
- You want rules that work for everyone, not just yourself.
- Nobody should need to prompt against the existing rulefile to get things done.
- Engineers are used to having their own processes. Engineers would be unhappy to conform to using a certain set of vim keybindings, and would rather maintain their own.
- Every single line of instruction in the rulefile needs to be justified.
- There needs to be some approval process that involves several stakeholders.


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


#### Document the mistakes

- You need to be aware of the mistakes before you could fix them
- You should document the mistakes that you observe with the AI coding tool. You should also invite your colleagues to document the mistakes. This way, everyone is aware of where the AI coding tool fails. [^2]

[^2]: Many of the instructions in the Anthropic MCP [CLAUDE.md](https://github.com/modelcontextprotocol/python-sdk/blob/2210c1be18d66ecf5553ee8915ad1338dc3aecb9/CLAUDE.md) might be intended to mitigate mistakes.



#### Minimize instructions

- The longer the instruction, the harder it is to maintain the rulefile.
- Only include instructions if they are necessary.
- You want to ensure each of your instructions nudges the model toward strictly better output. Avoid writing instructions that perform better at certain circumstances and perform worse at certain circumstances.


#### Defer to conventional sources of information

- Instead of writing "document your code" or "avoid meaningless comments" in the rulefile, ask the model to follow conventions in the codebase. In a large monorepo, the amount of ideal documentation can vary a lot.
- This means you could improve the documentation on the codebase. The improvements carry over to other coding tools and human software engineers.


#### Defer to processes

- You should not squeeze all the instructions. Only provide the instruction at points of the workflow when necessary. [^4]
- For example, you observe that the AI coding tool is not writing docstring in the correct format. Instead of copying the entire docstring formatting rules into the rulefile, you should tell the model to run the lint every time a docstring is being edited. The linting process will provide instructions on how to fix the docstring. If you are a human writing the docstring, you write the docstring first and run the linting process too. 
- Deferring to the process helps to consolidate the single source of truth. When you want to update the standards, for example, adding a new docstring formatting rule, you add it to the process. You do not add it to every single rulefile. Existing rulefiles will not break.
- Improvements to the process also carry over to the other AI coding tools and humans that still need to work on the code manually.

[^4]: Instead of Anthropic extending their already long system prompt to ask the model to not write to a file before reading it, it gets Claude Code to throw this error when the `Edit` tool is used before the `Read` tool.
	> `{"type":"user","message":{"role":"user","content":[{"type":"tool_result","content":"File has not been read yet. Read it first before writing to it.","is_error":true,"tool_use_id":"toolu_01VF7kKA8Xni1FX6YFm26GRj"}]},"session_id":"bfaaf39d-d65a-48ad-b9c7-1c37ff463864"}`


#### Be specific where your instructions apply

- Linting, formatting, typechecking and testing procedures should be universal, and you should include them in your instructions.
- Some instructions are specific to certain workflows. You should be aware that this is the case.
	- Let's say you frequently work on a config file, and editing the config file requires running a bash command, something like `regen_graphql_schema`. You probably might have a macro that runs `regen_graphql_schema` before every git commit. You should not add an instruction like `Run "regen_graphql_schema" on every commit`, because most of the people in the organization do not work with `regen_graphql_schema`.
- Specific cases should be part of general instructions.
	- For the `regen_graphql_schema` example, instead of writing `When libsomething/schema.py is edited, run "regen_graphql_schema".`, I will write something like - `When editing a config file, read the top of the file for follow-up instructions to follow. For example, in libsomething/schema.py, there is an instruction to run "regen_graphql_schema" after every file change.` I am deferring instructions to other sources. When there is another file with similar behavior where you need to run a certain script after editing the file, I will get the model to follow instructions for free.


## How I would maintain the rulefile

I will maintain a document in another place with the following columns:

Failure cases | Remedying instructions | Contributor | Status
------------- | ---------------------- | ----------- | ------
Name the failure with the existing AI coding tool, and provide an example | The rulefile instruction that is proposed to be instructed | Who contributed this, so that we can contact them | What did we decide to do about this - include the proposed instruction, update some process instead, or decided to take no action

We will be editing this pretty often, so this table will live in a Google / Notion / Quip doc.
People can add comments too.
This table will not be committed to the codebase.

Before I commit the updated rulefiles, I think I will:

- Get some people to agree on all the changes. You should include the most frequent users of the coding tool, and some engineers who have the most context with the codebase.
- Make sure that the changes follow the principles above (so that they are unlikely to cause regressions for all reasonable interpretations of the rulefile)
- Commit the updated rulefile
- Send a notification to users of the AI coding tools
- Follow-up and document mistakes with the new rulefile

Should I run evaluations on the updated rulefile?

- What I am proposing here is to document the mistakes. If you still spot a mistake even after addressing it, document it again so that the team can discuss how the rulefiles could be improved.
- I do not think it is worth the effort to build an automated process to test the rulefile, especially if your team is small. You still have to think of how much you invest versus how much time you save.
- I will put more focus on ensuring every line of instruction in the rulefile is strictly a good instruction.


## Example of an CLAUDE.md that I propose

```
# Code discovery

Code history search
- When offered a differential search like D538034, search for commits with
`git log --all --grep="D538034" --oneline`

When tracing code
- Trace the full call stack before making conclusions

Tool use
- Use `Glob` tool for finding files by pattern
- Use `LS` tool for directories.
    - Do NOT use `Bash(ls)`
- Use `Grep` tool to search
    - Do NOT use `Bash(grep)`, `Bash(rg)`, `Bash(sed)`, `Bash(awk)`, `Bash(find)`


# Code editing

After editing any file, read the top of the file for the necessary follow-up actions
- For example, when you modify `libsomething/types/__init__.py`, the top of this file states that you need to run `regen_graphql_schema`


# Code quality

You will follow the style of existing code

Choose to write code of better quality
- Location of Python `import` statement should always be at the top of the file
    - Unless there is an issue with circular dependency
- New Python functions should have signatures, even if signatures are missing for existing functions


# Test design

You will write tests following the style of the existing code.
- You will read the files in the same folder, and if necessary, the surrounding directories.
    - For example, files in `web/lib/a` are decorated with `@a.test.manage()`
    - Whether `pytest.mark.parametrize` is being used
- Follow the existing pattern on test design

All new features should have accompanying tests


# Test execution

Whenever you finish editing the code, you will always run `yo lint` (just `yo lint`), `yo format` (just `yo format`) and then `yo test` (just `yo test`)

File-level tests
- For Python code, to run localized Python test cases, you will run `pytest (filepath)`
- For non-Python code, you will run `yo test`, unless otherwise instructed by the user


# Git operations

Do NOT make any git operations unless requested by the human user, and the tests have passed.

To commit code
- Run `git add .`
- Read the git commit template at `git config --get commit.template`
- Write the commit message
    - Do NOT create any new files
    - See the following section on commit message guidelines
- Run check on commit message `yo proofread`
- Amend the commit message
    - Do NOT create any new files

You will NOT push code. Only the human user will push code.


# Commit message requirements

- Title
    - Commit title should be of the form <topic>: <description>
        - (In descending priority)
        - Search for similar commits by the human user
        - Search for recent commits by the human user
        - Search for similar commits in the edited file and surrounding file
- Description
    - Cite the user's instructions, if you have access to the conversation
    - Be very concise
- Reviewers
    - Guidelines on selecting reviewers
        - Search for similar commits by the human user
        - Do NOT include the instructing human user as reviewer
            - Read `whoami` or `pwd` for who is instructing you
- Asana Tasks
    - Search relevant commits for the Asana task
    - If the human user has provided a Slack thread, put the Slack thread in the description
    - If you cannot find a relevant Slack thread or Asana task, ask the human user
- Differential Revision
    - If this commit is a direct overwrite of another commit, include the Differential Revision


# Code review

When asked to review a change
- Mention the most critical issue first
- Suggest to link to an Asana task or Slack conversation for context
- Avoid complaining about the lack of context if an Asana task URL is provided
```


## Where are we headed

I predict that AI will be making suggestions on how to improve their own process. After completing the task, the AI may want to reflect on what instructions could have been added that could have improved their performance. Improvements include requiring fewer back-and-forth interactions with the human, shorter search and thought processes, and fewer uses of tools. [^3]

[^3]: Currently in Claude Code, you can press the `#` key to ask Claude to "remember" something which will then be incorporated into the relevant `CLAUDE.md` file.


## Footnotes
