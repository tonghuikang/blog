---
layout: post
title: Predictions for 2026
---
These are my predictions for 2026[^2025].

[^2025]: Please refer to my [predictions for 2025](/2024/12/29/competitive-programming-and-superintelligence.html) for reference.

There will continue to be more people working on AI models and products. There will continue to be more compute. Access to compute will be better. You will also have competent AI that helps you to improve AI.



## AI will write their own instructions

Models are not expected to just complete a task. Models will think of ways to improve itself at doing similar tasks. Models will write their own instructions, and test their instructions.

Systems will scrutinize every interaction you have with AI. Every task will either be perfectly done, or the system will figure out what went wrong and how to avoid such mistakes in the future[^perfect]. Future conversations with AI will [improve](/2025/09/14/improve-ai-software-engineering.html) on the learnings of past conversations.

[^perfect]: A perfect task here is one where the user does not need to give any follow-up instruction. We should focus on the outcome to the user, as I have [written](/2025/01/01/interacting-with-ai.html) before.



## Context constraints will be invisible

Currently we have a limited context window. We have options to use 1 million length context, but models do not perform well under long context[^niah].

[^niah]: The needle in a haystack problem is not a good benchmark for long context performance. The correct solution to the needle in a haystack problem is to use grep over context. We do not need frontier models to perform perfectly at the needle in a haystack problem. The benchmark [underestimates](https://research.trychroma.com/context-rot) what most long context tasks require in practice.

OpenAI released the [Responses API](https://platform.openai.com/docs/guides/conversation-state) in 2025 which tracks conversation state server-side. You do not need to pass in the entire conversation history with each request. Instead, you pass around an id representing the state of the conversation, and OpenAI keeps it up-to-date for you.

Models should be able to do well even limited to 8k context. I do not think human context length is that long either. I expect models to take notes on what is relevant to the task, drop the KV cache of information that is irrelevant to the task, and continue with the task[^compaction]. Context constraints will become invisible to developers.

[^compaction]: For long-running conversations, OpenAI already offers the `/responses/compact` endpoint to shrink the context you send with each turn.



## AI will be human-level at manipulating browsers

Currently models try to keep the entire browsing history in context. Claude Code tries to keep all the screenshots in context, and when Claude Code works on frontend tasks it frequently needs to execute [context compaction](https://www.anthropic.com/engineering/claude-code-best-practices).

Do you really remember what you saw one minute ago?

I would expect models to scan the screen, make a quick note, drop the KV cache, and save the image to the filesystem. Training this is more complicated, because the prompt in the prompt-completion pairs that you train on is more involved.

This unlocks many things. For example, collating all the information on a webpage[^browser-agent]. There will still be another line of work where agents navigate the web through API calls rather than browsers.

[^browser-agent]: Claude Code now [supports](https://www.anthropic.com/news/claude-for-chrome) direct browser integration with the `--chrome` flag. Previously, giving Claude Code browser access meant taking screenshots and dropping them into the session.

Models will be very clear what is read and what is write. Models will be more careful when making actions that cannot be undone.



## We will stop taking turns with AI

Currently I need to type to Claude Code. Ideally as I am typing, models should already start thinking.

I have [written](/2025/05/14/multichannel-prediction.html) about multichannel models before. Humans are multichannel - we think while we talk, we read facial expressions while we listen. Models should be multichannel too.

This is also related to the point on context compaction. Models should be able to work on their task while waiting for commands to finish executing. Models should be able to watch logs streaming, while continuing to read the codebase.

I look forward to sharing my screen with Claude Code, and the model actually using what it sees on the screen.



## AI will be able to polish your work

As I write this blogpost, ideally AI should just read my tweets, research the context, and write a presentable blogpost for me which I hope that I would have written. AI that matches what you like and what you have produced[^prior-work].

[^prior-work]: Much of what we do is to remix what we have done in the past, and the exemplar work of other people.

The difference here is that models are not perfect at generating content in the exact style that you want. Models cannot replace Simon Willison yet[^simon]. The input to Simon Willison is the Internet. I have [written](/2024/12/30/prompting-in-2025.html) about how prompting should be automated.

[^simon]: Simon Willison writes prolifically about AI developments. His style and output is distinctive and not easily replicable by current models.

I expect video models to be able to remix content as well.

I think video models are already able to do this. I expect a full-length anime series where final output is AI-generated. However, this does not mean video models are good at directing. I expect plots to be written and key animation frames to be hand drawn. I expect Frieren vs Frieren to be hand directed[^frieren].

[^frieren]: The Frieren vs Frieren fight scene is in [episodes 25-26](https://frieren.fandom.com/wiki/Episode_26) of Frieren: Beyond Journey's End, where Frieren and Fern battle Frieren's clone. The staff at Madhouse were praised for the visuals and animation. We will still prefer the professionally directed version over AI direction.

For some more creative scenes, the sequence is more abstract. I have never done animation - I only see key frames posted on Twitter which I assume is how anime is made[^storytelling]. Oshi no Ko Season 2 had [creative sequences](https://blog.sakugabooru.com/2024/09/04/oshi-no-ko-stage/) that visualized competitive acting instincts through powerful abstraction of feelings.

[^storytelling]: Storytelling is hard. I do not think AI have good models for humans on what humans like. AI needs to be able to predict the comment section and improve the comment section. If you have prior work that has been published, the comment section is an important input to your work.


## Footnotes
