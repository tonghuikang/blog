---
layout: post
title: Engineering for Software
---

Software engineering will soon become an effort to engineer and empower to get AI to write software.

I write how you should do it, and what mindset do you need to have.



## Empower AI with all the context available

Your product manager asks you to build a button on your website.

This is how the process of implementing a button goes

- Leadership wants to focus on a certain aspect (improve product experience)
- Research was done, feedback was solicited on what is the biggest pain points in product experience
- The product manager decides to implement a button that does something (pinning comments)
- The product designer creates mock-ups on how the button should look like, and thinks though edge cases
- You (the software engineer) execute

If you ask AI to implement a button, you need to translate everything. You should not need to do this.

However, all the information is not in one place. This is where all the information lives

- The meeting notes with leadership happens on Notion / Google docs / Quip
- The feedback was solicited on email
- The product manager documents projects on Asana
- The product designer implements the mocks on Figma
- You are informed through Slack that the button is ready for implementation
- Your code lives on Github

You want to connect AI to all these data sources. AI should be given access to all the internally public information so that it can gather all the context it needs to do well at the job. You need to invest in tools that AI can use to access all the context they want.

But context alone is not enough. AI needs to be able to act on that context.


## Empower AI with the ability to execute

This is how you implement a button, as a software engineer

- You change the code
- You deploy an internal version of the product
- You test whether the button works.
- You run the formatter, lint, and unittests.
- Repeat if there an issue.

This is manual. This is slow. You want to automate this process.

You should provide AI access the ability to execute
- Give AI the ability to edit code
- Give AI the ability to initiate the deployment of an internal version of the product
- Give AI the ability to the code development tools (formatter, lint, and unittests)
- Give AI the ability to manipulate the browser to test whether the button works

This means you need to build tools for AI. 

Here, you want to limit AI to changing the code, and then test the code.
You should build tools for the AI so that AI is able to deploy an internal version of the product and test whether the button works. You need to invest in tools that AI can use to effectively execute.

Execution creates artifacts. But without proper documentation, those artifacts become technical debt.


## Empower AI to create memory

When humans write code, they leave breadcrumbs - comments explaining why something was done, commit messages describing what changed, documentation explaining how systems work. AI should do the same.

Help AI to write good comments. You need to communicate to AI what good comments are. Not just what the code does (AI can already see that), but why it was written that way, what alternatives were considered, what constraints influenced the design.

Help AI to write good commit messages. You need to communicate to AI what good commit messages are. A good commit message explains the motivation, not just the mechanics. "Add button to pin comments" is bad. "Enable users to highlight important discussions by pinning comments, addressing feedback from Q3 user survey" is good.

Help AI to maintain documentation. When AI changes an API, it should update the API docs. When AI adds a feature, it should update the README. When AI discovers a gotcha, it should document it for the next engineer.

You need to invest in standards that AI can follow to create memory. This memory becomes the context for future AI agents - and for future human engineers.

These three pillars - context, execution, and memory - form the foundation of AI-powered software engineering. But having the tools is not enough. You need the right mindset to use them.


## The mindset you need to have

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
