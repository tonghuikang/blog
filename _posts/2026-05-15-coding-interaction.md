---
layout: post
title: All coding models will be interaction models
---

Thinking Machines released [interaction models](https://thinkingmachines.ai/blog/interaction-models/) earlier this week (One year ago, I called them [multichannel models](/2025/05/14/multichannel-prediction.html)).

I argue that all frontier coding harnesses will soon be using only interaction models.


## What is an interaction model

Current frontier models (Opus 4.7, GPT-5.5) that we interact with are non-interaction models.
They have one output stream.
They are next-token predictors - they write one token at a time, each token conditioned on everything that came before, and have to finish one thought before starting another.
To do two things, they have to do one and then the other.

An interaction model runs many channels of input and output in parallel, instead of one stream that takes turns.
It can think on one channel while it writes to you on another, while it watches a tool's output on a third, while it edits a file on a fourth.
The streams are concurrent, not sequential.

On the input side, an interaction model is not waiting for a turn either.
It reads your messages as you type them, terminal output as it streams, file changes as they happen, webhook events as they arrive.
None of these block the others.

The shape comes from how humans work.
A person on a coding task is reading the screen, hearing a coworker, typing, thinking about what to do next, and watching a test suite stream - all at the same time.
An interaction model is the same shape.

Thinking Machines' [post](https://thinkingmachines.ai/blog/interaction-models/) has video demos that make this concrete - [seamless dialog management](https://www.youtube.com/watch?v=Ys6i_MGnjUA), [visual interjection](https://www.youtube.com/watch?v=n2GXGjy41HQ), [simultaneous speech](https://www.youtube.com/watch?v=2ky5MXBvZP8), and [simultaneous tool calls and search](https://www.youtube.com/watch?v=ly3GtaiRFyo).
The demos are voice-and-video rather than coding, but the same multi-stream idea applies.


## Think of how you interact with AI coding tools

You ask the coding agent to add an "Export to CSV" button to your analytics dashboard.
For each phase of the session, I describe what it is today, and what it should be.


#### **Listening**

*What it is.*
You ask the model something like "add Export to CSV to the dashboard".
You can send immediately, or refine your statement in full (which dashboard, what is the time limit[^banks]) before sending.
You may be dictating through a speech-to-text tool like Wispr Flow, or macOS dictation.[^voice]
Whatever you type, delete, or rephrase before sending is invisible to the model.
The model only sees the final message when you hit send, and starts working from there.

*What it should be.*
You ask the model something like "add Export to CSV to the dashboard".
When you complete the first phrase, the agent starts to research your code.
As you modify and elaborate more, it steers the research in real time.
By the time you complete your multi-sentence request, the model has already made significant progress in the research.
The agent can already ask useful follow-up questions for your request.

[^banks]: For some reason all the banks I use make it difficult for me to export all my transaction history at once.

[^voice]: Coding tools should ship with dictation (the human's voice in) and text-to-speech (the model's voice out) built in. 
    Today they do not.
    I had to add a [TTS hook](https://github.com/tonghuikang/claude-code-template/blob/main/.claude/hooks/notify_kokoro.py) to my Claude Code template so the agent can speak its notifications out loud.
    I do not have voice dictation software.


#### **Researching**

*What it is.*
The agent starts with a general instruction on what to do "add Export to CSV to the dashboard".
Claude Code could decide to search the codebase in parallel with [Explore](https://code.claude.com/docs/en/sub-agents) subagents.
Claude Code writes the instruction up front for the subagent.
One subagent explores the dashboard component.
Another subagent explores the data query.
Another subagent explores the design components.
However, the main agent writes the instruction up front, waits for the subagent to return, and reads only its summary - it does not see what exactly the subagent saw.
Claude Code cannot steer subagents mid-flight.
Information learnt from one subagent cannot influence the research process of another subagent.
This slows the overall research process, and is likely incomplete because subagents do not talk to each other.

*What it should be.*
The agent starts with a general instruction on what to do "add Export to CSV to the dashboard".
The agent immediately starts multiple channels that investigate the different components.
One channel explores the dashboard component.
You do not waste tokens explaining the situation to the subagent.
Another channel, with the same prefix, explores the data query.
Another channel, with the same prefix, explores the design components.
Information learnt from one channel is immediately shared with another channel.
With each channel informed of how the other channels are doing, the research process is faster and more complete.
For example, if it is discovered that we have similar data export functions for chat history, this information helps to inform the design components to use and the data queries to make.
When the research is done, you also do not waste tokens writing the summary.


#### **Aligning**

*What it is.*
There are design decisions involved in a simple button to export a CSV.
Do we give a choice to the user on what to export?
Is exporting instantaneous, or is the user required to check back after an hour or so for their data?
These are questions you need to ask the user.
There is a tradeoff on whether you want to ask the questions early, or whether you want to do your research first before asking the questions.
There is a tradeoff on whether to even ask the question, because Claude Code currently does not work in the background when questions need to be answered.

*What it should be.*
The agent should not need to make these tradeoffs.
The agent could ask questions as early as they can while working on the research in the background.
The agent could retract questions if they have found the answer in the resources (for example, there are data exports that are not instantaneous for data requests of smaller sizes).
All responses to the agent will immediately influence the research.


#### **Steering**

*What it is.*
The agent is already working - it has drafted the button, wired up the export handler, and is running a first export to see the output.
Halfway through, you notice that the button text is not visible in dark mode.
You type a correction into the chat box.
Your message is queued until the next tool boundary - it feels like the agent is stonewalling you.
You can interrupt the agent to get your queries immediately answered, but this discards the agent's current progress.

*What it should be.*
You point out that the text is not visible in dark mode.
The model reads your message immediately and acknowledges your comment.
The planning channel updates to include the new constraint.
The implementation channel will pick it up at the next available opportunity.
You do not have to wait for a turn boundary, and you do not feel stonewalled.


#### **Approving**

*What it is.*
The agent wants to run the export against the production database to validate it on real data, and it needs your approval to do so.
The agent halts and surfaces the approval prompt.
You approve or deny[^auto-mode].
Everything else the agent was doing - drafting the button, type-checking the handler - stops too.
The model is single-stream, so a pending approval blocks all the work.

*What it should be.*
The agent surfaces the approval to run the export against production on a dedicated approval channel.
Only the export channel pauses.
The other channels keep running - the agent continues drafting the button code and refining the export handler while you decide.
If you approve, the paused channel resumes and the export runs.

[^auto-mode]: I am aware that Claude Code has an auto-mode where the agent has a process to automatically decide which commands are safe to run.
    However, I think interaction models are useful here, there could be one channel where the model decides whether to approve running the command.


#### **Testing**

*What it is.*
Testing follows a linear process.
Your dashboard has hundreds of existing tests that programmatically test each component.
You need to choose a testing setup - do you stop tests on the first failure, or do you continue to run all the tests?
If the agent stops tests on the first failure, the agent will not be aware of the other tests that will fail and the agent will need multiple round trips to fix.
If the agent lets all the tests run, the agent will not be able to fix the first failure as soon as it can.[^monitor]

*What it should be.*
The agent starts testing and there is one input channel dedicated to listening for errors.
There is an output channel that surfaces testing issues.
If there is indeed a failure, the channel working on the code will be informed and it will be expected to investigate and fix the failure.
Tests can continue to run so that if there are more test failures, they will be surfaced to the agent.
We get both early fixes to failures, and reduced round trips between fixing and testing.

[^monitor]: Claude Code has this [monitor tool](https://code.claude.com/docs/en/tools-reference#monitor-tool) where the agent will monitor something in the background.


#### **Compacting**

*What it is.*
The inference infrastructure is not wired to generate tokens after a certain context length.
Models are also not trained to generate tokens after a certain context length.
Agents need to compact their context before more tokens can be generated. [^million-token-context]
The agent cannot do anything when it is compacting.

*What it should be.*
Compacting should be done in parallel.
As the agent works on the problem, there should be another channel that decides which information is worth storing and which information should be removed from context.
Information removed from context should still be searchable from any channel.

[^million-token-context]: There are models with millions of tokens of context.
    In my experience with Opus 4.7, I feel that the model simply forgets a lot of things after the 200,000th token.
    I would rather the model automatically compact at the 200,000th token.


#### **Improving**

*What it is.*
After you ship your feature, you want to improve your future experience working with the model.
You write and improve skills that help you do your work more efficiently.
For example, when testing the dashboard, the agent should remember to try both light and dark mode and confirm visibility of every text element.
The agent will need to search their history and correctly surface pain points that could have been informed with skills.

*What it should be.*
Reflection happens continuously in a dedicated channel that the agent maintains throughout the session.
When the agent finds out that the button text is not visible in dark mode, the reflection channel should note down the issue in parallel.
When the feature is shipped, the agent will propose to make improvements to AI instructions.


## Implications

If interaction models are coming, here is what I think changes for users, builders, and the model market.


#### **Humans will prefer the better interface**

I still prefer Claude Code as my main interface.

For most of the work that I do, it is not possible for me to give perfect instructions in the first turn.
I also operate with imperfect information, and I do not have all the answers.
I need to interact with the agent to understand the problem together.

For me, Claude Code still feels easier to interact with.

I do not really care whether one model is slightly more intelligent than the other.
I care about how easy it is for me to communicate with the agent and get things done.

The companies that ship interaction models first will set the floor for what users expect.
Going back to a single-stream model will feel like going from a chat app to email.



#### **Current interfaces will continue to be supported**

Coding agents using interaction models should not require you to turn on your webcam and microphone.

You should still be able to talk to your coding agent with chat, just that it is more responsive and effective.

For users, you should continue to be great at using the current text-interface AI coding tools.



#### **You will still need to teach your coding agent**

The coding agent does not know about your business.

You will still need to teach your coding agent the environment you are working with.
Even with interaction models, the model still starts every session afresh.

You will still need to manage instructions and resources for the agent to access.
Skills will continue to be written.
Resources will still need to be accessed.



#### **The model will decide everything**

Currently the harnesses manage plenty of decisions - for example, whether to compact, whether to auto-approve a command, and the context reset after planning mode.

A lot of the harnesses are built with the assumption of a single-stream model - compaction, monitoring, chain-of-thought.
Prompts are written and evaluated.
With this, I think most of the harnesses that we use today will be thrown away.

If I am building yet another coding tool, I will make the harness work only with interaction models.





#### **There will be one coding model size**

My bet is that the coding model market will collapse to one model size served via API[^local-models].

Currently Claude Code by default is served with two models - Opus as the main model and Haiku as the explore model.

With interaction models, everything will be one model, which means one model size.

There will be different knobs that the model can decide to turn for itself.[^knobs]

[^local-models]: If there are models of different sizes being developed, I think they are local models that need to be run on device.

[^knobs]: We are familiar with the thinking effort as a knob.
    I think models should be able to tune their thinking effort by prompting themselves.
    There are other knobs that could be turned if you train the model to do so.
    Maybe the size of the prefix that you can attend to is tunable.
    Maybe the number of experts that you can use is also tunable.



## Closing

Coding is the first killer use case for LLMs.

I think coding will also be the first killer use case for interaction models.

All coding models will be interaction models[^robotics].

[^robotics]: I think the first human-level robotics model will also be an interaction model.


## Footnotes
