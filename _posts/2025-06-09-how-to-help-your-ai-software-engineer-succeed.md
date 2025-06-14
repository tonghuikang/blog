---
layout: post
title: How to help your AI software engineer succeed
---
AI will soon act as your peer software engineer. Similar to how you help your human software engineer peers succeed, this is how you can help your AI software engineer succeed.



## Share all the context available

Your product manager asks you to build a button on your website.

This is how the process of implementing a button goes:

- Leadership wants to focus on a certain aspect (improve product experience)
- Research was done, feedback was solicited on what is the biggest pain points in product experience
- The product manager decides to implement a button that does something (pinning comment)
- The product designer creates mock-ups on how the button should look like, and thinks through edge cases
- You (the software engineer) execute

If you ask AI to implement a button, you need to translate everything. You should not need to do this.

However, all the information is not in one place. This is where all the information lives:

- The meeting notes with leadership happens on **Notion / Google docs / Quip**
- The feedback from users were solicited through **email**
- The product manager documents projects on **Asana**
- The product designer implements the mocks on **Figma**
- You are informed through **Slack** that the button is ready for implementation
- Your code lives on **Github**, which contains information on similar implementations, and what the company has tried in the past.

You want to connect AI to all of these data sources. AI should be given access to all the internally public information so that it can gather all the context it needs to do well at the job.

AI is already good enough to search through your content. Similar to how a human would, they can reason and think of the search terms they could use to figure out what to search. They could use the search results to refine their search terms. I have seen how AI is able to trace my company's huge monorepo [^3] for information. The AI will perform even better if we can share all the context available. We should invest in tools that AI can use to access all the context they need.

![](/assets/search-example.png)

[^3]: One thing they could do better at is to search the git history for context. I hope this task is represented in some benchmarks.


## Make it easy for them to execute

This is how you implement a button, as a software engineer

- You change the code.
- You deploy an internal version of the product. [^2]
- You test whether the button works.
- You run the formatter, lint, and unittests.
- Repeat if there is an issue.

This is manual. This is slow. You want to automate this process.

If you want to automate this process, you should provide AI access to the ability to execute these:
- Drafting code edits
- Deploy an internal version of the product
- Manipulate the browser to test whether the button works
- Run code development tools (formatter, lint, and unittests)

You want to make it easy for AI to execute. Human software engineers have these tools. You should provide these tools for AI. [^1]

[^1]: You also want to provide AI the ability to experiment in a safe environment. You should build separate tools, each with a different level of access. Actions that involve a lot of exploration (e.g. figuring out how to make the offline table query), build a tool with controlled access (e.g. read-only) so that any accidents that happen during exploration (e.g. dropping tables) would be contained. Actions that have a clear and obvious procedure (e.g. checking whether the button works) could have more access (use of web-browser which can have real-world impact), because we do not expect accidents to happen.

[^2]: Currently, to deploy an internal version of a product, I need to open up three terminals and run a command for each of them in parallel. New hires often get confused by the process. You see that making investments to help AI execute could help humans execute better too.





## Let them create memory

When humans write code, they leave breadcrumbs - comments explaining why something was done, commit messages describing what changed, documentation explaining how systems work. AI should do the same.

Help AI to write good comments. You need to think what good comments are. You need to communicate to AI what good comments are. Instead of writing good comments, consider writing better names for classes, functions and variables so that comments are not needed.

Help AI to write good commit messages. You also need to think what good commit messages are. You also need to communicate to AI what good commit messages are. You probably have certain standards on what good commit messages are. In your commit message, link to the context. [^4]

[^4]: Currently in my company I need to link an Asana task for every commit that I have made. I needed to search my previous commits or Asana for the URL, which is tedious. But this effort is worth it, I could easily share how I implemented a project from end-to-end. If you provide AI all the context, this should make it effortless, you just check whether the link is correct.




## Share knowledge on how to work with them

You want to promote the good use of AI. Not everyone has worked with AI as well as you do.

When you answer a question in internal help channels, try asking AI, and sharing AI's answer with them [^5]. When you catch an issue in code reviews, show them how AI would have reliably caught the issue. Instead of giving them the fish, teach them how to use the AI fishing rod.

You also want to share the configs that led to your successful use of AI, so that your colleagues can reproduce your success with AI. Collaborating on shared [rulefile](/2025/05/31/writing-claude-md) (e.g. `CLAUDE.md`) is worth the effort.

[^5]: Currently there isn't a share feature in Claude Code, so I am sharing the screenshots. Ideally I want to allow my colleague to continue from the conversation. Also I want to share what exactly were my configs (e.g.  `CLAUDE.md`, `.claude/settings.json`) that allow AI to answer that way.


## Footnotes
