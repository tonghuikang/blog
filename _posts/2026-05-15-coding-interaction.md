---
layout: post
title: All coding models will be interaction models
---

Thinking Machines released [Interaction Models](https://thinkingmachines.ai/blog/interaction-models/) earlier this week. (I called them multichannel models [one year ago](/2025/05/14/multichannel-prediction.html))

I argue that all frontier coding harnesses will soon be using only interaction models.


## Think of how you interact with AI coding tools

You ask the coding agent to debug why the checkout success rate dropped 3% after yesterday's deploy.
For each phase of the session, I describe what it is today, and what it should be.


#### **Researching**

*What it is.*
The agent takes a turn.
First it thinks. Then it reads a file. Then it thinks again.
Understanding the system happens one read at a time.
The plan lives inside that thought process, and you only catch fragments of it.
If you want a structured plan you can read, you invoke plan mode - and the agent does nothing else until the plan is done.

*What it should be.*
The agent reads many parts of the system at the same time - the failing endpoint, the deploy diff, the error logs, the related services - each on its own research channel.
A planning channel holds the running list of what is known, what is being tried, what is pending, drawn from all the parallel research.
Planning starts as soon as the main shape of the problem is clear, and research keeps filling in the details. If the agent finds that yesterday's deploy added a new retry rule that turns transient errors into hard failures, it can start drafting the fix on the planning channel while other research channels enumerate every endpoint that hits the retry path and check which of those would also need updating.
The plan is not buried inside a thought process - it is a separate channel you can read at any time. You do not invoke plan mode. The plan is always being written, as one of many channels the agent is running.[^channels]

[^channels]: The other channels include a user-facing channel (what you read in the interface), a code-writing channel (which is producing edits), and a terminal channel (which is sending commands). On the input side, the agent subscribes to your messages, the terminal output streaming live, file system events from the harness, and the CI service.

#### **Aligning**

*What it is.*
When the task is ambiguous, the agent either dives in without asking, or asks one clarifying question and stops working until you reply.
There is no middle ground between guessing and blocking.

*What it should be.*
The agent asks clarifying questions on the user-facing channel and keeps researching on other channels at the same time.
By the time you reply, the agent already has the relevant code in context, and your answer steers the research that is already in flight.

#### **Steering**

*What it is.*
The agent is already working - it has started writing code, running commands, producing a prototype.
Halfway through, you notice it is taking the wrong approach, or you remember a detail you forgot to mention.
You type it into the chat box.
Your message is queued. It will be delivered at the next tool boundary.
By then the agent may have already wasted compute pursuing the wrong hypothesis.
The agent has only one output stream, so what it is thinking and what it is showing you are the same stream. You see file operations and tool calls but no acknowledgment that you exist, and the agent feels like it is stonewalling you.
There is no equivalent of nodding or saying "uh-huh, I heard that, let me finish this thought first".
You cannot interrupt the agent's chain of thought either.[^interrupt-cot] If you do, the agent abandons its current trace and restarts from your new message.

[^interrupt-cot]: When I tried interrupting `gpt-oss-120b` while it was working on math problems, the resulting trace became token inefficient - the interrupted thought was abandoned and the model started a fresh thought from the new user message. An interaction model should be able to absorb a mid-flight interruption and update its current stream without restarting.

*What it should be.*
You send a course correction mid-flight - the agent is on the wrong endpoint, or you remember an edge case the bug only happens under.
The agent reads your message immediately without finishing its current thought.
The planning channel updates to include the new constraint.
The agent thinks and communicates at the same time, on separate channels. Chain of thought is for the model's own reasoning, not for human consumption - it can be exposed, but it is verbose and meandering by design and is not the most efficient way to communicate with you. The user-facing channel speaks differently: concise, direct, addressed to you. It acknowledges that the agent heard you, while the thinking and code-writing channels keep running in parallel.
You do not have to wait for a turn boundary, and you do not feel stonewalled.


#### **Approvals**

*What it is.*
The agent wants to do something that needs your approval.
It might be a `git push --force` on a shared branch.
The agent halts and surfaces the approval prompt. You approve, deny, or "allow always for this pattern".
Everything else the agent was doing stops too. The agent is single-stream, so a pending approval blocks all the work.

*What it should be.*
Approvals surface on a dedicated approval channel.
Only the channel that needs the approval pauses. The other channels keep running.
The agent continues planning, researching, or drafting on the other channels while you decide.
If you approve, the paused channel resumes. If you deny, the agent updates the planning channel and considers an alternative.

The distinction from Planning's clarifying questions matters - approvals are about authorization, not scope.
The harness still owns the authorization boundary even when the model is multi-stream. What changes is that asking for authorization no longer freezes the work.


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

#### **Compaction**

*What it is.*
The conversation gets long.
The harness compacts the context.

In Claude Code, this means clearing older tool outputs first, then summarizing the conversation if needed.[^compact-docs] You can also run `/compact` manually with an optional focus like `/compact focus on the API changes`. To control what is preserved, you add a "Compact Instructions" section to CLAUDE.md. The summarization itself is a separate, batched, blocking step. The agent stops the rest of its work to summarize.
Detailed instructions from early in the conversation may be lost. You are advised to put persistent rules in CLAUDE.md so that they survive compaction.

[^compact-docs]: From the Claude Code [docs](https://code.claude.com/docs/en/how-claude-code-works) on how the context window is managed. Auto-compaction also re-attaches recently invoked skills after the summary, keeping the first 5,000 tokens of each within a 25,000 token budget. Auto-compaction halts with an error if a single tool output is so large that context refills immediately after each summary.

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


*What it should be.*
Compaction is not a separate, batched step.
The active channels carry the relevant state forward.
Older parts of the conversation can be dropped because nothing important is only there - it is also in the planning channel, the running code state, or the user-facing channel.
There is no need for a "Compact Instructions" section because there is no monolithic summarization step that needs to be instructed.
The agent does not stop to compact. It is already maintaining the state it needs.


#### **Reflection**

*What it is.*
After the work is done, you reflect on what could be improved.
You decide what to add to CLAUDE.md, what skills to write, what conventions to formalize.
Claude Code has [auto memory](https://code.claude.com/docs/en/memory#auto-memory) which saves some learnings into MEMORY.md as you work, but the broader reflection is usually a separate prompt at the end of the session - "what did we learn?" - or it is left to the user.
Either way, reflection is a discrete step after the work, not something that happens during.

*What it should be.*
Reflection happens continuously on a memory channel that the agent maintains throughout the session.
The memory channel captures pitfalls discovered, conventions inferred, processes that worked, prompts that did not.
At the end of the session, the memory channel writes to persistent storage (MEMORY.md, skills files, CLAUDE.md) without a separate "review and update" prompt.
You can read the memory channel at any time during the session, just like the planning channel.
Cross-session memory is then a matter of subscribing future sessions to this storage - it is not a feature of the model, it is a feature of which channels the harness wires up.



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



### There will be one coding model size

My bet is that the coding model market will collapse to one model size served via API.

There will not be a larger, slower, smarter model for harder problems.
There will only be a single model, with a knob for how long it thinks before acting.

The reasons.

- For an interaction model to be responsive across many channels, latency matters. A larger model trades responsiveness for capability, which is the wrong trade for an interaction model.
- The thinking-effort knob already exists. Claude Code has `low`/`medium`/`high`/`xhigh`/`max`. OpenAI has `reasoning_effort`. Anthropic has `thinking_budget`. Most of the marginal capability gain from a larger model is captured by spending more tokens on thinking.
- Serving one model size is operationally much simpler. You can pool compute, cache better, scale predictably, and avoid the fragmentation of "which model should I use for which task".

Today's model tiering is a reasonable workaround for single-stream models, but it is a workaround.

Claude Code uses Haiku for the [Explore](https://code.claude.com/docs/en/sub-agents) subagent. There are good reasons for this given today's constraints.
Reading many files to find a definition burns tokens fast, so a smaller model keeps cost down. Exploration is latency-sensitive, so a faster model helps. The Explore subagent has an isolated context, so the main agent does not have to absorb the file contents - just the summary. And critically, the main model can only do one thing at a time, so spawning a subagent is the only way to explore in parallel with the main work. A smaller model in that subagent is the right cost/speed call.

But the whole pattern is scaffolding around the single-stream constraint.
Asking a subagent to do something is like asking a coworker - they do not fully understand what you mean, and normally you would go back and forth until they do. With subagents you cannot. The instruction is frozen at spawn time, and the subagent returns whatever it decided to summarize.
The interaction model is closer to cloning yourself to do many things at once. The clones share the full context of what you know and what you are trying to do, without the information loss of writing instructions to a separate agent and waiting for it to write back.
Exploration becomes a channel on the main model, not a subagent on a smaller model.
There is no second set of weights to load, no second inference path, no instruction-writing step, and no information lost between the explorer and the main agent.
The smaller-model-as-subagent pattern is solving a problem that interaction models do not have.

If this prediction holds, the user-facing question of "which model" disappears, replaced by "how long should this think". The harness no longer needs a `/model` command, only an effort dial.



### Training interaction models will be hard

Reasoning models showed up as a step beyond instruct models. Interaction models will be a step beyond reasoning models, and the training challenges are non-trivial.

**Context length needs to be actively managed.**
Multiple parallel channels produce more tokens per second of wall-clock time than a single stream.
A 30-minute coding session that fit comfortably in 200k tokens as a single stream might not fit if four channels are all writing in parallel.
The model needs to manage its own context as it works - deciding which channel state to keep, which to summarize, which to drop entirely - without the harness invoking a separate compaction step.
This is a hard training objective. The reward for "good context management" is not obvious, and the failure mode (dropping something important) only surfaces minutes later when the model tries to use what it no longer remembers.

**Self-interruption is a learned behavior.**
The model needs to interrupt one of its own streams when another stream surfaces something more important.
This is different from being interrupted by the user, and it is different from finishing a thought before moving on.
Today's models cannot do this cleanly. They either commit to the current thought or abandon it and start over.

**Evaluation gets harder.**
The reference completion is no longer one self-contained turn.
It is a slice of a running interaction, and grading it requires simulating the rest of the interaction.
I wrote about this in the [evaluation section](/2025/05/14/multichannel-prediction.html#evaluation) of the multichannel post.



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
