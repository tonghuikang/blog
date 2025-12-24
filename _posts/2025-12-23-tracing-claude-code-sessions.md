---
layout: post
title: Tracing Claude Code sessions
---
I have built yet another visualizer for Claude Code sessions.

https://sessions.huikang.dev/

This is a feature walkthrough
- (please fill up)
- Claude Code may invoke subagents. You can see the interactions with the subagent. (citation)

This was built[^mcp][^updates] with Claude Code itself.

[^mcp]: I was using [`@modelcontextprotocol/server-puppeteer`](https://www.npmjs.com/package/@modelcontextprotocol/server-puppeteer) to [manipulate](https://github.com/modelcontextprotocol/servers-archived/tree/main/src/puppeteer) the browser. According to the npm site, the package is no longer supported. As I write this, I [found](https://www.reddit.com/r/ClaudeAI/comments/1li46d8/puppeteer_mcp_server_is_archived_any_alternatives/) out that that I can use [`@playwright/mcp`](https://www.npmjs.com/package/@playwright/mcp) instead.

[^updates]: It is unlikely that I will include more sessions. The main objective of making this prototype is to write this blogpost, which has been achieved. I will only add sessions if I have something I want to explicitly share - for example the methods on prompting Claude Code or to reproduce a certain bug with Claude Code. It is also likely that I will move on to different prototype. It might be possible that Claude Code builds this and this prototype is no longer needed.




Reasons that I am building this

- Persist and visualize my own Claude Code sessions in one place
- Share how I prompt the agent, and my views what prompts should no longer be necessary
- Deliver some views on evaluation and training could be done



## How I prompt Claude Code

**I get Claude Code to start working as early as possible**
- In this example, I ask Claude Code to whitelist traces belonging to projects that I want to publish. To do this, Claude Code will need to edit gitignore. Claude Code will also need to write and run cleanup script to remove the files that are not gitignored so that what I see locally is what I see when I publish the project.
- My first [instruction](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-sessions&session=c2edc133-2bfc-4ebd-b066-0256bcd25d87&msg=d5d0642c-9c00-41c3-a5ca-6a29c66e66cc) is just to edit gitignore to allow a certain project to be tracked. I let Claude Code understand the codebase and carry on with the task. Then I inject another [instruction](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-sessions&session=c2edc133-2bfc-4ebd-b066-0256bcd25d87&msg=1e66f03a-a8fc-48db-bf45-fc9c6beb79f9) to write the cleanup script.
- There are some benefits to breaking down the instructions. You want your agent to start working on the problem as soon as possible. The shorter your first instruction, the earlier the agent can start working. The second instruction that you write can depend on how the agent is performing.
- For this, both the interface and the model should be both steerable and immediately helpful. Claude Code allows this, I can send messages to Claude Code while Claude Code is working on the problem. The messages will be queued and delivered when Claude Code finishes a tool use[^steerable].

[^steerable]: Even so, there are times where Claude Code could ignore your submitted messages. The harness should have provided a to-do list where it asks the model on whether all the instructions of the user has been addressed.


**I make design choices that make it easy to communicate with Claude Code.**
- If I find myself taking a lot of effort to tell Claude Code what I want, I should think of ways to make this simpler.
- When the first prototype is done, I find it very difficult to describe issues to Claude Code. I had to give instructions to Claude Code that it to navigate to the second session and the message with a certain substring. Alternatively, I take screenshots and [upload](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=6eecbb54-1feb-4fc2-8acd-826551b53bef) the screenshot to the Claude Code, and Claude Code will need to reverse engineer the screenshot to figure out which message am I talking about.
- I should not tolerate such bottlenecks in communication. Therefore, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=dc745936-f392-49ac-b80d-c091e171bed0) that "navigating the page should change the query params".
- Now I no longer need to take screenshots, I just pass in the URLs. Claude Code could also use the same URLs to show that it has completed its work. The early investment to improve communication is worth it.


**I ask Claude Code to show me a working example**
- Instead of me checking Claude Code work, I ask Claude Code to show the proof that it is working.
- In this example, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=860b45a6-fc81-4387-a675-085104ac280d&msg=f34b05fb-5b5d-4d1b-be95-57664d357d7b) Claude Code to display the agent trace within the session itself. The result should look something like `http://localhost:44043/?project=claude-code-tracing&session=10d53ddc-6406-4bed-a32b-da56257311f1&msg=deefa37a-9f1b-4466-abcf-44786f2b8183` where I can visit and inspect the outcome.
- The benefit of doing this is that you can get Claude Code to check its own work. If Claude Code could not find a proof of what you asked is working, Claude Code is expected to figure out what went wrong. This saves my time checking Claude Code's work and asking Claude Code to fix the issues.


**I get Claude Code to describe the issue to me instead**
- Instead of describing the issue to Claude Code, I show Claude Code the place where I find there is an issue, and I ask Claude Code to describe the issue to me.
- In this example, Claude Code rendered the agent messages inside a tool message in the main thread. However, the rendering is horrible, the text in the agent messages is hardly visible.
- Instead of describing the issue to Claude Code, I [asked](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=bde6418c-ae88-4e72-a8c4-4323aa337806&msg=59a90e9d-58a7-4c7c-ae0c-6bf3b9563280) Claude Code on "tell me what you see in (url)". Claude Code opens up Puppeteer, goes the the URL, and describes the issue to me[^boxing]. I then ask to fix one of the issues that it has surfaced. 
- There are benefits to doing this. I no longer need to take time to describe the issue since it could be faster for Claude Code to look into the problem tell me what the issue is. If the issue that Claude Code accurately surfaces aligns with the issue you want to fix, you can be more confident that Claude Code understands your assignment. There might be other issues that you are not aware of, and this interaction provides an opportunity for you to ask to fix the other issues as well.


[^boxing]: In this case, Claude Code [tells](https://tonghuikang.github.io/claude-code-sessions/?project=claude-code-tracing&session=bde6418c-ae88-4e72-a8c4-4323aa337806&msg=8b501b2c-bd07-40f6-b6da-2789f38bd2b1) me a bunch of issues but misses the most obvious issues that the box highlighting is overpowering the text and making the text unreadable. This is not ideal, but has provided me a useful signal that Claude Code does not yet understand the assignment.


## How evaluation and training could be done


You should notice that my Claude Code sessions are very messy. I can ask for one task, but I could switch to another task.

Evaluation

- I want all my interactions with AI to be recorded, so I can annotate and share to promote knowledge on how to interact with AI
- Ideally this is something that Claude Code should have build


What I expect frontier companies to be collecting

- Every follow-up message either contains new information, or AI is doing.
- I would expect finetuning to happen on the action level. You cannot reproduce the environment, because you do not have access to that.
- There should be a evaluator. Similar to chess, you make a move, the Stockfish evaluator bar goes up or down. 



## What could AI coding tools provide

Ideally I want visualize all my Claude Code sessions on the web and share them. (What other AI coding tool have this feature?)


This only shows the process of building the visualizer itself. I have some projects that I have no yet published. I hope to add more, but it will be slow.


Currently the default for AI coding tools. Claude Code gets you to opt in although the default .
Other AI coding tools do not show you an opt-in screen. It is only the enterprise offering.


Ideally AI coding tool provider should identify what should be learnt, at the AI coding tool's cost. You just need the information on whether the scenario could fail, you do not need the whole trajectory data (you can see that I am taking a risk myself by sharing my session data). I understand AI coding tools. Interactions with AI is actually more valuable than published information out there, interactions with your AI is even more valuable. I understand that to gain an edge over the competitors you will need to.


## Footnotes

