---
layout: post
title: Predictions for 2026
---
These are my predictions for 2026.[^2025]

[^2025]: See my [predictions for 2025](/2024/12/29/competitive-programming-and-superintelligence.html), [prompting in 2025](/2024/12/30/prompting-in-2025.html), and [mathematical superintelligence](/2025/01/02/mathematical-superintelligence.html) for reference.

There will continue to be more people working on AI models and products.
There will continue to be more compute.
Access to compute will be better.
You will also have competent AI that helps you improve AI.


## AI will be human-level at manipulating browsers

The only AI-powered browsing experience that I have tried is the Claude extension on Chrome.

There are a few read-only tasks I want it to do:
- Go to the date grid on Google Flights so I can see when the cheapest flights are
- Tabulate my rent options based on listings on Craigslist
- Estimate the value of my (mostly IKEA) furniture from an image of my room

The experience is very slow and very inaccurate[^puppeteer].

[^puppeteer]: I think I can get better results with Claude Code on puppeteer MCP with subagents.
    Regarding puppeteer MCP - even though [`@modelcontextprotocol/server-puppeteer`](https://github.com/modelcontextprotocol/servers/tree/main/src/puppeteer) is deprecated, I am not recommending [`@playwright/mcp`](https://github.com/microsoft/playwright-mcp) because it takes up more tokens (4k vs 14k) and "No vision models needed, operates purely on structured data" is outdated.

I see a few problems here:
- Every action has to be preceded by a thought process
- Context is filled up quickly and compaction is slow, because the model is trying to keep every screenshot
- The model is bad at managing multiple tabs and parallelizing work
- The model is kind of blind and only looks once[^blind]

[^blind]: AI is kind of blind - you can see that the bottom set of 30 x 30 matrices are [misaligned](https://www.quora.com/Is-ARC-wrong-and-flawed-and-not-an-AGI-test-at-all/answer/Tong-Hui-Kang-1), which should not pass any design review.
    I think o3 [pioneered a method](https://openai.com/index/thinking-with-images/) where the model zooms in to a specific section.
    I look forward to models drawing lines on an image to check whether they aligned the CSS correctly.

I hope to be able to trust AI with all my read-only browser tasks.
After AI earns my trust with their performance on read-only tasks, I can slowly trust AI with tasks that make changes.


## Context constraints will be invisible

For the user experience, I think context constraints should already be invisible to users of frontier AI products.
You should not be hit with an instruction on ChatGPT that your conversation is too long.
There are some processes in the background that compact the context.[^decaching]

For the developer experience though, you need to be aware of the context limits.
In 2025, the phrase [context engineering](https://www.quora.com/What-do-you-think-of-context-engineering/answer/Tong-Hui-Kang-1) was coined.

However, I think developers will no longer need to care about context length.
The model API will be shipped with context management,[^responses] similar to how you talk to your friend - you do not need to ask your friend to delete old messages so that you can continue talking to them.

[^responses]: OpenAI [released](https://developers.openai.com/blog/responses-api/) the [Responses API](https://platform.openai.com/docs/guides/conversation-state) in 2025 which tracks conversation state server-side.
    You do not need to pass in the entire conversation history with each request.
    Instead, you pass around an id representing the state of the conversation, and OpenAI keeps it up-to-date for you.
    You still need to manually call `/responses/compact` to compact the context.

This developer experience should already be achievable with existing models and a suite of scaffolds.
There might also be improvements in the model architecture to help.[^decaching]

[^decaching]: One way to scaffold this is to have a parallel summarization process that kicks in at 50k tokens to summarize into 10k tokens, and at 80k tokens, replaces the 50k tokens with the 10k token summary so the conversation continues from 40k tokens.
    I have an idea where the model discards the KV-cache of parts of the conversation that are no longer relevant, and uses tools to search the conversation history instead. This removes the need to generate 10k tokens every 50k tokens. One prime candidate for decaching is the screenshots when manipulating browsers.



## We will stop taking turns with AI

We are familiar with the chat interface with AI.
You type something, hit enter, and AI replies with something.
You are taking turns with AI.

The experience talking to another human is different.
You take note of their facial expression and body language.
You look up certain information while they are talking.
You write notes to yourself.
There are no explicit turns to take.

There are some efforts to break this turn-based experience with AI:
- You can interrupt while AI is replying.
- You may submit messages while AI is replying.
  However, how early your replies steer the response differs between products.

There are still some bottlenecks:
- Ideally the response to my question should be ready by the time I hit send.[^helpdesk]
- The AI may need to ask follow-up questions to clarify my search request.
  But the AI should already start searching in parallel.

[^helpdesk]: For some human-powered helpdesk chatbots, apparently the human operator can [see what you typed before you send](https://gizmodo.com/be-warned-customer-service-agents-can-see-what-youre-t-1830688119).

It is possible to achieve all this with a suite of scaffolds.
There might also be improvements in the model architecture to help.[^multichannel]

[^multichannel]: I wrote about how [models should be multichannel](/2025/05/14/multichannel-prediction.html) - humans have multiple input and output channels, and models should be able to converse like humans.


## AI will write their own instructions

Currently we expect models, with their harness, to complete any task with the resources available to them.
They are expected to use existing instructions.[^instructions]
Models are already expected to check their own work before reporting success.

[^instructions]: I have written about how [instructions are more than just user and system prompts](/2025/10/20/delivering-ai-instructions.html).

Soon we should expect AI to not just follow processes, but also to improve the processes.

Currently, the human needs to take the initiative to prompt the model to fix the instructions.
The instructions may include comments and docstrings in the code that inform future models.
The instructions may be [skills files](https://agentskills.io/home) that provide guides on how to execute certain processes.

We will see AI products taking the initiative to suggest changes to the process.
We will see models that tastefully fix outdated and inaccurate comments in the codebase.
We will see skills written, and maintained as they are being used.

## Footnotes
