---
layout: post
title: Improving AI software engineering processes
---
A competent software engineer could fix an issue with just one instruction. However, the engineer usually needs to give their AI coding tools multiple follow-up instructions to do the same thing[^counting-instructions]. There is a gap here.

These are some steps to follow for AI to execute software engineering tasks better.

[^counting-instructions]: One instruction, not one LLM call. It is expected that AI products use multiple LLM calls, multiple code edits, multiple code executions to achieve the tasks. We should not expect AI products to be perfect at every step, and I argue that training models and building products with this expectation is bad. AI products should focus on what actually affects the user, in this case, avoiding requiring the user to point out obvious mistakes with follow-up instructions. 


## Collect all the human interactions

The git history has been useful to investigate what has been done in the past. However, it does not contain all the information.

We need the conversation history to identify places for improvements, and to backtest improvements later.

AI responses could always be regenerated. Code can always be rerun. However, human interactions cannot be reliably reproduced. Within the company, there should be some standardized processes to collect these conversations, store it somewhere and make it easy to read.



## Understand the pain points

We should look at the conversation history to find why AI needs multiple instructions from the user. Some of the follow-up conversation might indicate pain points.

The user is likely to be in pain when the user is literally cursing at the model.
 - "wtf"

Sometimes the user is more polite
 - "please break down the function"
 - "run lint"
 - "please run tests"

Certain statements from the AI suggest that AI is doing something wrong
- "You're absolutely right"

We want to collect the pain points. Currently we can read the conversation history between people working on the codebase and AI. If we want to make a change, we can cite all this evidence of pain.

Note that pain may not necessarily be collected from the human. For example, if AI takes a long time to figure out the exact logic of the function, it could be interpreted as pain and be used for improvement.



## Implement processes

These are places where changes could be made

- Code (variable names, comments)
- Repository processes (unit tests)
- AI coding tool processes (Claude Code hooks)
- System instructions (AGENTS.md, CLAUDE.md)

Code could be changed. Maybe variable or class names could have been written better. Maybe code could be refactored to follow a more straightforward logic. Maybe we should build abstractions, or remove abstractions.

Repository processes could be added. If the user is asking the model to move the import statements to the top of the file, you should implement a lint check in the unit tests. All code commits or code pushes need to pass the lint check first. The coding tool will be expected to move the import statements.

Processes could be enforced for AI coding tools. There are some standards that are not appropriate as repository processes. For example, we often see AI adding onto functions that should have been broken down into multiple functions. A lint check to enforce functions to be less than 100 lines of code long will have problems - because some functions deserve to be more than 100 lines, while there could be 50-line functions that should have been broken down into two functions. It is not feasible to build a rule-based classifier to decide whether functions are too long. We should defer this to AI. With coding tool features like Claude Code hooks, we can have a rule where if an AI finishes editing a function with more than 50 lines of code, the AI will need to read some code guidelines on function length before proceeding.

System instructions. Consider the system instructions to be the onboarding document that the new hire needs to read before working on the code. If the AI coding tool does not immediately know how to run unit tests after the edits are complete, you should add to the system instructions because it should apply to the entire codebase[^system-instructions].

[^system-instructions]: Note that AGENTS.md or CLAUDE.md is not the only place where improvements could be made. This list is sorted in descending order of where I recommend the changes. Changes to the code and repository processes could be used by any AI coding tool, and therefore I recommend these first.



## Backtest improvements

Ideally, you want to prove that your improvements
- Actually fix the pain points
- Do not cause other pain points

To prove that your improvements have these properties, you can backtest.

For example, you and your colleagues have been giving many follow-up instructions to the AI coding tool, on breaking up long function definitions. This is how you can backtest

- You retrieve from the conversation history on similar follow-up instructions. In this example, you should search for humans asking the AI to break down the function into smaller functions.
- You reproduce the issue. The issue here is that the AI simply continues on, instead of figuring out that the function is too long.
- You simulate the fix. You inject the hook response into the conversation.
- You measure the response. You count how often AI will still simply continue the conversation, or attempt to fix the function. Maybe your instruction is not strong enough to convince the AI that the function needs to be broken down.
- You repeat the process to check that this improvement does not cause other problems.
	- You retrieve from the conversation history where the improvement tends to cause issues. In this example, you find examples where AI works on long functions that should not be broken down into smaller functions. You can also find examples where the AI is not supposed to fix the function (for example a change that merely fixes variable names or adds type hints).
	- You simulate the fix. You inject the hook response into the conversation.
	- You measure the response. You count how often AI will still simply continue the conversation after considering whether to address the advice, or wrongly judged that the function should be broken down and attempt to break down the function.

If your changes are more global, the area that you need to backtest will be large. For example, instead of implementing a hook, you have updated the system instruction to write shorter functions. You might need to check that the AI actually follows this system instruction among the many other instructions in the conversation history. Now that the system instruction edit affects all the tasks the AI coding tool is working on (instead of tasks that involve editing long functions), you need to check that AI is not overzealous in executing this system instruction by making functions unnecessarily atomic.

You can maybe save on the backtesting step, if your change is very local. One such change is to check whether Python imports are placed at the top of the file. You just need to ensure that you have implemented the repository processes correctly. We can trust AI to correctly use the feedback from repository processes.



## Where are we headed

People who make AI coding tools should make it very easy to improve processes. Currently, while it is possible to implement a Claude Code hook to deliver instructions when 100-line functions are edited, the code to implement the hook is very complicated. It is also difficult to test whether the hook is working correctly - being triggered at and only at the intended places, and delivering the intended effect. Even if the hook is correctly implemented, there is no tooling to backtest against previous pain points.

We should expect AI to work through all these steps to improve processes too[^memory-feature]. Human employees are expected to not only follow processes, human employees are expected to improve processes. We should have the same expectation for AI.


[^memory-feature]: On the other hand, AI coding tools should also stop promoting offering AI-powered band-aids that do not really solve the problem. AI coding tools usually have this memory feature where you can get AI to improve on their AGENTS.md or CLAUDE.md. This goes against my recommendation of keeping the system instructions short, and defer to code and processes instead. I would recommend promoting a product feature only when your own engineers actually use and love the feature.



## Footnotes



