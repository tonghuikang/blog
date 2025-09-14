---
layout: post
title: Improve AI software engineering processes
---
These are some steps to follow for AI to execute software engineering tasks better.

We may not have all the tools and technologies yet.





## Collect all the human interactions

The git history has been useful to investigate what has been done in the past. However, it does not contain all the information.

The conversation history with AI will be useful pieces of information.

AI responses could always be regenerated. Code can always be rerun. However, human interactions cannot be reliably reproduced.



## Understand the pain points

If you ask a competent engineer to work on something, they should only require one instruction. If they need more than one instruction, it is your instruction that is incomplete or inaccurate. We should have a similar expectation for AI.

We should understand why features cannot be built one with human instructions[^counting-instructions]. I was only given one human instruction to fix something. However, I need to give AI many human instructions to fix something.

[^counting-instructions]: One instruction, not one LLM call. We should not be optimizing processes to do well in one LLM call.


From the conversation histories, we can find where the user is in pain.

The user is likely to be in pain when the user is literally cursing at the model
 - "wtf"

Some times the user is more polite
 - "please test"
 - "run lint"
 - "please read the docs"

Certain statements from the AI suggests that AI is doing something wrong
- "You're absolutely right"

We want to collect the pain points. Currently we can read the conversation history between people working on the codebase and AI. If we want to make a change, we can cite all these evidence of pain.

Note that pain may not be necessary collected from the human. For example, if AI takes a long time to find out what the function exactly is, it could be recorded as pain and be used for improvement.



## Implement processes

These are places where change could be made

- Code (variable names, comments)
- Repository processes (unit tests)
- AI coding tool processes (Claude Code hooks)
- System instructions (AGENTS.md, CLAUDE.md)

Code could be changed. Maybe variable or class names could have been written better. Maybe code could be refactored to follow a more straightforward logic. Maybe we should build abstractions, or remove abstractions.

Processes could be added. If the user is asking the model to move the import statements to the top of the file[^imports], you should implement a lint check in the unit tests. All code commits or code push needs to pass the lint check first.

Coding tool processes. For more ambiguous instructions, we probably. For example, there might be a feedback that the AI coding tools in writing long function code. Let's say you want to enforce that functions should be short. This is something that . You cannot really implement a hard threshold of 100 lines of code for each function, some functions indeed make most sense with just about 100 lines of code. Instead, you should probably get the AI to read some checklist when it is finishing their edits on functions with more than 100 lines of code.

System instructions. Note that CLAUDE.md is not the only place where change could be made[^system-instructions]. The system instructions should be served as a directory rather than as a place to store all the instructions. Consider the system instructions should be the onboarding document that the new hire needs to read before working on the code. It should not be too long.

Note that this list is sorted in decreasing order of recommendation.


https://www.flake8rules.com/rules/E402.html

Repository processes.

AI coding tool processes.



[^system-instructions]: My view is that minimum edits should be made to system instructions.


Whenever a code file is edited.

Whenever mocks are mentioned in the difference, go through a checklist.






## Backtest improvements

Reconstruction the pain points where. With the changes, is the LLM providing a better responses.

System instruction changes needs to be backtested against a larger set of information.




---


We also want sanity comparisons as well. Let's say 




What is the testing pattern? Is AI able to execute the testing pattern?

Currently I am working on a personal project to train an LLMs. This is how I operate.

- There is a dashboard.html
- Need to deploy to inference
- Need to deploy training

Can the LLM figure out that this is process I am following?





Once might assume that the starting statement from the user should already contain all the information. and conclude any statement from the user should indicate pain. We should refrain from making this conclusion. The initial statements from the user might have underspecified what should be implemented and AI has made a reasonable implementation which the human might disagree with. [^3]

[^3]: The ideal interaction to this probably involves asking what the user exactly wants before progressing. Some users may not want this, writing a prototype implementation might be a more efficient way.

With some evidence of pain, we can now understand what is the user try to do, and how can we make the process less painless.









## Predictions

I expect individual tool providers to build such analysis tools for AI coding agents.

I think there is some . As it appears, Claude Code is only going to natively support Anthropic models. Cursor. The team might use both Claude Code and Cursor we want process to be AI coding tool agnostic.







