---
layout: post
title: Improve AI software engineering processes
---
A competent software engineer could fix something with just one instruction[^counting-instructions]. However, the engineer usually needs to AI coding tool multiple instructions to do the same thing. There is a gap here.

These are some steps to follow for AI to execute software engineering tasks better.

[^counting-instructions]: One instruction, not one LLM call. We should not be optimizing processes to do well in one LLM call.


## Collect all the human interactions

The git history has been useful to investigate what has been done in the past. However, it does not contain all the information.

We need to conversation history to identify places for improvements, and to backtest improvements later.

AI responses could always be regenerated. Code can always be rerun. However, human interactions cannot be reliably reproduced.



## Understand the pain points

We should look at the conversation history to find why AI needs multiple instructions from the user. Some of the follow-up conversation might indicate pain points.

The user is likely to be in pain when the user is literally cursing at the model
 - "wtf"

Some times the user is more polite
 - "please test"
 - "run lint"
 - "please read the docs"

Certain statements from the AI suggests that AI is doing something wrong
- "You're absolutely right"

We want to collect the pain points. Currently we can read the conversation history between people working on the codebase and AI. If we want to make a change, we can cite all these evidence of pain.

Note that pain may not be necessary collected from the human. For example, if AI takes a long time to figure out the exact logic of the function because of nested inheritance, it could be recorded as pain and be used for improvement.



## Implement processes

These are places where change could be made

- Code (variable names, comments)
- Repository processes (unit tests)
- AI coding tool processes (Claude Code hooks)
- System instructions (AGENTS.md, CLAUDE.md)

Code could be changed. Maybe variable or class names could have been written better. Maybe code could be refactored to follow a more straightforward logic. Maybe we should build abstractions, or remove abstractions.

Repository processes could be added. If the user is asking the model to move the import statements to the top of the file[^imports], you should implement a lint check in the unit tests. All code commits or code push needs to pass the lint check first. The coding tool will be expected to move the import statement.

Coding tool processes. For more ambiguous instructions, we probably. For example, there might be a feedback that the AI coding tools in writing long function code. Let's say you want to enforce that functions should be short. This is something that . You cannot really implement a hard threshold of 100 lines of code for each function, some functions indeed make most sense with just about 100 lines of code. Instead, you should probably get the AI to read some checklist when it is finishing their edits on functions with more than 100 lines of code.

System instructions. Consider the system instructions should be the onboarding document that the new hire needs to read before working on the code. If the AI coding tool is not running unit tests after the edits are complete, you should add to the system instructions. Note that CLAUDE.md is not the only place where change could be made. The system instructions should be served as a directory rather than as a place to store all the instructions. Similar to the onboarding document new hires should read - it should not be too long.

Note that this list is sorted in descending order of where I recommend the changes.






## Backtest improvements

Reconstruction the pain points where. With the changes, is the LLM providing a better responses.

We should also check that the purported improvements does not ma. For example you added a system instruction 

System instruction changes needs to be backtested against a larger set of information.



## Where are we headed

Employees are expected to not only follow processes, employees are expected to improve processes. We should have the same expectation for AI.

I expect products and features to automate process improvements.





