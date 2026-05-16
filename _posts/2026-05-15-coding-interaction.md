---
layout: post
title: All coding models will be interaction models
---

Thinking Machines released [Interaction Models](https://thinkingmachines.ai/blog/interaction-models/) earlier this week.

I wrote about a similar idea about a year ago.
The post argued that the next generation model should be [multichannel](/2025/05/14/multichannel-prediction.html) - humans have multiple input and output channels, and models should converse the same way.
I have referenced the idea since, when [predicting](/2026/01/01/predictions-for-2026.html) that we will stop taking turns with AI, and when listing the [principles for AI products](/2025/09/07/principles-for-ai-products.html).

Coding was the first killer use case for LLMs.
Coding will be the first killer use case for interaction models, for the same reasons.

- The interaction surface is wide.
- The feedback signals are dense.
- The work is high enough value that imperfect models are still worth using.
- The bar is lower than for live voice. A text-only interaction model does not need to beat human reaction time at 200ms latency. It just needs to beat the wait-for-tool-call interaction we have today.[^voice]
- Most LLM tokens generated today are not seen by humans anyway. Internal channels (planning, thought, tool arguments) do not need to be optimized for human consumption, which removes a hard constraint.
- It is easier to evaluate than live voice. You can grade text against text. You can compare what each channel produced. You do not have to evaluate prosody, latency, or turn-taking quality.

[^voice]: A live TTS interaction model has to deal with real-time audio generation, prosody, turn-taking dynamics, and latency. A text-only coding interaction model just has to write tokens to different channels. The hard problems of multichannel coordination are still there, but the substrate is much easier.

I argue that all coding models will be interaction models.



## A coding session, phase by phase

You ask the coding agent to fix a bug in the recommendation pipeline.
For each phase of the session, I describe what it is today, and what it should be.

#### **Planning**

*What it is.*
The agent takes a turn.
First it thinks. Then it reads a file. Then it thinks again.
The plan is buried inside the thought process. You only see fragments.
If you want a structured plan, you invoke plan mode and wait for the agent to finish planning before it can do anything else.

*What it should be.*
The agent opens a planning channel.
The planning channel holds the running list of what is known, what is being tried, what is pending.
The plan is not buried inside a thought process. It is a separate channel you can read at any time.
You do not invoke plan mode. The plan is always being written.
This is just one of many channels the agent is running.[^channels]

[^channels]: The other channels include a user-facing channel (what you read in the interface), a code-writing channel (which is producing edits), and a terminal channel (which is sending commands). On the input side, the agent subscribes to your messages, the terminal output streaming live, file system events from the harness, and the CI service.

#### **Steering**

*What it is.*
Halfway through, you remember a detail you forgot to mention.
You type it into the chat box.
Your message is queued. It will be delivered at the next tool boundary.
By then the agent may have already wasted compute pursuing the wrong hypothesis.

It feels like the agent is stonewalling you.
You can see the tools the agent is calling and the files it is touching, but the agent does not acknowledge that you exist until it decides to pause.
There is no equivalent of nodding or saying "uh-huh, I heard that, let me finish this thought first".
You sent a message; the agent neither confirmed receipt nor objected.

When the agent asks you a clarifying question, the agent stops working.
While you type your answer, the agent does nothing.

You cannot interrupt the agent's chain of thought.[^interrupt-cot]
If you do, the agent abandons its current trace and restarts from your new message.

[^interrupt-cot]: When I tried interrupting `gpt-oss-120b` while it was working on math problems, the resulting trace became token inefficient - the interrupted thought was abandoned and the model started a fresh thought from the new user message. An interaction model should be able to absorb a mid-flight interruption and update its current stream without restarting.

*What it should be.*
You send a clarifying message mid-flight.
You mention that the bug only happens for users with empty histories.
The agent reads your message immediately without finishing its current thought.
The planning channel updates to include the new constraint.
The user-facing channel acknowledges that the agent heard you, even though the agent is still running on other channels.
You do not have to wait for a turn boundary, and you do not feel stonewalled.

The agent asks you a clarifying question.
It wants to know whether the empty-history users have the new ranker flag enabled.
While you read the question, the agent does not stop.
It keeps researching, tracing where empty-history users branch off in the code.
By the time you reply, the agent already has the relevant code in context.
Your answer steers what the agent does with the code it has already read - the research itself was not blocked on your reply.

#### **Executing**

*What it is.*
The agent runs a reproduction script. The script takes 90 seconds.
While the script is running, the agent is blocked.[^subagent]
You are also blocked.
You wait.

[^subagent]: Strictly, the harness could spawn subagents to do other work in parallel. But subagents are wrapped in tool calls, and the parent has to wait for the subagent to return. There is no streaming back to the parent while the subagent works.

*What it should be.*
The agent writes the same reproduction script and runs it.
The agent does not block on the script.
While the script runs, the agent reads related code on a separate stream.
The agent also watches the script output, looking for the line that confirms the reproduction.
When the line appears, the agent stops reading and writes a fix.[^interrupt-self]

[^interrupt-self]: This is one of the harder behaviors to train. The model needs to be able to interrupt one of its own streams when another stream surfaces something more important. This is a form of self-interruption, and it is different from being interrupted by the user.

#### **Testing**

*What it is.*
The agent runs the test suite. The output streams for two minutes.
The agent waits for the suite to finish before it acts on any of it.
The agent could have noticed the first failure within ten seconds, but it does not look at the output until the command exits.

*What it should be.*
The agent runs the test suite.
The agent watches the stream, and at the same time it drafts the PR description on the user-facing channel.
The first test failure triggers the agent to stop drafting and investigate.
The failure turns out to be unrelated to the fix.
The planning channel updates to note the flaky test.
The agent continues drafting the PR.

#### **Shipping**

*What it is.*
When the test suite passes, you ask the agent to push.
The agent pushes the branch.
The agent waits for CI to finish before it does anything else.
If you want a rollback plan, you ask for it as a separate turn.

*What it should be.*
When the test suite passes, the agent finalizes the PR.
You did not have to ask for status during any of this. The planning channel was already showing you the running state.
The agent pushes the branch and watches CI.
While CI runs, the agent writes a rollback plan on another channel.

#### **Compaction**

*What it is.*
The conversation gets long.
The harness compacts the context.

In Claude Code, this means clearing older tool outputs first, then summarizing the conversation if needed.[^compact-docs] You can also run `/compact` manually with an optional focus like `/compact focus on the API changes`. To control what is preserved, you add a "Compact Instructions" section to CLAUDE.md.

[^compact-docs]: From the Claude Code [docs](https://code.claude.com/docs/en/how-claude-code-works) on how the context window is managed. Auto-compaction also re-attaches recently invoked skills after the summary, keeping the first 5,000 tokens of each within a 25,000 token budget. Auto-compaction halts with an error if a single tool output is so large that context refills immediately after each summary.

The summarization itself is a separate, batched, blocking step. The agent stops the rest of its work to summarize.
Detailed instructions from early in the conversation may be lost. You are advised to put persistent rules in CLAUDE.md so that they survive compaction.

*What it should be.*
Compaction is not a separate, batched step.
The active channels carry the relevant state forward.
Older parts of the conversation can be dropped because nothing important is only there - it is also in the planning channel, the running code state, or the user-facing channel.
There is no need for a "Compact Instructions" section because there is no monolithic summarization step that needs to be instructed.
The agent does not stop to compact. It is already maintaining the state it needs.



## Your side of the interaction does not change much

You might be expecting that interaction models require new interfaces - voice, video, gestures, avatars.
They do not, for the coding case.

You still type into a textbox.
You still read text in a chat panel.
You still click buttons to approve commands.

What changes is on the model's side.
The model is no longer waiting for your turn.
The model is no longer waiting for a tool to finish.
The model is running many things at once, and your typing is one of the inputs it is reading.

The textbox is the same.
What is behind the textbox is very different.



## Implications

### Coding models are already on this trajectory

The same trajectory we saw for reasoning is the one I expect for interaction.

In 2024, reasoning was an opt-in feature.
OpenAI released [o1](https://openai.com/o1/) in September 2024 as a separate product.
You could pick between o1 and GPT-4o.
You could pick whether to use extended thinking with Claude Sonnet 3.5.

The distinction has collapsed.
Every frontier coding model today is a reasoning model.
Nobody ships a competitive non-reasoning model for coding.[^non-reasoning]

[^non-reasoning]: Some models still expose a non-thinking mode for smaller models and latency-sensitive use cases. However, on coding leaderboards the entries that matter are all reasoning models.

Reasoning models also happen to be the first widely-shipped models with something close to multi-stream behavior.
The thought process is one stream.
The user-facing response is another stream.
The streams are sequential, not parallel, but they are distinct streams with distinct purposes.

The pattern is - a capability starts as an opt-in feature, becomes the default, then becomes inseparable from the model.
I expect interaction to follow the same pattern.
There will be no flag to switch between "interaction mode" and "non-interaction mode".
Every coding model will be an interaction model.



### You will throw away your harnesses

Claude Code, Codex and Cursor paper over the model's inability to do more than one thing at a time.

These parts of the harness exist only because the model is single-stream. They will go away.

- Queued user messages.
  The harness queues your message because the model cannot read while it is writing.
- Prompting for compaction.
  The harness prompts the model to summarize because the model does not maintain its own running state.
- Subagents wrapped in tool calls.
  The harness spawns subagents because the model cannot run parallel streams natively.
- Plan mode and todo lists.
  The harness imposes a plan because the model cannot track multiple intents at once.
- Polling for long-running tool results.
  The harness polls because the model cannot read and act on partial output as it streams.

These parts of the harness stay, because they exist for reasons that are not about being single-stream.

- Bash execution.
  The model still cannot run shell commands on the user's machine.
- File system access.
  The model still needs the harness to read and write files.
- Browser and sandbox controls.
  The model still needs the harness to expose the environment safely.
- Authentication and authorization.
  The harness still owns the credentials and the access boundaries.
- Persistence.
  The harness still saves transcripts, checkpoints, and rollbacks.
- Agent [skills](/2026/02/21/skills.html).
  Interaction or not, the model needs to learn about the system it is working on - where to find information, who to ask for what, the company's conventions, the pitfalls to avoid. Skills are how the model discovers this. The interaction capability does not remove the need for skills.

The harness becomes very thin.
It is a router that wires streams from the real world into the model, and routes the model's outputs back into the world.



### Do not bother scaffolding current models into interaction models

Some of the behaviors I describe above can be approximated by scaffolding around today's single-stream models.
You can train the model to emit a planning section that the harness parses out. You can spawn lots of subagents. You can stream tool output into the model's context as it arrives, with elaborate prompting on how to interrupt itself.

I do not think it is worth investing too much engineering effort in this scaffolding.

If the prediction is correct, in two years the model will do all of this natively.
The scaffolding will be obsolete, the prompts will be obsolete, the harness-side parsers will be obsolete.
Better to go straight to training interaction models, even if early versions are worse than the current scaffolded approaches.

This is the same argument that applied to reasoning.
You could approximate reasoning in 2024 by prompting GPT-4 to "think step by step" before answering, with a parser around it.
That work was obsolete the moment o1 shipped.



### The value beyond iterating with humans

You might think interaction models matter mostly for humans talking to AI in real time.
You do not need to be in the loop for interaction models to matter.

The walkthrough above contains several places where the model is not waiting for you.

- It read related code while a reproduction script was running.
- It drafted the PR while the test suite was running.
- It wrote the rollback plan while CI was running.

All of these are asynchronous workflows.
For most of them, you are not in the loop at all.

The benefit is that the model is no longer blocked on slow I/O.
A human engineer does not sit and stare at the terminal while a build runs.
Neither should the model.



## Think about what optimal interaction looks like

I have described one shape of the optimal interaction.
There are many more.

If you work with coding agents, you have direct evidence of where today's interaction fails you.
You know when the agent stonewalls.
You know when you have to queue messages and wait.
You know when you would have wanted the agent to keep researching while you typed.
You know when you would have wanted the agent to interrupt you.

Think about what the optimal interaction should look like for your work.
Write it down.
Walk through a real task end-to-end the way I have here, and describe what each side should be doing at each moment.

It is much easier to ask for the optimal interaction once you have written it out.
Model providers and harness builders cannot guess your workflow.



## Closing

The argument for multichannel models was originally about humans talking to AI.
Coding is where the interaction surface is widest.
Logs, files, terminals, browsers, queued user messages, CI services, deploys.

All coding models will be interaction models.[^robotics]

[^robotics]: Coding is the first killer use case. It is not the only one. A general robotics model should also be an interaction model - the robot needs to be reading its sensors, planning its next motion, executing the current motion, and listening to the human all at the same time. The substrate is harder (continuous motor control, real-time constraints) so I do not expect robotics to be first. But the same multichannel argument applies.



## Footnotes
