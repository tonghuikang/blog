---
layout: post
title: Companion tooling for AI coding agents
---
Software engineering is not just about execution. It is also about building processes to execute better. [^1]

[^1]: In some sense, code itself is already a process for the machine to follow.

Similarly, you should not just use AI to execute software engineering tasks. You should also use AI to build better software engineering processes. This is my wishlist.



## Analyze the pain points

The first place to find where the pain points are is to find where the user is in pain. The user is likely to be in pain when the user is literally cursing at the model
 - "wtf"

Some times the user is more polite
 - "please test"
 - "run lint"
 - "please read the docs"

Certain statements from the AI suggests that AI is doing something wrong
- "You're absolutely right"

Once might assume that the starting statement from the user should already contain all the information. and conclude any statement from the user should indicate pain. We should refrain from making this conclusion. The initial statements from the user might have underspecified what should be implemented and AI has made a reasonable implementation which the human might disagree with. [^3]

[^3]: The ideal interaction to this probably involves asking what the user exactly wants before progressing. Some users may not want this, writing a prototype implementation might be a more efficient way.

With some evidence of pain, we can now understand what is the user try to do, and how can we make the process less painless.





## Understand the processes

What is the testing pattern? Is AI able to execute the testing pattern?

Currently I am working on a personal project to train an LLMs. This is how I operate.

- There is a dashboard.html
- Need to deploy to inference
- Need to deploy training

Can the LLM figure out that this is process I am following?




## Suggest processes to follow

It should be able to autonomously read the history to suggest what to add to CLAUDE.md.

My view is to minimize the information to add to CLAUDE.md (see extended design instructions here)

Write a bash script to run on a certain command.




## Predictions

I expect individual tool providers to build such analysis tools for AI coding agents.

I think there is some . As it appears, Claude Code is only going to natively support Anthropic models. Cursor. The team might use both Claude Code and Cursor we want process to be AI coding tool agnostic.







