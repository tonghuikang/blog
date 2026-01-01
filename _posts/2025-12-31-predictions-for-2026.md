---
layout: post
title: Predictions for 2026
---
These are my predictions for 2026[^2025].

[^2025]: Please refer to my [predictions for 2025](/2024/12/29/competitive-programming-and-superintelligence.html) for reference.

There will continue to be more people working on AI models and products. There will continue to be more compute. Access to compute will be better. You will also have competent AI that helps you to improve AI.



## AI will write their own instructions

Currently we expect models, with their harness, to complete any task with the resources available to them.
They are expected to use existing instructions (I had written that instructions is more than just user and system prompt <todo: cite>).
Models are already expected to check their own work before reporting success.

Soon we should expect AI to not just complete its task, but also to improve the process of completing similar tasks.
This involves writing instructions.

Currently, the human will need to prompt the model to fix the instructions.
The instructions may include comments and docstring in the code that inform future models.
The instructions may be skills files which provides the guide on how to execute certain processes.

We will see models taking initiative to suggest changes to the process.
We will see models that tastefully fix outdated and inaccurate comments in the codebase.
Similar to how we trust competent engineers to improve the code they are working on.


## Context constraints will be invisible

I think context constraints should already be invisible to users of frontier AI products.
You should not be hit with an instruction on ChatGPT that your conversation is too long.
There are some processes in the background that compacts the context. (please cite)

For developers though, you need to be aware of the context limits. In 2025, the phrase [context engineering](https://www.quora.com/What-do-you-think-of-context-engineering/answer/Tong-Hui-Kang-1) is coined.

However, I think developers will no longer need to care about context length.
The model API will be shipped with context management.
It is similar to how you talk to your friend.
You do not need to ask your friend to delete the old messages so that you can continue talking to them.

OpenAI released the [Responses API](https://platform.openai.com/docs/guides/conversation-state) in 2025 which tracks conversation state server-side. You do not need to pass in the entire conversation history with each request. Instead, you pass around an id representing the state of the conversation, and OpenAI keeps it up-to-date for you.

This developer experience should already be achievable with existing models with a suite of scaffolds.
However, you might need some [changes](/2025/05/14/multichannel-prediction.html) to the architecture and training to minimize the scaffolds necessary.

[^compaction]:  Write a note that for responses API you still need to compact. For long-running conversations, OpenAI already offers the `/responses/compact` endpoint to shrink the context you send with each turn.



## AI will be human-level at manipulating browsers

The only AI powered browsing experience that I have tried is the Claude extension on Chrome.

There are a few read-only tasks I need to get it to do
- Go to the date grid on Google Flights so that I can view when is the cheapest flight to book
- Tabulate my rent options based on listings on Craigslist
- Calculate the value of my (mostly IKEA) furniture given the image of my room

The experience is very slow and very inaccurate. I think I can get better results with Claude Code on puppeteer MCP[^puppeteer] with subagents.

I see a few problems here.

- Every action has to be preceeded by a thought process
- Context is filled up quickly and compaction is slow, because the models is trying to keep every screenshot
- The models is bad at parallelizing work
- The models are kind of blind. (footnote)
- The models only look once. (o3-pro footnote)

(footnote): Even though @modelcontextprotocol/server-puppeteer is deprecated, not recommending @playwright/mcp because it is taking up more tokens (4k vs 14k) and "No vision models needed, operates purely on structured data." is outdated

(footnote): AI is also kind of blind. You see that the bottom set of 30 x 30 matrices are misaligned. This should not pass any design review. https://www.quora.com/Is-ARC-wrong-and-flawed-and-not-an-AGI-test-at-all/answer/Tong-Hui-Kang-1

(o3-pro footnote): I think o3 pioneered a method what the model zooms in to a specific section. I look forward to models drawing lines to an image to check whether did they align the CSS correctly.

I hope to be able to trust AI with all my read-only browser tasks.
After AI gets my trust with their performance on read-only task, I can slowly trust AI with tasks that (fillme) tasks.



## We will stop taking turns with AI

We are familiar with the chat interface with AI.
You type something, send enter, and AI replies you with something.
You are taking turns with AI.

There are some efforts to break this turn-based experience
- You can interrupt while AI is replying.
- You may submit messages while AI is replying. However, how early your replies steer the response differs between products.

There are still some bottlenecks
- Ideally the response to my question should be ready by the time I hit send.[^helpdesk]
- The AI may need to ask follow-up questions to clarify my search request. But the AI should already start searching in parallel.
- ???

It is possible to achieve all this user experience with the suite of scaffolds.
However, you might need some [changes](/2025/05/14/multichannel-prediction.html) to the architecture and training to minimize the scaffolds necessary.

[^helpdesk] For some human powered helpdesk chatbots, apparently the human operator can see what you typed before you send. (citation needed)

When you talk to another human, there are no explicit turns to take.
You take note of their facial expression and body language.
You look up certain information while they are talking.
You write notes to yourself.


## Footnotes
