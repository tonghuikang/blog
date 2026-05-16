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
You can send immediately, or refine your statement in full (which dashboard, what it the time limit[^banks]) before sending.
You may be dictating through a speech-to-text tool like Wispr Flow, or macOS dictation.[^voice]
Whatever you type, delete, or rephrase before sending is invisible to the model.
The model only sees the final message when you hit send, and starts working from there.

*What it should be.*
You ask the model something like "add Export to CSV to the dashboard".
When you complete the first phrase, the agent starts to research your code.
As you modify and elaborate more, it steers the research realtime.
By the time you complete your multi-sentence request, the model has already made significant progress in the reasearch.
The agent can already ask sensible follow-up questions for your request.

[^banks]: For some reason all the banks that I use makes it difficult for me to export all my transcation history at once.

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
However, the main agent writes the instruction up front, waits for the subagent to return, and reads only its summary - it does not see what the subagent saw, and it cannot steer the subagent mid-flight.
Claude Code cannot steer subagents mid-flight.
Information learnt from one subagent cannot influence the research process of another subagent.

*What it should be.*
The agent starts with a general instruction on what to do "add Export to CSV to the dashboard".
The agent starts immediately starts multiple channels that investigates the different component.
One channel explores the dashboard component.
Another channel, with the sample prefix, explores the data query.
Another channel, with the sample prefix, explores the design components.
Information learnt from one channel is immediately shared with another channel.

#### **Aligning**

*What it is.*
The agent is not sure which columns the export should include, or whether it should be filtered to the dashboard's current view.
It either dives in and exports all twelve columns unfiltered, or asks "which columns?" and stops working until you reply.
The question is often the wrong one - the agent could have inferred which columns the dashboard surfaces by reading the component, while missing the genuine ambiguity about the filter.
When the agent does ask, it does not surface its current interpretation, so a disagreement over what "the dashboard's current view" means only shows up after the export is wrong.
Your answers are coupled too - "which columns" depends on "filtered or full" - but the agent asks them as a flat list, not as a dependency tree.
There is no middle ground between guessing and blocking.

*What it should be.*
The agent asks "which columns?" and "filtered or full?" on the user-facing channel while it keeps researching the CSV utility and the dashboard's data queries on other channels.
It surfaces its current interpretation alongside the question - "I see twelve columns on the dashboard, including derived metrics; should the export include all twelve, or the raw columns underneath?" - so you can correct the framing, not just the answer.
It proposes a reasonable default and flags the assumption on the planning channel, instead of blocking on every choice.
When you answer one question, the agent integrates and re-asks downstream questions only if they are still ambiguous.
By the time you reply, the agent already has the relevant code in context, and your answer steers the research that is already in flight.

#### **Steering**

*What it is.*
The agent is already working - it has drafted the button, wired up the export handler, and is running a first export to see the output.
Halfway through, you notice it has wired the button to the wrong dashboard.
You type a correction into the chat box.
Your message is queued until the next tool boundary, and by then the agent has wasted compute on the wrong dashboard.
The model has only one output stream, so its thinking and its user-facing output share it.
You see file operations and tool calls but no acknowledgment that you exist - the agent feels like it is stonewalling you.
You cannot interrupt the model's chain of thought either.[^interrupt-cot]
To steer, you have to restart from your correction.
The main agent abandons its trace, and any Explore subagents that were still mapping the wrong dashboard's data layer have to be killed and re-spawned with the right dashboard in mind, losing the context they had built up.

*What it should be.*
You send a course correction mid-flight - the agent is wiring the button to the wrong dashboard, or you remember that some of the columns are internal-reference IDs that the end user does not care about.
The model reads your message immediately without finishing its current thought.
The planning channel updates to include the new constraint.
The model thinks and communicates at the same time, on separate channels.
Chain of thought is for the model's own reasoning, not for human consumption - it can be exposed, but it is verbose and meandering by design and is not the most efficient way to communicate with you.
The user-facing channel speaks differently: concise, direct, addressed to you.
It acknowledges that the model heard you, while the thinking and code-writing channels keep running in parallel.
You do not have to wait for a turn boundary, and you do not feel stonewalled.

[^interrupt-cot]: When I tried interrupting `gpt-oss-120b` while it was working on math problems, the resulting trace became token inefficient - the interrupted thought was abandoned and the model started a fresh thought from the new user message.
    An interaction model should be able to absorb a mid-flight interruption and update its current stream without restarting.


#### **Approvals**

*What it is.*
The agent wants to run the export against the production database to validate it on real data, and it needs your approval to do so.
The agent halts and surfaces the approval prompt.
You approve, deny, or "allow always for this pattern".
Everything else the agent was doing - drafting the button, type-checking the handler - stops too.
The model is single-stream, so a pending approval blocks all the work.
The choices the harness offers you are coarse.
You pay attention to every prompt and slow the agent down, trust allow-list patterns and sometimes auto-approve the wrong thing, or flip to auto mode and let the agent do anything.[^auto-mode]
The patterns themselves are not very expressive - you can pre-approve `Bash(psql:*)` for a project, but you cannot make it conditional on the database URL pointing to staging rather than production.
When the agent does ask, the prompt is the bare command - it does not surface what the agent expects to happen, why it wants to do this, or what it would do if you denied.

*What it should be.*
The agent surfaces the approval to run the export against production on a dedicated approval channel.
Only the export channel pauses.
The other channels keep running - the agent continues drafting the button code and refining the export handler while you decide.
If you approve, the paused channel resumes and the export runs.
If you deny, the agent updates the planning channel and considers an alternative, like running against a staging snapshot instead.
The distinction from Aligning's clarifying questions matters - approvals are about authorization, not scope.
The harness still owns the authorization boundary even when the model is multi-stream.
What changes is that asking for authorization no longer freezes the work.

[^auto-mode]: Claude Code's permission modes range from approve-every-action to `bypassPermissions` (sometimes called auto mode or YOLO mode), which lets the agent do anything without asking.
    Auto mode is fast but unsafe - any mistake is committed before you can object.
    Most experienced users settle somewhere in the middle, with an allow-list of patterns they trust, but the allow-list does not adapt to context.


#### **Executing**

*What it is.*
A coding session is full of long-running tool calls - the export running against a large dataset, the test suite, the type checker, the CI run, a database query, a deploy.
Each takes seconds to minutes, and the agent is blocked while it waits.[^backgrounding]
You are also blocked.
Even when the answer is obvious in the first ten seconds of output - the first test fails with a clear error, the first 1000 rows of the export reveal a format issue - the agent does not look until the command exits.

*What it should be.*
The agent reads streaming output as it arrives, not after the command exits.
If the first test failure shows the bug, the agent kills the suite and investigates without waiting for the rest.
If the export reveals a format issue early, the agent kills the run, fixes the bug, and starts another - no 90-second wait.
Tool calls fan out in parallel: the export runs against three dataset sizes at once, the test suite and the type checker run concurrently, the branch is pushed and CI is watched while a rollback plan is drafted on another channel.
The planning channel shows the running state of every active tool call, so you do not have to ask for status.
None of this is invoked through a special tool or a special flag. The agent is running many channels, each watching a different stream.[^interrupt-self]

[^backgrounding]: Claude Code has partial workarounds.
    You can set `run_in_background` on a Bash call so the agent does not block, and use the Monitor tool to stream output lines back as notifications.
    But these are scaffolding around a single-stream model.
    The agent has to consciously invoke them, and even with them, the rest of the agent's work is still serial.

[^subagent]: Strictly, the harness could spawn subagents to do other work in parallel.
    But subagents are wrapped in tool calls, and the parent has to wait for the subagent to return.
    There is no streaming back to the parent while the subagent works.

[^interrupt-self]: This is one of the harder behaviors to train.
    The model needs to be able to interrupt one of its own streams when another stream surfaces something more important.
    This is a form of self-interruption, and it is different from being interrupted by the user.

#### **Compacting**

*What it is.*
After researching the dashboard code, the CSV utility, the permissions model, and running several export runs against large datasets, the conversation gets long.
The harness compacts the context.
In Claude Code, this means summarizing the older parts of the conversation into a shorter form.[^compact-docs]
You can also run `/compact` manually with an optional focus like `/compact focus on the permissions changes`.
Compaction is slow.
The model has to autoregressively decode thousands of tokens of summary before the new context is ready, and a single-stream model cannot do anything else in the meantime.
Detailed instructions from early in the conversation may be lost - you are advised to put persistent rules in CLAUDE.md so that they survive compaction.

*What it should be.*
The interaction model continuously decides what to forget.
There is no separate, batched compaction step.
The dashboard component that was read fifty turns ago can be dropped because the running button code embodies what was learned from it, the column decision still lives on the planning channel, and the permissions quirk is captured on the memory channel.
The model does not stop to compact.
It is already maintaining the state it needs.

[^compact-docs]: From the Claude Code [docs](https://code.claude.com/docs/en/how-claude-code-works) on how the context window is managed.
    Auto-compaction also re-attaches recently invoked skills after the summary, keeping the first 5,000 tokens of each within a 25,000 token budget.
    Auto-compaction halts with an error if a single tool output is so large that context refills immediately after each summary.


#### **Improving**

*What it is.*
After the export ships, you reflect on what could be improved.
You decide what to add to CLAUDE.md about the CSV utility, what skills to write for adding future exports, what conventions to formalize.
Claude Code has [auto memory](https://code.claude.com/docs/en/memory#auto-memory) which saves some learnings into MEMORY.md as you work, but the broader reflection is usually a separate prompt at the end of the session - "what did we learn?" - or it is left to the user.
Either way, reflection is a discrete step after the work, not something that happens during.

*What it should be.*
Reflection happens continuously on a memory channel that the agent maintains throughout the session.
When the agent discovers that the CSV utility ignores the dashboard's permissions model, the memory channel captures it immediately - not in a post-session "what did we learn?" pass.
At the end of the session, the memory channel writes to persistent storage (MEMORY.md, skills files, CLAUDE.md) - notes about the CSV utility's quirks, a skill for adding future exports - without a separate "review and update" prompt.
You can read the memory channel at any time during the session, just like the planning channel.
Cross-session memory is then a matter of subscribing future sessions to this storage - it is not a feature of the model, it is a feature of which channels the harness wires up.



## Implications

### Your side of the interaction does not change much

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

### Humans will prefer the better interface

I still prefer Claude Code as my main interface for all my projects.

I have switched between Claude Code and Codex multiple times.[^codex-permissions] Every switch was driven by interaction quality, not by which model was a few percentage points higher on a benchmark.
The Wispr Flow dictation app is more popular than other speech-to-text tools because the experience is better, even though the underlying transcription quality is comparable.

This means interaction models have a strong commercial pull.
A model that is harder to interrupt, harder to steer, harder to ask questions of, and harder to watch will lose users to a model that is none of those things - even if the second model is slightly less capable on autonomous benchmarks.
The companies that ship interaction models first will set the floor for what users expect.
Going back to a single-stream model will feel like going from a chat app to email.

[^codex-permissions]: My current frustration with Codex is that its permissions model is binary.
    I cannot change the permissions settings the way I can with Claude Code - Codex is either do-nothing (pause on every action for approval) or do-everything (full-auto on anything).
    There is no middle ground where I can trust some patterns and not others.
    Claude Code lets me allow-list specific bash patterns, file paths, and tool patterns - a much richer surface for declaring what is safe.

### Coding models are already on this trajectory

The same trajectory we saw for reasoning is the one I expect for interaction.

In 2024, reasoning was an opt-in feature.
OpenAI released [o1](https://openai.com/o1/) in September 2024 as a separate product.
You could pick between o1 and GPT-4o.
You could pick whether to use extended thinking with Claude Sonnet 3.5.

The distinction has collapsed.
Every frontier coding model today is a reasoning model.
Nobody ships a competitive non-reasoning model for coding.[^non-reasoning]

[^non-reasoning]: Some models still expose a non-thinking mode for smaller models and latency-sensitive use cases.
    However, on coding leaderboards the entries that matter are all reasoning models.

Reasoning models also happen to be the first widely-shipped models with something close to multi-stream behavior.
The thought process is one stream.
The user-facing response is another stream.
The streams are sequential, not parallel, but they are distinct streams with distinct purposes.

The pattern is - a capability starts as an opt-in feature, becomes the default, then becomes inseparable from the model.
I expect interaction to follow the same pattern.
There will be no flag to switch between "interaction mode" and "non-interaction mode".
Every coding model will be an interaction model.



### You will throw away your harnesses

Claude Code and Codex paper over the model's inability to do more than one thing at a time.

These parts of the harness exist only because the model is single-stream.
They will go away.

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
  Interaction or not, the model needs to learn about the system it is working on - where to find information, who to ask for what, the company's conventions, the pitfalls to avoid.
  Skills are how the model discovers this.
  The interaction capability does not remove the need for skills.

The harness becomes very thin.
It is a router that wires streams from the real world into the model, and routes the model's outputs back into the world.



### There will be one coding model size

My bet is that the coding model market will collapse to one model size served via API.

There will not be a larger, slower, smarter model for harder problems.
There will only be a single model, with a knob for how long it thinks before acting.

The reasons.

- For an interaction model to be responsive across many channels, latency matters.
  A larger model trades responsiveness for capability, which is the wrong trade for an interaction model.
- The thinking-effort knob already exists.
  Claude Code has `low`/`medium`/`high`/`xhigh`/`max`.
  OpenAI has `reasoning_effort`.
  Anthropic has `thinking_budget`.
  Most of the marginal capability gain from a larger model is captured by spending more tokens on thinking.
- Serving one model size is operationally much simpler.
  You can pool compute, cache better, scale predictably, and avoid the fragmentation of "which model should I use for which task".

Today's model tiering is a reasonable workaround for single-stream models, but it is a workaround.

Claude Code uses Haiku for the [Explore](https://code.claude.com/docs/en/sub-agents) subagent.
There are good reasons for this given today's constraints.
Reading many files to find a definition burns tokens fast, so a smaller model keeps cost down.
Exploration is latency-sensitive, so a faster model helps.
The Explore subagent has an isolated context, so the main agent does not have to absorb the file contents - just the summary.
And critically, the main model can only do one thing at a time, so spawning a subagent is the only way to explore in parallel with the main work.
A smaller model in that subagent is the right cost/speed call.

But the whole pattern is scaffolding around the single-stream constraint.
Asking a subagent to do something is like asking a coworker - they do not fully understand what you mean, and normally you would go back and forth until they do.
With subagents you cannot.
The instruction is frozen at spawn time, and the subagent returns whatever it decided to summarize.
The interaction model is closer to cloning yourself to do many things at once.
The clones share the full context of what you know and what you are trying to do, without the information loss of writing instructions to a separate agent and waiting for it to write back.
Exploration becomes a channel on the main model, not a subagent on a smaller model.
There is no second set of weights to load, no second inference path, no instruction-writing step, and no information lost between the explorer and the main agent.
The smaller-model-as-subagent pattern is solving a problem that interaction models do not have.

If this prediction holds, the user-facing question of "which model" disappears, replaced by "how long should this think".
The harness no longer needs a `/model` command, only an effort dial.



### Training interaction models will be hard

Reasoning models showed up as a step beyond instruct models.
Interaction models will be a step beyond reasoning models, and the training challenges are non-trivial.

**Context length needs to be actively managed.**
Multiple parallel channels produce more tokens per second of wall-clock time than a single stream.
A 30-minute coding session that fit comfortably in 200k tokens as a single stream might not fit if four channels are all writing in parallel.
The model needs to manage its own context as it works - deciding which channel state to keep, which to summarize, which to drop entirely - without the harness invoking a separate compaction step.
This is a hard training objective.
The reward for "good context management" is not obvious, and the failure mode (dropping something important) only surfaces minutes later when the model tries to use what it no longer remembers.

**Self-interruption is a learned behavior.**
The model needs to interrupt one of its own streams when another stream surfaces something more important.
This is different from being interrupted by the user, and it is different from finishing a thought before moving on.
Today's models cannot do this cleanly.
They either commit to the current thought or abandon it and start over.

**Evaluation gets harder.**
The reference completion is no longer one self-contained turn.
It is a slice of a running interaction, and grading it requires simulating the rest of the interaction.
I wrote about this in the [evaluation section](/2025/05/14/multichannel-prediction.html#evaluation) of the multichannel post.



### Do not bother scaffolding current models into interaction models

Some of the behaviors I describe above can be approximated by scaffolding around today's single-stream models.
You can train the model to emit a planning section that the harness parses out.
You can spawn lots of subagents.
You can stream tool output into the model's context as it arrives, with elaborate prompting on how to interrupt itself.

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



### Think about what optimal interaction looks like

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

[^robotics]: Coding is the first killer use case.
    It is not the only one.
    A general robotics model should also be an interaction model - the robot needs to be reading its sensors, planning its next motion, executing the current motion, and listening to the human all at the same time.
    The substrate is harder (continuous motor control, real-time constraints) so I do not expect robotics to be first.
    But the same multichannel argument applies.



## Footnotes
