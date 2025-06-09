---
layout: post
title: Engineering for Software (TBC)
---

Software engineering will soon become an exercise to get AI to write software.

- If there is a mistake, think whether are you wrong or the AI is wrong.

- You should build tools that AI is easy to use. Start from the command line.

- Think of the blockers to AI productivity.

- If there is a reproducible bug, it is easy for AI to solve.

- The bottleneck will be communication. The bottleneck between humans has always been communication.

- The more guardrails you give, the faster the AI can work. The more you restrict the model what the model can or cannot do, the more you trust it to not do the wrong things.

- Better unit tests.

- Better documentation in the code.

- Single source of truth.

- Build the knowledge graph so that AI can traverse.

- Educate your colleagues on how to use AI. Maybe in the commit message should include how simple the instruction is. Get people to learn the capabilities.

- Avoid investing effort where it will be overturned by better AI models. One frustrating thing is that the image models are blind and they report success when they should not. (Comment on what to do, what not to do)

- Your role is to build processes and oversee results. Hence Engineering for Software.

- You should connect your AI to data sources.

- Stop tolerating suboptimal interfaces. Tools that return responses with verification. Products that forces you to go through a lot of information before getting anything useful.

- You should use AI products where the product builder is aligned with your incentives.

- Make it very obvious when the AI is cheating. If the AI need to write a special case cover up an error, the special case can be surfaced. Get other AI to catch cheating.

- Optimize how much you want to read. Guide AI to communicate effectively. Commit messages should be short.

- You no longer implement a button on the website. Sure you still decide to implement a button. You may be getting AI to implement the button. You now need to think of how to get AI to implement. You will improve the processes on getting AI to implement. You will unblock AI to implement.

- Start with simple tasks. Delegate verifiable tasks first.


- Think of AI as a very competent remote contract software engineer. The engineer in the company you respect the most, but from another company.
- Think of what you are working on. Think whether is it something that you can done by the remote contract software engineer.
- You need to feel that - I should not be doing this, this could have been done by someone else.
- You need to build your own desire to delegate. When you are asked to implement a button, your first reaction should be - this is something that could have been done by an AI.

- This does not mean copying your entire company history to the context length. You are tasked with implementing a button. Provide AI all the context. You should not need act as the translator for AI. Invest in building connections.

- You should provide AI with access to these data. I think the model these days (Claude 4 Sonnet) is able to figure how what to search.

- Give the example of implementing a button.

- It is easier to leave AI to do whatever they want if you know the very few things AI has access to.
- In theory, AI can take over your browser and function as an remote employee. In reality we are not there yet, although we will soon be there.


Avoid processes that do not make sense.


- You should invest now. Tools that make it easier for AI also make it easier for humans. Some investments might not be worth it might be worth it now. (Give an example.)

- Continue with the example of implementing a button.



## Get into the mindset of delegating

Your product manager asks you to build a button.

Your first reaction should not be "how do I implement this button elegantly?". Your reaction should be - "is this something we can delegate to AI"?

You should still think how an elegant implementation would look like. You should still have standards on what elegant implementation is.
But you should be getting AI to implement the button - and implement it elegantly.
AI should be meeting your standards, you should not need to regurgitate your standards every time you ask AI to implement a button.



## Provide AI access to all the context available

This is how the company implements a button

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

You want to connect AI to all these data sources.



## Allow AI to execute, with guardrails

This is how you implement a button, as a software engineer

- You change the code
- You deploy an internal version of the product
- You test whether the button works.
- Repeat if there an issue.

This is manual. This is slow. You want to automate this process.

In theory, the AI today can take over your computer and do your job.
But you want to limit the extent of what you AI can read and write.
You do not want your code commits to contain information derived from private documents.
You do not want AI to send Slack messages on your behalf.

Here, you want to limit AI to changing the code, and then test the code.
You should build tools for the AI so that AI is able to deploy an internal version of the product and test whether the button works.



## Invest in processes

You are the factory manager, not a factor worker.
You run the factory that build buttons, you do not build buttons yourself.
You implement processes so that you can easily and quickly build things, starting from buttons.

As a software engineer, you should have standards on what good code is.
You need to implement processes so that AI will follow these standards.

There are processes that should already have been implemented
- Code linter, code formatter, and unittests
- Guidelines for commit messages

These are the standard processes in software engineering. Humans follow these standards. AI should also follow these standards.

There are processes that is now worth investing. With Sonnet 4, as implemented in Claude Code, models today are good enough to power agents.
- Making offline table queries. When I implement a button, I want to have a sense how often similar buttons are being clicked.
    We do record when and where people click buttons - and I need to write a SQL query to count the number of clicks.
    The idea here is to get the model to write SQL queries which is being executed, and the model will read the result and decide whether to search the code, or write another query, or report success.
    When I implemented the tool last year (mid-2024), the performance is very bad - it could not choose the table to use and the columns to read, and I had to specify them for the model.
    But in mid-2025, these performance issues I has been resolved.
    There are still some defects (for example reporting that the click-through rate of the buttons is 100% without checking), but I expect the models to get better.
    Overall, the tool is already performing better than a contract data analyst.

There are processes that you can wait for someone to unblock you.
- Ideally you want coding tools like Claude Code to access all the internally public threads on Slack, and all the internally public Asana tasks.
    I think you can do what you want with Slack and Asana APIs.
    But I may not be building it, because I expect Slack and Asana to build them.


(TODO: add another example of a process that is worth investing now)


## Propagate the good use of AI

Human engineers should share how they got AI to work, and the challenges they have faced.

In code review, comment on how your commit would have been done with AI, and discuss what is blocking AI from doing it.

(TODO)



## What is next

Getting AI to improve your processes.
AI should reflect on their work.

(TODO)


## Footnotes
