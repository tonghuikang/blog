---
layout: post
title: Mindset changes for AI software engineering
---
As AI gets better, some software engineering mindsets need to change.

## Task difficulty is now determined by verifiability

In the middle of 2022, I spent one whole week investigating a segfault issue with C++ [^1]. This process was slow because
- I do not understand C++. I (still) do not know whether to add `auto`, `*`, `&`, `->`, `.at()`, or `const`.
- Each compilation of C++ takes around 20 minutes. I need to wait for the compilation to finish before I am able to read the logs that I have added.
- The error logs from a segfault are very uninformative. I had to add logging - if a certain log is printed, it means that we have reached that line of the code without issues.
- C++ code call stack is very deep and difficult to track.

[^1]: If you are interested, the revision is D396214 - if you know what this refers to and still have access.

This could have been solved with AI without much human oversight. If I am tasked to investigate the same issue today, I think I will need to spend only two hours. The two hours would be spent to define the verification process for the AI to follow, and the tools available for AI to use.[^2] This task is now easy because it is easily verifiable.

[^2]: In addition, I should also make investments so that this is easy to repeat in the future. This might be as simple as documenting what you have done, or building some tool from scratch.

With AI, these are no longer factors when considering the difficulty of a task:
- The obscurity of the language.
- The waiting time between each action and analysis.
- The tediousness of the task.
- The complexity of the logic.

If a task is easy to verify, the task is now easy with AI. You should think of what this unlocks. For example, there might be bugs that are affecting real users but are considered low priority because of how difficult it is to solve them. If the bug is verifiable, the bug should be easily solved with AI. You might need to reprioritize which work is being done.



## Build for the best software engineer you worked with

Think of the best software engineer you have ever worked with - the engineer that you depend on to fix the nastiest bugs in your system - the engineer you depend on when there are issues with on-call. AI will be this engineer, working for you.

Even the best software engineer you have ever worked with is not omniscient. The engineer also needs tools to work with. The engineer needs a good codebase to work on.

Whenever you are dissatisfied with the AI's performance, you should think whether it is your fault or the AI's fault. Similarly, if an engineer you hire could not accomplish your task, it might be because you did not set the engineer up for success. The tools you offer might be unusable, and your codebase horrible.

You should build and maintain tools that the engineer can use, and improve the codebase. You might still need to make minimal investments to make today's AI useful, for example by writing something in CLAUDE.md for Claude Code to avoid making a mistake it should not have made. However, you should not be overinvesting in processes that will be soon irrelevant.



## Reallocate your human oversight

For 90% [^3] of the time you spend on the work you do this year, AI might already be able to do it next year. Think of what the 10% of the work is. Also think of what the 90% of the work is.

The role of the human in the company will soon be to sign off on decisions and implementations made by AI. You will be the custodian [^4] of resources and the processes.

[^3]: I am not referring to lines of code or number of commits. I am referring to the percentage of your time.

[^4]: This is the concept of legal guarantor or 'sin-eater' as described by New York Times and [Ethan Mollick](https://bsky.app/profile/emollick.bsky.social/post/3lrt6mcqzv225).


## Footnotes


