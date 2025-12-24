---
layout: post
title: Tracing Claude Code sessions
---
I have built yet another visualizer for Claude Code sessions - [sessions.huikang.dev](https://sessions.huikang.dev/)

![claude-code-sessions](/assets/claude-code-sessions.png)

This is a feature walkthrough
- [Browse projects and sessions](https://sessions.huikang.dev/) in a sidebar, view conversation transcripts with color-coded messages ([user](https://sessions.huikang.dev/?project=claude-code-sessions&session=fd293da7-7072-4a0c-a1fc-716fbe921e85&msg=08b14646-3e30-4ca5-a2cd-a6bd6d2c2286), [assistant](https://sessions.huikang.dev/?project=claude-code-sessions&session=fd293da7-7072-4a0c-a1fc-716fbe921e85&msg=975613e8-4a42-4457-84be-587470360695), [tool](https://sessions.huikang.dev/?project=claude-code-sessions&session=fd293da7-7072-4a0c-a1fc-716fbe921e85&msg=334a8ce7-c277-444e-a2c2-5305412dc649))
- Claude Code may invoke [subagents](https://sessions.huikang.dev/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=deefa37a-9f1b-4466-abcf-44786f2b8183) via the Task tool. You can see the subagent interactions displayed inline within the parent session


This was built[^mcp][^updates] with Claude Code itself.


[^mcp]: I was using [`@modelcontextprotocol/server-puppeteer`](https://www.npmjs.com/package/@modelcontextprotocol/server-puppeteer) to [manipulate](https://github.com/modelcontextprotocol/servers-archived/tree/main/src/puppeteer) the browser. According to the npm site, the package is no longer supported. As I write this, I [found](https://www.reddit.com/r/ClaudeAI/comments/1li46d8/puppeteer_mcp_server_is_archived_any_alternatives/) out that I can use [`@playwright/mcp`](https://www.npmjs.com/package/@playwright/mcp) instead.

[^updates]: It is unlikely that I will include more sessions. The main objective of making this prototype is to write this blogpost, which has been achieved. I will only add sessions if I have something I want to explicitly share - for example the methods on prompting Claude Code or to reproduce a certain bug with Claude Code. It is also likely that I will move on to a different prototype. It might be possible that Claude Code builds this and this prototype is no longer needed.



Reasons that I am building this

- Persist and visualize my own Claude Code sessions in one place
- Share how I prompt Claude Code (and my views on prompting)
- Deliver some views on how evaluation and training could be done



## How I prompt Claude Code

I want to take the opportunity to share how I prompt Claude Code. As Claude Code improves, some of these prompting methods will perform better, and some of these prompts will no longer be necessary.

#### **I get Claude Code to start working as early as possible**

In this example, I ask Claude Code to whitelist traces belonging to projects that I want to publish. To do this, Claude Code will need to edit gitignore. Claude Code will also need to write and run a cleanup script to remove the files that are not gitignored so that what I see locally is what I see when I publish the project.

Instead of writing my instructions all at once, I break down my instructions and submit them separately.

My first [instruction](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-sessions&session=c2edc133-2bfc-4ebd-b066-0256bcd25d87&msg=d5d0642c-9c00-41c3-a5ca-6a29c66e66cc) is just to edit gitignore to allow a certain project to be tracked. I let Claude Code understand the codebase and carry on with the task. Then I inject another [instruction](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-sessions&session=c2edc133-2bfc-4ebd-b066-0256bcd25d87&msg=1e66f03a-a8fc-48db-bf45-fc9c6beb79f9) to write the cleanup script.

There are some benefits to breaking down the instructions. You want your agent to start working on the problem as soon as possible. The shorter your first instruction, the earlier the agent can start working. The second instruction that you write can depend on how the agent is performing.

For this, both the interface and the model should be both steerable and immediately helpful. Claude Code allows this, I can send messages to Claude Code while Claude Code is working on the problem. The messages will be queued and delivered when Claude Code finishes a tool use[^steerable]. However, I still often see Claude Code dropping my instructions.

[^steerable]: Even so, there are times where Claude Code could ignore your submitted messages. The harness should have provided a to-do list where it asks the model on whether all the instructions of the user have been addressed.

#### **I make design choices that make it easy to communicate with Claude Code.**

If I find myself taking a lot of effort to tell Claude Code what I want, I should think of ways to make this simpler.

When the first prototype is done, I find it very difficult to describe issues to Claude Code. I had to give instructions to Claude Code to navigate to the second session and the message with a certain substring. Alternatively, I take screenshots and [upload](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=6eecbb54-1feb-4fc2-8acd-826551b53bef) the screenshot to Claude Code, and Claude Code will need to reverse engineer the screenshot to figure out which message I am talking about.

I should not tolerate such bottlenecks in communication. Therefore, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=dc745936-f392-49ac-b80d-c091e171bed0) that "navigating the page should change the query params".

Now I no longer need to take screenshots, I just pass in the URLs. Claude Code could also use the same URLs to show that it has completed its work. The early investment to improve communication is worth it.

Ideally, when appropriate, Claude Code should take the initiative to make communication easier. I have plenty of [experience](https://compare.huikang.dev/) [generating](https://traces.huikang.dev/) [html](https://aimo.huikang.dev/tokens) [files](https://aimo.huikang.dev/leaderboard) so I know what are the good practices, but people who are new do not.



#### **I ask Claude Code to show me a working example**

Instead of me checking Claude Code's work, I ask Claude Code to show the proof that it is working.

In this example, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=860b45a6-fc81-4387-a675-085104ac280d&msg=f34b05fb-5b5d-4d1b-be95-57664d357d7b) Claude Code to display the agent trace within the session itself. The result should look something like `http://localhost:44043/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=deefa37a-9f1b-4466-abcf-44786f2b8183` where I can visit and inspect the outcome.

The benefit of doing this is that you can get Claude Code to check its own work. If Claude Code could not find a proof of what you asked is working, Claude Code is expected to figure out what went wrong. This saves my time checking Claude Code's work and asking Claude Code to fix the issues.

Claude Code should take the initiative to produce the working example without me asking.



#### **I get Claude Code to describe the issue to me instead**

Instead of describing the issue to Claude Code, I show Claude Code the place where I find there is an issue, and I ask Claude Code to describe the issue to me.

In this example, Claude Code rendered the agent messages inside a tool message in the main thread. However, the rendering is horrible, the text in the agent messages is hardly visible.

Instead of describing the issue to Claude Code, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=bde6418c-ae88-4e72-a8c4-4323aa337806&msg=59a90e9d-58a7-4c7c-ae0c-6bf3b9563280) Claude Code on "tell me what you see in (url)". Claude Code opens up Puppeteer, goes to the URL, and describes the issue to me[^boxing]. I then ask to fix one of the issues that it has surfaced. 

There are benefits to doing this. I no longer need to take time to describe the issue since it could be faster for Claude Code to look into the problem and tell me what the issue is. If the issue that Claude Code accurately surfaces aligns with the issue you want to fix, you can be more confident that Claude Code understands your assignment. There might be other issues that you are not aware of, and this interaction provides an opportunity for you to ask to fix the other issues as well.

For this to work, Claude Code needs to have good product taste.


[^boxing]: In this case, Claude Code [tells](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=bde6418c-ae88-4e72-a8c4-4323aa337806&msg=8b501b2c-bd07-40f6-b6da-2789f38bd2b1) me a bunch of issues but misses the most obvious issues that the box highlighting is overpowering the text and making the text unreadable. This is not ideal, but has provided me a useful signal that Claude Code does not yet understand the assignment.



## How evaluation and training could be done

Usually coding performance is represented as variants of SWE-bench. I describe how SWE-bench is different from real world coding scenarios.

These are some things you should observe with my coding sessions

- My instructions are messy. I can ask for one thing, but ask for something completely different right after. Claude Code needs to be able to track all my instructions and address them all.
- My instructions need to be interpreted. The words from me need to be corroborated with the context found in the code.
- The description of the environment is incomplete. The model may not be served all the information. It is up to the agent to discover, and also decide to spend tokens in discovering.
- The reward needs to be inferred. When the sessions ends, it might be that the task is complete. It might be that I have given up and copied the entire conversation to Codex.

Sandbox benchmarks like SWE-bench are different from real world coding scenarios

- Instructions are precise. There is usually only one task that is to be solved. There are instructions on how to reproduce the issue.
- Instructions are clear. There is only one way to interpret the instruction.
- The environment is reproducible.
- The reward is clear. Benchmarks have processes to calculate the performance of the model. If the model is tasked to fix an issue, there are held-out test cases that the model needs to pass. If the model passes the test cases, the model succeeded, otherwise not.

Evaluating the model in a sandboxed benchmark is straightforward, you just run a script. Of course, there is a lot of work in curating the tasks for SWE-bench, and good taste is needed for good tasks.

Evaluating the model against coding sessions is more involved. There is no ground truth here. There is no script to run to confirm whether the task is correctly done. You cannot reproduce the user's environment because you do not have access to the environment.

You will need to create your own standards on what is good and what is bad. The remainder of the coding sessions could provide clues, but you still need to have your own judgment.

This is how I expect one entry of evaluation is done for one model.

- You have one reference prompt-completion pair from the session. The reference completion is one turn taken by the model. The reference prompt is all the tokens before the reference completion.
- You get the model to generate the new completion from the reference prompt.
- You grade whether the new completion is better than the reference completion. You have a process that calculates this (will be elaborated)
- The new completion can be graded to be better, equal or worse than the reference completion.

This is how you can grade whether a completion is better than the reference completion
- You look at the remainder of the session of the reference session for the mistakes that the reference completion is causing.
- You check whether the new completion is making the same mistakes.
- You also look at the remainder of the session of the reference session for the progress that the reference completion is making.
- You check whether the new completion is also advancing the task at a similar amount with the similar token budget.
- You produce an overall judgment.

Notice what I described here involves comparing a new completion with a reference completion. The reference completion has access to the remainder of the sessions, whereas this is not the case for the new completion. You access the remainder from the new completion because you cannot fully reproduce the environment that created the reference session. If you want to compare two new completions, you need to design the process slightly differently. One simple way to do this is to compare two new completions against the reference completion and decide among the two new completion which one is better, or is it a tie.

Once you can evaluate, you can train. You train the model to produce more of the better completion on the reference prompts.


## Footnotes

