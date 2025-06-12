---
layout: post
title: The mindset for AI software engineering
---
AI will soon act as your peer software engineer. Similar to how you empower your human software engineer, this is how you empower your AI software engineer


Notes to add
- Velocity is measured differently. It is okay to wait for one week to solve a very hard problem - e.g. hard to reproduce bug. Compute cost might be a problem.
- Tasks are as difficult as connecting a verifier.
- Models will get better. Build the tools that anticipate the models getting better.



### From implementer to orchestrator

Your product manager asks you to build a button.

Your first reaction should not be "how do I implement this button elegantly?". Your reaction should be - "how do I delegate this to AI?"

You should still think how an elegant implementation would look like. You should still have standards on what elegant implementation is.
But you should be getting AI to implement the button - and implement it elegantly.
AI should be meeting your standards, you should not need to regurgitate your standards every time you ask AI to implement a button.

### The factory manager mindset

You need to invest.

You are the factory manager, not a factory worker.
You run the factory that builds buttons, you do not build buttons yourself.
You implement processes so that you can easily and quickly build things, starting from buttons.

As a software engineer, you should have standards on what good code is.
You need to implement processes so that AI will follow these standards.

### What processes to invest in

There are processes that should already have been implemented:
- Code linter, code formatter, and unittests
- Guidelines for commit messages

These are the standard processes in software engineering. Humans follow these standards. AI should also follow these standards.

There are processes that are now worth investing in. With Sonnet 4, as implemented in Claude Code, models today are good enough to power agents:

- **Making offline table queries.** When I implement a button, I want to have a sense how often similar buttons are being clicked.
    We do record when and where people click buttons - and I need to write a SQL query to count the number of clicks.
    The idea here is to get the model to write SQL queries which is being executed, and the model will read the result and decide whether to search the code, or write another query, or report success.
    When I implemented the tool last year (mid-2024), the performance was very bad - it could not choose the table to use and the columns to read, and I had to specify them for the model.
    But in mid-2025, these performance issues have been resolved.
    There are still some defects (for example reporting that the click-through rate of the buttons is 100% without checking), but I expect the models to get better.
    Overall, the tool is already performing better than a contract data analyst.

There are processes that you can wait for someone else to build:
- Ideally you want coding tools like Claude Code to access all the internally public threads on Slack, and all the internally public Asana tasks.
    I think you can do what you want with Slack and Asana APIs.
    But I may not be building it, because I expect Slack and Asana to build them.

### Promoting AI adoption

You need to promote good use of AI.

Human engineers should share how they got AI to work, and the challenges they have faced.

In code review, comment on how your commit would have been done with AI, and discuss what is blocking AI from doing it.

You should establish practices that normalize AI delegation rather than manual implementation:

- Create templates for AI prompts that work well in your codebase. Share successful prompts in your team's documentation.
- Document patterns where AI consistently fails, so the team knows when human intervention is needed.
- Include "AI implementation notes" in your pull requests - explain what you delegated to AI, what you had to do manually, and why.
- Track metrics on AI effectiveness. How much time did AI save? What types of tasks does AI handle well in your specific codebase?
- Train junior engineers to think "AI-first" - their first instinct should be to delegate to AI, not to implement manually.

The goal is to shift the team culture from "I implemented this feature" to "I successfully got AI to implement this feature". This mental shift is crucial for productivity gains.


## The future of software engineering

Software engineering is transforming. The question is not whether AI will write code - it already does. The question is whether you will be the one orchestrating it.

The engineers who thrive in this new world will be those who invest in the right infrastructure:
- Tools that give AI access to context across all your systems
- Tools that let AI execute and validate its own work
- Standards that ensure AI creates maintainable, documented code

But more importantly, they will be the ones who embrace the mindset shift. You are no longer paid to type code. You are paid to ensure the right code gets written, tested, documented, and deployed.

Your value as a software engineer is not diminished - it is elevated. You move from being a craftsman making individual pieces to being an architect designing systems and processes. You move from writing code to ensuring code quality at scale.

The button your product manager asked for? In the old world, you would spend hours implementing it. In the new world, you spend those hours making sure AI can implement not just this button, but every button that comes after it.

That is engineering for software.


## Footnotes
