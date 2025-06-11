---
layout: post
title: How to empower your AI software engineer
---
AI will soon act as your peer software engineer. Similar to how you empower your human software engineer, this is how you empower your AI software engineer.


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


## Empower AI with feedback

TBC


## Footnotes
