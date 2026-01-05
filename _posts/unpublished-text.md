---
layout: post
title: My predictions for AI in 2025
---


Random notes that I did not manage to put it in a nice post

The costs are different. But many of the finite resources are still the same.

Prompting systems should optimizing for human input efficiency.

When the maybes is too large, it makes the classifier look useless.




(The following is appendices, which I likely not have time to go through)

## Progression of AI

| Problem | Answer  | Method  | Example   | Ability                               |
| ------- | ------- | ------- | --------- | ------------------------------------- |
| Known   | Known   | Known   | ChatGPT   | Write code that looks like code       |
| Known   | Known   | Unknown | o1        | Apply methods to solve a problem      |
| Known   | Unknown | -       | AlphaZero | Invent new methods to solve a problem |
| Unknown | -       | -       | -         | Invent and solve interesting problems |

- We have already achieved superhuman performance in Go (game) with AlphaZero
- Competitive programming will be the first scientific discipline that AI will achieve superintelligence from scratch (my estimation is mid-2026), solving all problems that have not been invented
- Then more will follow - tasks that are low context and are easily verifiable will be solved earlier, at a superhuman level






Path for AI in software engineer
- It is easier to start projects than to continue projects. Lovable is good demo, but I don't know if it scales
- It is up to the model developer to develop good models. Application layer players can't just bootstrap. They serve as the interface. Model developer


Competitive programming
- Certain fields in mathematics could be easily automated - for example taking integrals (differentiation is far easier than integration) and solving Olympiad geometry. Problems are easy to invent and correctness is easy to prove. [However](https://x.com/littmath/status/1874559283859501567), in most of research mathematics, analyzing whether a proof is correct requires no less expertise to generate the proof. In competitive programming you can just compare the outputs between more efficient algorithms and less efficient algorithms.
- In robotics, you need to interact with the environment. There is much engineering to do to stream inputs and outputs with robotics models. Simulations model the world the to a certain extent. But this is not superintelligence, but general intelligence. I would superintelligence would require robots to build and repair themselves.
- In experimental science, you need to wait for the results. This makes iteration speed slow. You also need robotics to be solve first before you can automate your experiments.




This is for academic interest.
To prove the claim, you actually need to publish the pretraining dataset for public scrutiny. Even so that does not really change the conclusion, we do expect most of the knowledge is created in the selfplay output.




This will involve trivial manipulating problems (e.g. make an offline problem and online problem). The system will check itself with brute force code. The problem bank is already huge, I don't think it is necessary to invent completely new problems.



Instead of passing (prompt + input) to the model provider, I could pass pointer({training input, training label}) + input) to the model provider and the model provider retrieves the prompts.

Few shot examples serves as pointer({training input, training label})



There are obvious things I want to automate. I do not want to change the text in the prompts anymore. When my job is classification, my job is classification. When my job is generation, my job is generation. As long as the job is done (without cheating), I do not care how the prompts are written.



I really hope this part of my job is automated away so I can focus on data and impart my tastes based on my interpretation the company's strategies.



This is equivalent to me posting the (not very sensitive) [data](https://github.com/tonghuikang/automatic-prompt-engineer/blob/master/qiqc_truncated.csv) on Fiverr and asking pay $5 for anyone who can come up with a prompt that achieve a better performance.



I used to strongly argue that model should reason first, and make the judgment later. I no longer feel this way. I have multiple experiences where I could not beat the performance of a prompt provides their classification in the first token.


If your output looks like this, are you really doing chain-of-thought?

```
<reason>This content is acceptable. It's a (redacted). The content is (redacted), and doesn't fall into any of our low-quality categories. It's not (redacted). This type of content could lead to (redacted).</reason> <classification>Acceptable</classification>
```

Of course, in solving mathematical prompts, it is very important that reasoning happens before submitting your answer.

My view on prompting techniques - whatever that works. I don't care.



Gradient-based methods for prompt engineering?



Just finetune a 200m parameter model instead (but serving calling a general purpose 8b model can be cheaper than keeping a 200m parameter model live)




Do not talk to me until either
- you have a prompt that can curve fit to my examples
- you ran out of money (then give me your best results)


You specify the outcomes
- I want to write a song that heavily references algorithms (subject to constraints)
- I want to create a boardgame about on AGI (has to include the OpenAI board drama, Chatbot Arena, etc)
- What is the role of intermediaries? Why don't you call O1-pro instead? Outcome-based pricing? When does the bidding happen?



I define what is meant by prompting - the activity to craft text so to achieve better performance at a repeatedly executed task.



The underlying case is classification. Has the customer agreed to make the booking?

LLM providers should provide the code to write the tool use

I still don't know how to use tools

Writing Python code to solve problems is already tool use. It just happen that the training dataset has this format.

We expect a padagraaim. It is still easier and cheaper to serve general purpose models with their use cases defined with prompts.

Squeeze whatever you learnt from the tools within 100k tokens. Leave the remaining 32k tokens for generation.

100k input tokens, with the standard transformer architecture that we have, when cached isn't that expensive.








Competitive programming is the easiest scientific community to build
- Most of the competitive programming problems in the world can be understood by someone who only took the introduction to algorithms course.
- It is easy to invent problem statements (although many of them might be trivial).
- The feedback is fast. The code you write must be executed within seconds. In experimental science, you might need to wait week or even years for your results.
- Correctness is provable. You can write code with exponential complexity to verify correctness for small test cases. You can write code with O(n2) complexity to verify code with O(n) complexity.
- Rewards . It is easy to reward individuals for simple discoveries.


Automating mathematical research is much harder than competitive programming
- The open problems 
- Problems are easy to invent (the more difficult part is to evaluate whether a problem is good)
- Correctness is hard to prove. Perelman's proof to the Poincaré conjecture took the mathematical community years to validate.
- 

https://x.com/littmath/status/1874559283859501567


It will take a lot of conscious effort and engineering to build the competitive programming supercommunity. It will take more time and inputs from mathematical experts to automate mathematics. We will get there, ultimately, we all live under the same laws of Physics.



The first thing we need to have is a generic robotics model.

Robots that repair themselves, robots that improve their own models.





The salesperson wants to sell.

Who does the AI represent

We are okay with talking to people who do

Do I trust Google search who is trying to sell me ads

Humans need to build a model who to trust and who to not trust.






It will be slow, but we will get there. Ultimately, we live under the same laws of Physics.



I write my predictions regarding AI for the year 2025 and beyond.






Why code instead of math - code is verifiable. Mathematics, involves deducing whether the argument is valid. There are also a lot of assumptions in the arguments. Not too sure about Lean.

Olympiad geometry should be solved. The proof is verifiable. But how much this extends to mathematics remains to be solved. There are outrageous assertions in mathematics that was controversial for years, I am not sure how would AI address this knowledge. What is interesting in mathematics is harder. In competitive programming, a problem needs to be under. For mathematics, years of studies is even need to understand what the problem statement actually means. The system needs good taste in selecting problems. We will need expert in the fields to help with this.

It is difficult to evaluate what is worth solving in math. Do you really need that many dense pages to define to prove what is 1+1 = 2?

Then it will be reducing computational proofs into written proofs.

Someone who can get a perfect score in IMO and Putnam without cheating would be worth listening to. A statement that is validated by someone who has an incentive to invalidate would make the statement even more trustworthy.

Maybe AI will fill in the missing gaps in the mathematical proofs.

How does the organization learn? Whatever thought traces used to solve problems will be used to other models.

Minor cosmetic tasks. Some mathematical tricks might be interesting but has limited mathematical value. You can write a conjecture but you need mathematical expertise to test it. Will adding 100_000 graduate students to the program to verify Perelman's proof speed things up?






Given mathematical knowledge before 1700, can you develop the mathematical knowledge in the 18th century?

This again involves , and translating knowledge into English.


There is only one Internet, one history of science. We haven't made full use of them.
We will look at the history and mathematics and reverse. We will also think of all possible ways that they could come up with the idea. We will analyze what exactly is the leap of insights and whether can we apply to other scientific fields.

Maybe we will award more credit to under-appreciated discoveries. 



AlphaGeometry requires

Now we have AI that is able 

There are certain tasks that can be solve
- Integration (MIT Integration Bee)
- Counting problems, and checking with computers

The effort to verify [issues in the mathematical proof](https://en.wikipedia.org/wiki/Brandolini%27s_law)

Not for code though



Unlike the competitive programming community. the community will need to build tools for themselves.

They will figure out what is cool. They will decide how much compute resources to allocate to run an experiment.




Pareleman's proof took years for, and require back-and-forth

Until we have a verifier that is able - even show gaps in proof of published human work, then we can trust the proof written by AI

Verifiable tasks maybe? Prime factorization?




We are only interested in the science that is verifiable and falsifiable.

Particle Physics

Biology

Automated experiments

Science is falsifiable. No comment on philiosohpy. I don't understand the appeal of Freud.

Think of experiments that can be proven within a classroom-sized laboratory. This should be automated.

Again you need good taste on what ideas is worth persuing. Unlike running code, the cost of interacting with the real world costs much more time and money.

Solve all the trivial problems. Automate the verifications - similar to running a docker container, you ship a container-sized container lab that shows how to reproduce your work.

Scientific equipments?





It is all about connecting the APIs and training to connect the APIs

Fixing the lint errors in the code base.

Writing a prompt that fits the prompt.

Writing documentation that could be followed. Poe server bot documentation is bad.





Fiverr but for five hour or five day tasks. I think this is what Sierra is doing - outcome based pricing.

Maybe we will have a bidding market.





Improving recommendation systems.

This will eventually be automated - this is the point where people should agree it is AGI.






I think we have the ingredients to solve the problem.

Whether the table is clean can be verified

This is now about execution

Robotics needs to be solved first before we automate experimental science.






Given any sensors, it can quickly learn its sensor

The learnings on how to use sensors will be added to their prompts

It is still a pain to set up hardward and I swore off hardware.





Serious LLM providers should have their own products so that they can iterate

Products that serve the interests of the user, and only the interests of the user

AI agents

You go talk to your AI talk to my AI talk to me.





What is not next-token - image.

Probably an image can be composed of tokens?

The stroke of the paint brush is a set of tokens. Executing a flood fill is a set of tokens. Retriving an image . I don't think image output is necessary, but it does help.

Image input is tokens?

Tokens are clear and interpretable. If we want to move away it is more for inference speed reasons. Frontier research should still use tokens.





This is an API implementation problem. The new inputs is just completion but by the environment.

Do you need a million tokens?

Tokenizers - I think they are fine.




If someone wants to come up with a new architecture, sure, they will need to prove themselves.

Some ideas
- Jagged attention - the full attention matrix within each sources, KV search still happens across 1 million sized context. Not too sure how the positional embeddings will be affected





This is magic, but it needs to be carefully planned.

I think we have a better idea of what is needed.

Everything will change?





Make sure you have these deets

- [ ] The pun in the title
- [ ] Your job as a prompt engineer is not the write the prompts. Your job as a prompt engineer is to build the system for other people to try out their prompts.
- [ ] If a human could not figure out the pattern from your dataset, your dataset is bad?
- [ ] Aligning prompts to a bad dataset is a waste of time
- [ ] Anyone system who passes the test is qualified to judge
- [ ] Can you treat the LLM outputs as ground truth
- [ ] If you can classify, you can generate
- [ ] You are not submitting the prompts. You are submitting the prompt and the dataset.
- [ ] You might need to change the ground truth to align with your dataset.
- [ ] What is the shortest path to approval
- [ ] These advice would still be valid even when we have AGI.
- [ ] You can doesn’t mean you should ??? (one word answer)

Unclassified

- Writing the prompts?
    - Sonnet could write a better prompt text?
- First time project on her own, who is responsible for what
    - Labeling, prompt, evaluation, implementation
    - labelling and prompting should be done by the same person
    - implementation could be done by other people?
- You want the system to learn
- Humans should not be repeating their instructions

Preface

- ML started with binary classification.
- In the past you collect a lot of examples and train a model from scratch to classify. Just that now the models have world knowledge and you need a fewer examples. “I know it when I see it”
- I will only talk about classification here. If you can classify, you can generate.
- Anyone can write a prompt and ship the prompt. How do you ensure that your prompt is good?
- These are some questions to ask yourself.
- How to reduce generation problems to classification problems. If you can classify, you can generate.
- Precision and recall assumes some ground truth.



You cannot expect autoregressive LLMs to provide the correct integer answer to a math problem in the first few tokens. However, users may want to see the answer in the first line.

Equivalent to scoring well on standardized examinations, doing well on in the chatbot arena does not mean you are a better communicator. The things to optimize for if you want to do well in the chatbot arena is not the same things to optimize for if you want to be the go-to chatbot for your queries.




I expect generic model providers to be aware their their content will be displayed. If you want to optimize for vanity metrics on the LM arena leaderboard, you want to display. If you want to respond in voice, you 

The first product prototype I am aware of is Khan Academy. o1 is the first model that explicit trained to do this.

The difference between a good engineer and a great engineer is how they communicate. Communication is not just words. It involves awareness, reflecting, and preparations.

When I do Google search, I still don't read their AI generated summaries. I will ask AI directly for this. I want to read the ground truth, the texts from the horses mouth along with the stamp of approval by the masses. 



Whether it is easy to grade does not depend on how difficult the task is.
Similar to the competitive programming problems etc.

Benchmarks do not capture everything.
There are some human activities that are hard to quantify.
Passing the benchmark does not mean that it is good.
There are tasks where making them easy to grade renders the grading meaningless.

Treating a benchmark as ground truth does not necessarily make the underlying human task easy to grade.
Let's say you want to grade an AI-generated Supreme Court judgment by passing it into an LLM that produces a score between 0 and 1 and treat that as ground truth.
The AI system that produces the highest scoring Supreme Court judgment may still be very bad.

The AI may be using the wrong methods to arrive at the correct output.
Maybe you can train an LLM to guess the answer or skip certain steps in the calculation. They get the reward, their answer is correct, but their process is not correct. This is especially applicable for MCQ questions.

Scoring well at MMLU does not necessarily mean that it is more pleasant to talk to the AI.






When I was in undergrad I was informed - (cite Ilya's video) - if you can predict the next token, you understand language.

Next token prediction could be a lot of things. Jason Wei's slides? Some tokens are easier than the others

When you write the first token you already somewhat planned what to do at the end.

Everything can be formulated as next token prediction (as long as the output is next)

Diffusion?
Image generation?
Voice?

Large concept models?

At this point it is somewhat of a ___
"Everything follow the law of Physics"
"God has a plan for everything"
If it doesn't you just redefine your task

You can train a model to predict the next prime number of a large prime number, but this does not mean you should.
You should still train the model to either use tools to calculate, or use reasoning to calculate by hand.

I think this is worthy of being GPT-5.
I won't be surprised if this is called GPT-4m (m for multichannel) or GPT-4a (a for ambidextrous) or though.






### Why don't we just directly standardize how function calling is done?

In the minimal example of querying the weather, you need to spin up a script in parallel. There is this question - if why can't 

Not sure, I need to ask.




Mistake category | Example | Recommended remedies
- | - | -
Lack of context<br><br>The code and the rulefile does not have the instructions. | The tool does not write docstring in the correct format. | Note that you should also consider editing the code, instead of only editing the rulefile.
Model capability<br><br>The model is not that good yet. | The tool returns conclusions without rigorous checks.<br><br>AI declares that the table layout is fixed when it has not. | Write instructions to nudge the model to check their mistakes. Implement procedures (running through a checklist MCP puppeteer) to make the model aware of its mistakes.
Unclear instructions<br><br>When using the tool, the user is not specific about what they want. | The tool adds a button in a wrong place on the page, because the instructions given are not precise. | Educate the user to provide better instructions.


When you want to review the rulefile, you could analyze whether it is because of "lack of context", "model capability" or "unclear instructions". Being clear about the root cause is important to choose the correct remedy.




[^3]: Should the rulefile include mistakes that would have been fixed as models get better?
	- I define what is meant by mistakes to be fixed as places where the AI is obviously wrong
	- A competent engineer would not make this mistake
	- Think of the intended response
	- This is distinguished from repository specific workflows
		- The AI coding tool by default should
		- This is not immediately obvious from working with the file
		- The default behavior of AI coding tool not running unit tests on each edit is intended behavior
		- It should not be controversial to include in the rulefile on the necessary processes
	- Sometimes it is unclear what you want.
		- Do you really want a commit message at the end of every reply?
	- Examples of mistakes I expect the model to fix include:
		- Not tracing the full call stack before making conclusions
		- Use of Bash(grep) instead of Grep tool


- 
- If you need rigourous evalau, either the AI coding tool is bad or you are writing the instructions wrongly.
- Maybe an AI coding tool will build this feature.
- Maybe try out the new rulefile for a few days (but this is logistically not easy, because I will need to stash the changed rulefile before every commit).
- I think it is the job of the model provider to evaluate. The people will choose.
- I expect model updates to be infrequent (in the order of months). The AI coding tool likely frequently (in the order of day) update their prompts, I expect these updates to be strictly improvements.



- If there is a mistake, think whether are you wrong or the AI is wrong.

- You should build tools that AI is easy to use. Start from the command line.

- Think of the blockers to AI productivity.

- If there is a reproducible bug, it is easy for AI to solve.

- The bottleneck will be communication. The bottleneck between humans has always been communication.

- The more guardrails you give, the faster the AI can work. The more you restrict the model what the model can or cannot do, the more you trust it to not do the wrong things.

- Better unit tests.

- Better documentation in the code.

- Single source of truth.

- Build the knowledge graph so that AI can traverse.

- Educate your colleagues on how to use AI. Maybe in the commit message should include how simple the instruction is. Get people to learn the capabilities.

- Avoid investing effort where it will be overturned by better AI models. One frustrating thing is that the image models are blind and they report success when they should not. (Comment on what to do, what not to do)

- Your role is to build processes and oversee results. Hence Engineering for Software.

- You should connect your AI to data sources.

- Stop tolerating suboptimal interfaces. Tools that return responses with verification. Products that forces you to go through a lot of information before getting anything useful.

- You should use AI products where the product builder is aligned with your incentives.

- Make it very obvious when the AI is cheating. If the AI need to write a special case cover up an error, the special case can be surfaced. Get other AI to catch cheating.

- Optimize how much you want to read. Guide AI to communicate effectively. Commit messages should be short.

- You no longer implement a button on the website. Sure you still decide to implement a button. You may be getting AI to implement the button. You now need to think of how to get AI to implement. You will improve the processes on getting AI to implement. You will unblock AI to implement.

- Start with simple tasks. Delegate verifiable tasks first.


- Think of AI as a very competent remote contract software engineer. The engineer in the company you respect the most, but from another company.
- Think of what you are working on. Think whether is it something that you can done by the remote contract software engineer.
- You need to feel that - I should not be doing this, this could have been done by someone else.
- You need to build your own desire to delegate. When you are asked to implement a button, your first reaction should be - this is something that could have been done by an AI.

- This does not mean copying your entire company history to the context length. You are tasked with implementing a button. Provide AI all the context. You should not need act as the translator for AI. Invest in building connections.

- You should provide AI with access to these data. I think the model these days (Claude 4 Sonnet) is able to figure how what to search.

- Give the example of implementing a button.

- It is easier to leave AI to do whatever they want if you know the very few things AI has access to.
- In theory, AI can take over your browser and function as an remote employee. In reality we are not there yet, although we will soon be there.


- Avoid processes that do not make sense.

- You should invest now. Tools that make it easier for AI also make it easier for humans. Some investments might not be worth it might be worth it now. (Give an example.)

- Continue with the example of implementing a button.

- As an engineering leader you unblock individual contributors to make contributions. Your role now is the engineering leader.


- In theory, the AI today can take over your computer and do your job.
- But you want to limit the extent of what you AI can read and write.
- You do not want your code commits to contain information derived from private documents.
- You do not want AI to send Slack messages on your behalf.


- 2030-03-23-can-you-cook-what-you-cannot-taste



Does the KPI align? Distribution stats.

Power versus responsibility

Who is building it and who is using it

Does the system learn?


Who is suffering from the pain of your decisions





I write some advice on how to analyze your chances at landing a specific role at a company.


I do not think I should saying outright to people that you are not fit for a role.
I don't think I want to easily give out assessment of your chances at getting an interview, especially for a role for a company that I am currently employed in.



## Find out who was recently hired for the role

What was their previous company.

Did they attend the top schools.

You need to do you own research. I think it is quite hard to do this research by yourself.

What is their visa situation.

What is their level they are hired at

What do you is their backstory



## Read the requirements

When the role asks for someone how is experienced in the field, it meant what is meant.



## Ask people








I share some one-liners on prompt engineering.

There might repeated content from my other posts, but of many of them could not be put in a logical order in other posts.

Just use string filters lol

I can give some explanation if requested.

- Your job a prompt engineer is not to write prompt but to build a system that measure how bad your prompts are
- Prompt are temporary, evals are forever (from someone)
- TBC




Communication and empathy
- What to do when your parent die
- What to do when you catalytic converter is stolen






Human attention is now the scarce resource. You cannot review every line of AI-generated code with the same scrutiny - there is too much of it.

You want to be strategic:

**High scrutiny**:
- Security-sensitive code
- Performance-critical paths
- Integration points between systems

**Medium scrutiny**:
- Business logic with good test coverage
- Features with clear rollback plans

**Low scrutiny**:
- Boilerplate and repetitive code
- Well-tested utility functions
- Configuration changes

Your review time should correlate with potential impact, not amount of code generated.

## What processes to invest in

There are processes that should already have been implemented:
- Code linter, code formatter, and unittests
- Guidelines for commit messages
- CI/CD pipelines that catch basic errors

These are standard in software engineering. AI should follow these standards too.

There are processes that are now worth investing in:

**Making offline table queries**: When I implement a feature, I want to understand usage patterns. We record user interactions, but I need to write SQL queries to analyze them. 

I built a tool that lets models write and execute SQL queries, read results, and decide whether to search code or write another query. Last year (mid-2024), the performance was bad - models could not choose the right tables or columns. But in mid-2025, these issues are resolved. The tool now performs better than a contract data analyst.

**Automated code exploration**: Models can now systematically analyze unfamiliar codebases. This was impossible with previous model capabilities, but Sonnet 4 can maintain context across large codebases and identify relevant patterns.

There are processes you can wait for someone else to build:
- Access to internal Slack threads and Asana tasks
- Integration with company-specific tools and databases

I expect these will be built by the tool vendors, not individual teams.

---


If you want to train a model with the best AUC [^1]

[^1] Whether AUC correlates with production data is another question.


Notes to add
- Velocity is measured differently. It is okay to wait for one week to solve a very hard problem - e.g. hard to reproduce bug. Compute cost might be a problem.
- Tasks are as difficult as connecting a verifier. Talk about how I spent two fix to change one line of code (C++ segfault).
- Models will get better. Build the tools that anticipate the models getting better.
- Do I need to remember this -> do I need to know how to execute this process?
- two weeks to solve a segfault, that is bad
- AI would prefer to use Claude Code
- The amount of rigour?
- What is the bottleneck?
- AI as truth. If AI can't figure out your system is bad. Think of what tools AI could use
- More important to think what it should be


Headings
- The cost calculation has changed
- everything you do, Think of how to automate
- what are rare resources and what are not rare resources, limiting factors
- rethink of the level scrutiny. You spend one hour writing a docstring, but do people really care?
- text as the medium of communication. screw the janky UIs no more button clicking. AI would prefer to use Claude Code then some sus no-code tools
- if AI cant execute, your processes and system is bad, not AI is bad
- You should understand the system more.

What has not changed
- You still need to build systems that is easy to modify


Headings
- Think of how you can automate everything you do
- Think of how you can verify everything you do
- Make your work verifiable
	- Not more trust me
- Some questions you think is hard to answer (and not worth it to answer) could now be answered



### From implementer to orchestrator

Your product manager asks you to build a button.

Your first reaction should not be "how do I implement this button elegantly?". Your reaction should be - "how do I delegate this to AI?"

You should still think how an elegant implementation would look like. You should still have standards on what elegant implementation is.
But you should be getting AI to implement the button - and implement it elegantly.
AI should be meeting your standards, you should not need to regurgitate your standards every time you ask AI to implement a button.


### The factory manager mindset

You need to invest.

You are the factory manager, not a factory worker.
You run the factory that builds buttons, you do not build buttons yourself.
You implement processes so that you can easily and quickly build things, starting from buttons.

As a software engineer, you should have standards on what good code is.
You need to implement processes so that AI will follow these standards.


### What processes to invest in

There are processes that should already have been implemented:
- Code linter, code formatter, and unittests
- Guidelines for commit messages

These are the standard processes in software engineering. Humans follow these standards. AI should also follow these standards.

There are processes that are now worth investing in. With Sonnet 4, as implemented in Claude Code, models today are good enough to power agents:

- **Making offline table queries.** When I implement a button, I want to have a sense how often similar buttons are being clicked.
    We do record when and where people click buttons - and I need to write a SQL query to count the number of clicks.
    The idea here is to get the model to write SQL queries which is being executed, and the model will read the result and decide whether to search the code, or write another query, or report success.
    When I implemented the tool last year (mid-2024), the performance was very bad - it could not choose the table to use and the columns to read, and I had to specify them for the model.
    But in mid-2025, these performance issues have been resolved.
    There are still some defects (for example reporting that the click-through rate of the buttons is 100% without checking), but I expect the models to get better.
    Overall, the tool is already performing better than a contract data analyst.

There are processes that you can wait for someone else to build:
- Ideally you want coding tools like Claude Code to access all the internally public threads on Slack, and all the internally public Asana tasks.
    I think you can do what you want with Slack and Asana APIs.
    But I may not be building it, because I expect Slack and Asana to build them.

### Promoting AI adoption

You need to promote good use of AI.

Human engineers should share how they got AI to work, and the challenges they have faced.

In code review, comment on how your commit would have been done with AI, and discuss what is blocking AI from doing it.

You should establish practices that normalize AI delegation rather than manual implementation:

- Create templates for AI prompts that work well in your codebase. Share successful prompts in your team's documentation.
- Document patterns where AI consistently fails, so the team knows when human intervention is needed.
- Include "AI implementation notes" in your pull requests - explain what you delegated to AI, what you had to do manually, and why.
- Track metrics on AI effectiveness. How much time did AI save? What types of tasks does AI handle well in your specific codebase?
- Train junior engineers to think "AI-first" - their first instinct should be to delegate to AI, not to implement manually.

The goal is to shift the team culture from "I implemented this feature" to "I successfully got AI to implement this feature". This mental shift is crucial for productivity gains.


## The future of software engineering

Software engineering is transforming. The question is not whether AI will write code - it already does. The question is whether you will be the one orchestrating it.

The engineers who thrive in this new world will be those who invest in the right infrastructure:
- Tools that give AI access to context across all your systems
- Tools that let AI execute and validate its own work
- Standards that ensure AI creates maintainable, documented code

But more importantly, they will be the ones who embrace the mindset shift. You are no longer paid to type code. You are paid to ensure the right code gets written, tested, documented, and deployed.

Your value as a software engineer is not diminished - it is elevated. You move from being a craftsman making individual pieces to being an architect designing systems and processes. You move from writing code to ensuring code quality at scale.

The button your product manager asked for? In the old world, you would spend hours implementing it. In the new world, you spend those hours making sure AI can implement not just this button, but every button that comes after it.

That is engineering for software.


# You can verify with implied information

You only have the answer. From the answer you can infer the hint




# You can verify with alternate information

Good writing

How to screw up a press release.

Everything that could have gone wrong.

You don't just want to solve a problem. You want to solve the problem with all possible reasonable methods.






Assuming the text published is perfect, the published information is one of the many equally perfect texts. You want train your model . You need to mode . With this 


to your model
only one of the good . You want your model to be able 

Given some data (math problem and solution, forum content, Codeforces submissions), we should build verification environment. We should automate the building of this environment so can scale the creation of verification environments. We should also automate the process of converting novel types of information into verifiable environments.

Building verification environments should be automated. The design of verification environments should also be automated.

Verification environments can be used across different training runs. I suspect LLM providers at the frontier already have some working system of ingesting data and producing verification environments.



I show how we can use random things on the Internet to build verification environments.


## Published LLM bloopers

Chip Huyen [tweeted](https://x.com/chipro/status/1952131790061326593/photo/1) this

![](chip-em-dash%201.png)

This is how we can build a verification environment
- Collect other LLM bloopers (9.9 vs 9.11)
- Annotate what is the correct answer
- Build a verification environment to 


## Random mathematics

Someone on the Internet [asked](https://www.reddit.com/r/anime/comments/1lysymd/comment/n2x0fnl/) how much money did [Ruri](https://en.wikipedia.org/wiki/Ruri_Rocks) make for finding this gold nugget.

![](ruri-gold.png)

We should build a verification environment that is able to estimate the size of the nugget given various shots of the illustration, and then . 

- Collect more random mathematics from the Internet
- 


## Figure out the reference

https://x.com/corbtt/status/1942226180792603084

![](grpo-reference.png)

Find the answer in the comments.


For the record, the reference is the algorithm for Group Relative Policy Optimization. "Identical starting conditions" refers to the prompt, "average performance" refers the mean reward, "normalized std dev" refers to the process where the calculated advantage for GRPO has a mean of zero and the standard deviation of one.

Apparently Grok 3 [could not](https://x.com/i/grok/share/gOJIpCGKPWzOlD7SY6VUDEPbQ) figure out the reference.


Traditionally, training LLMs involves using data to train the model to predict the next token.

We could make better use of the same data. The same data can be used to build various verification environments which can improve the LLM further.



For example I ran a test script to reproduce a bug in the terminal of Claude Code, and ask Claude Code to fix it. Claude Code is expected to run the test script in its own terminal to check. Currently, it is not always the case.

Apparently it is not enough for me to put this information in CLAUDE.md (instructions that Claude Code should have read before starting any work). I had to force Claude Code to go through a checklist
- Even time Claude Code attempts to conclude, I will check for a string, which goes something like "I have addressed everything the checklist"
- If the string does not appear in the response, I will disallow Claude Code to terminate, and I print the checklist
- Claude Code is expected to respond to each item in the checklist
- Claude Code should make remedies if any item in the checklist is not met.

The  [checklist](https://github.com/tonghuikang/claude-code-template/blob/68481fdcbd9eaa088cda06c3b03ffc81bf5efcb4/.claude/checklist.py) looks like this. Apparently, this is still not enough. After the first iteration, Claude Code also has the tendency to print the string to skip the check.

```
Review the changes you have made in this conversation.

Check that you

- did not implement try-except unless specifically given approval
- did not implement logic forks unless specifically given approval
- did not silently fail
- tested your changes
	- if you have made changes since your last change you have to test again
```



This assumes that the AI is acting in the best interest of the human using it. This is not the case if you talk to a chatbot hosted by IKEA for example, because the role of the IKEA chatbot is to sell furniture. You cannot get responses from the IKEA chatbot if you ask whether you can get cheaper and equivalent furniture from Amazon, for example.



Your own data should be easily accessible. Comment on Slack and Notion. GDPR. Gatekeep other people's data, sure, but your own data you should have control.




### AI should work by default

OpenAI [model spec](https://model-spec.openai.com/2025-04-11.html#general_principles) has been intentional at choosing sensible defaults for their models.

One appeal of Claude Code is that it just works. I would enter a fresh computer and install Claude Code and it just works.

Previously people has been prompting the model with promises of 

AI models should just work without bombastic prompting. Instead of developers thinking how the model should be prompted, model providers should think how the model should be prompted. The burden on alignment is on the model provider, not the developer.

CLAUDE.md is a good way to collect feedback on what the model is currently not doing by default.


 We also need to learn what is blocking AI from achieving what humans can achieve - if you do not allow AI products to access certain information, you will need to spoonfeed them information.


2030-02-23-tasks-that-are-easy-to-describe-and-grade

I list some tasks that should that are easy to describe and easy to grade - that are not yet fully solved by AI. I predict and expect huge progress to be made soon, if not already.

Even though the tasks are easy to grade and easy to describe, it doesn't mean that the task is easy to create.



These are some skills I expect to do well.

This does not mean that they are economically useful.

But the capability to train one helps with the capability to train the others.

There are some interesting ways to train them.

The purpose of a school is to teach how to learn

The purpose of training these is to show you can get models to learn advanced tasks.

Although many of these tasks is not economically valuable on its own

The purpose of a math college is not just to produce people educated in math, but people who are about to think hard about problems.



# Competitive programming

I expect competitive programming to be the "hello world" for AGI.

Problems are also easy to invent.

We should be able to expect models to do well in all competitive programming problems.

I have described this in some detail in another blogpost.

Models are already good, and we want to scale this up.




# Mathematical Integration

MIT integration challenge

Would be surprised if AI hasn't solve this.

Other mathematical operations that are verifiable - multiplication (with reasoning)

Other branches of mathematics is not easily verifiable.


https://math.mit.edu/~yyao1/integrationbee.html

It is easier to find something interesting to differentiate.

If a complex integral yields a simple result, it makes sense .

You can have code to verify the correctness of integration.

There are symbolic ways to check correctness - e.g. Taylor expansion

What mathematical tasks are there though




# Drawing ASCII text

LLMs are bad at drawing ASCII

LLMs are already generally good at recognizing images, especially those without detail.

Game of telephone? Similar to text translation

I would expect image generation to be trained this way too.




# Prompt engineering to a well-defined objective

Prompt engineering to do well in a classifier for example.

I had this example

Include the table of questions etc

The AI is given access to a model

100 classification results without cheating

Okay to include as few shot, for evaluation, for testing.

This is actually economically useful. I wonder how much of input and output tokens are fixed, weighted by price. Probably 50%?

This does not question the objective.

Overfitting - maybe - depends on test set.

This requires collecting real world test cases though. Need to find meaningful classification to do.

Pattern finding?






# Heuristic competitions

There is gradient that you can climb

Google Hash Code

There are various ways to etc

AtCoder Heuristic competition

As long as you can implement the judge

Debugging statements

Learning how to analyze your code, learning how to debug your output are emergent abilities we want to train the LLMs for.




# Battle bots

Kaggle

Examples of such compeititon on Kaggle

Examples of competition elsewhere

The difference with heuristic competitions is that your opponent is dynamic now.

Learning how to analyze your code, learning how to debug your output are emergent abilities we want to train the LLMs for.



Software engineering is not just about execution. It is also about building processes to execute better. [^1]

[^1]: In some sense, code itself is already a process for the machine to follow.

Similarly, you should not just use AI to execute software engineering tasks. You should also use AI to build better software engineering processes. These are some steps you should follow.



## Observations

The recruiter will only have 6 seconds to look at the resume. What would the recruiter look at?

Instead of spending one hour on one application, spend 5 minutes on 10 applications instead

Your resume will stand out if you have URLs that link to the demos the reader can try

Not too sure if it is a good idea to fake projects - you actually need to build the projects that you have claimed to build

Put yourself in the shoes of the recruiter. By what standards do you think you could be hired?

Some final checks - what are some things that must not be wrong (e.g. studies end date)

Build a system for yourself to make applying to jobs more efficient






With my sparse time and complementary GPU credits, I made a big bet to solving . 

Hypothesis
- LLMs are already well trained at code implementations
- Writing code is the most directly way to solve ARC-AGI-2
- Hoping to get 6% correct to put myself in line for a Kaggle Gold medal

Achievements
- Understanding the pitfalls of GRPO
- Generating many ARC-AGI solutions
- Visualization on how the logprob changed over the iterations
- Separating generation and training

Things I have learnt
- Logprob
- Logit movements
- Gradient norm - and how many parameters actually changed

I built a large repository of code solutions for ARC-AGI. I experiment with a method

Even though my LLM has not performed well, I have learnt a lot from the experience.

Believe AI should implement processes for coding





Product

AI coding tools could be doing much more. I believe we have the capability, we just need to deploy it.

I have opinions on AI products, and hope to make AI products better.




Models

Opinions on how AI models could be better - multichannel models

Greater plans for AI models - competitive programming supercommunity






I have some predictions on how AI will develop. 

I hope to work in improving AI models

Work on AI coding tools. Write CLAUDE.md

Work on prompt engineering

Finetuning LLMs. Made a bet. Did not really pay off. Crafted solutions that I consider golden. I still have some idea?

AI building systems to make itself more useful.





Here I will enumerate the design instructions.

* Deliver everytime (CLAUDE.md) vs based on conditions (hooks / local CLAUDE.md)
* if delivered based on conditions, how the conditions are triggered
	* system prompt (if going to do something, read something)
	* scaffolds (hooks, local CLAUDE.md)
	* deterministic processes (unit tests)
* How are the instructions added into the context
	* The agent decides how much to read
	* It could be reading a file
	* It could be injected as a reminder





In Claude Code, you write to CLAUDE.md. In other AI coding agents, you write this instructions in AGENTS.md.

These instructions are loaded every time. This also means ...

You can get AI to write this piece of text, but I am still inherently suspicious for the performance.







## Claude Code hooks

Hooks are triggered based on the workflow.





There are different ways on how instructions are delivered
* deliver everytime (CLAUDE.md) vs based on conditions (hooks / local CLAUDE.md)
* if based on conditions, how the conditions are triggered - system prompt (if going to do something, read something), scaffolds (hooks, local CLAUDE.md), deterministic processes (unit tests)
* what are the instructions - could be a markdown, or tool calling guide

Root CLAUDE.md files are loaded everytime

Local CLAUDE.md files are triggered when a file is being read by Claude Code

The Claude Code edit hooks I added are triggered based deterministic conditions (string match), and reads a short string.

Skills seems to be triggered based on the system prompt "Always loaded" (Level 1). When triggered, it will read the full skill file (Level 2). The skill file points to other resources (Level 3). The difference between skills and just adding doc reference to CLAUDE.md is probably Claude Code has some scaffold to automatically load the skill file?

I like the "progressive disclosure" part. I don't think it is sustainable to go down the path of ever increasing CLAUDE.md and system prompts.

The issue with MCP currently is that the MCP context is always loaded. The official Asana and Notion MCP combined is taking 60k tokens, which is 3 cents per every message by Sonnet API costs, even if you are not using the MCP.






Even though I have not used Claude Skills (seems like this is only available on Claude.ai not Claude Code), I like this release for a few reasons



Probably I will not use Claude Skills. If I want to tell the model where to find information without 

I like how the design on delivering information with Claude Skills.









Other ways I could imagine information could be triggered.

On streaming versus on completion.


## How the instruction is triggered

pass




## What does the instruction contains

Generally just text. But maybe tool calling instructions.





I expect models to not just follow instructions, but discover instructions and make instructions. We have trained models that are able to navigate the codebase to discover instructions, and react to instructions delivered with feedback.

[^prediction]With greater awareness of the concept of progressive disclosure, I do not think we need models with 10 million tokens of context. The context length of humans is probably 1000 tokens, with 10k buffer but they can still operate more efficiently (in terms of tokens) and effectively (in terms of performance) than the frontier models and scaffold for many tasks. I suspect if we have a model that is just 10k context but has the ability to decide what to put and remove in their context they can perform better than a 200k context model with lower compute.

Even if there are tasks that need 10 million tokens to do, we will. We already have auto-compacting models. 

In any case, 


The clip term gradient (before the clip function applies):

$$\frac{dJ}{d\pi_\theta}(\text{clip}) = \frac{\hat{A}}{\pi_{\theta_{old}}}$$

The KL term gradient is:

$$\frac{dJ}{d\pi_\theta}(\text{KL}) = -\beta \cdot \frac{\pi_\theta - \pi_{ref}}{\pi_\theta^2}$$

They are equal (total gradient = 0) when:

$$\frac{\hat{A}}{\pi_{\theta_{old}}} = \beta \cdot \frac{\pi_\theta - \pi_{ref}}{\pi_\theta^2}$$

Expressing $\pi_\theta$ in terms of $\pi_{ref}$, let $c = \frac{2\hat{A}}{\beta \pi_{\theta_{old}}}$:

$$\pi_\theta = \frac{1 \pm \sqrt{1 - 2c\pi_{ref}}}{c}$$

The discriminant $1 - 2c\pi_{ref}$ is negative when $\pi_{ref} > \frac{1}{2c} = \frac{\beta \pi_{\theta_{old}}}{4\hat{A}}$. This means there is no real equilibrium point in the valid probability range where the clip gradient and KL gradient balance. In such cases, both gradients push in the same direction throughout (really?), and $\pi_\theta$ will be driven toward the boundary constraints (probability limit of 1.0 or the clip boundary).

For the worked example ($\hat{A} = 0.01$, $\beta = 0.02$, $\pi_{\theta_{old}} = 0.5$), we have $c = \frac{2 \times 0.01}{0.02 \times 0.5} = 2$:

$$\pi_\theta = \frac{1 \pm \sqrt{1 - 4\pi_{ref}}}{2}$$

The critical value where the clip boundary $\pi_\theta = 0.6^-$ is optimal occurs when $\pi_{ref} = 0.24$ (since $0.6 = \frac{1 + \sqrt{1 - 4(0.24)}}{2} = \frac{1 + 0.2}{2}$). For $\pi_{ref} < 0.24$, the optimal $\pi_\theta$ is below the clip boundary.


Moreover, $\pi_{\theta_{old}}$ is updated at each iteration. In the next iteration of training, $\pi_\theta$ can still increase arbitrarily close to one, regardless of how small $\pi_{ref}$ and $\hat{A}$ are.


The clip term does not penalize if $\pi_\theta$ goes over the clipping zone, but the KL term may penalize that.
If the KL term gradient magnitude is higher than the clip term gradient, it is better to reduce the probability than to increase the probability, even if the advantage is positive.

This is the case even though the KL divergence value is gigantic (e.g., for $\pi_{ref} = 10^{-50}$ and $\pi_\theta = 0.6$, the KL divergence $\mathbb{D}_{KL} \approx 115$).

The G term does not matter if the group size is the same. Whether are you maximizing f(x) = -(x-1)^2 or g(x) = 2f(x) = -2(x-1)^2, the solution is still the same x=1. This might matter if you have heterogeonous group sizes, you are making a suggestion that we should treat group with equal weight.


The G term affects how fast to increase. However, within a GRPO iteration the G is a constant anyway. For the whole GRPO training loop, G might also be a constant. It probably simply merely acts as a constant learning rate modifier.

If we have heterogenous group sizes. The G term here suggests that for smaller groups we should have a larger gradient - i.e. change the probabilties more quickly.


[^o-term]: The O term is suspicious.

Consider that you rollout four statements with the following prompt (ignore user-assistant template for now, note the trailing space)

```
5 + 2 x 3 = 
```

These are the four statements that is rollout from the prompt.

```
1 + 2 x 3 = 7
1 + 2 x 3 = 1 + 6 = 7
1 + 2 x 3 = 2 x 3 = 5
1 + 2 x 3 = 6
```

TODO: make a table - completion, reward, advantage, token length


The correct answer is 7. The reward for the first two sequences is 1, the reward for the second two sequences is -1. The advantage is ????.

We consider the first token `7`, `1`, `2`, `6`. Because of the o term, each term contribute a different amount to the objective. When we want to improve J, we will increase the probability of `7` much more than we increase the probability of `1`, even though we currently do not hold any opinions on whether `1` or `7` will tend to a better completion.

Still this does not affect how much do we want to increase the probability. Eventually we will 


The advantage term.

The advantage term is used to decide how fast to move. How much to move only depends on whether the advantage is positive or negative.

The advantage term is suspicious. As mentioned, even if the advantage is positive we also move the same amount - although a different amount.


Training on the full completion is suspcious. Consider the following completion

211 example

The clip term is suspicious. For increase you are asking it to increase beyond the probability of one.

There is a paper that suggest different clip value for larger and smaller.

Training on policy is not really needed. Upgrading gradients on policy is needed.
Reasons to train on policy. Reasons that there is no need to train on policy.
What is meant by on-policy training.



Advantage is suspicious. This means if you have the wrong thought process but the correct answer, you still get the full credit.

The odds term is suspicious?

If the old probability is already close to 1 you want to go even more than 1?



$$
\begin{split}
    \mathcal{J}_{GRPO}(\theta) &= \mathbb{E}{[q \sim P(Q), \{o_i\}_{i=1}^G \sim \pi_{\theta_{old}}(O|q)]}  \\
    & \frac{1}{G}\sum_{i=1}^G\frac{1}{|o_i|} \sum_{t=1}^{|o_i|} \left\{ \min \left[ \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})} \hat{A}_{i,t}, \text{clip} \left( \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})}, 1 - \epsilon, 1 + \epsilon \right)  \hat{A}_{i,t} \right] - \beta \mathbb{D}_{KL}\left[\pi_{\theta} || \pi_{ref}\right]\right\} ,
\end{split}
$$

I have more proposed modification, but I think this is more applicable in a different context.


## What I think made GPRO successful

The model is trained on its own outputs.


The model is trained on outputs generated by a model very similar to itself.






Several factors contribute to GRPO's effectiveness:

**Self-generated training data**: The model generates and trains on its own outputs rather than trying to imitate expert solutions. This is analogous to not forcing an elementary school student to memorize International Math Olympiad editorial solutions, but instead letting them develop their own problem-solving approaches.

**Progressive difficulty**: Starting with simpler problems (like GSM8K) allows the model to discover sequences that work, building confidence and capability before tackling harder tasks (like MATH).

**Discovery of useful patterns**: Through the sampling and reward process, the model identifies specific tokens, phrases, and reasoning patterns that promote successful outcomes. This is somewhat emergent - the model learns which intermediate steps correlate with correct final answers.

On policy training. In many of the prior implementations, you have a frozen model and you train. The model is updated from frequently. It uses skills proven to be useful in simpler problems on harder problems.

Relative. Between bad and worse, they could learn the bad and generate less of the worse. Between good and better this system could generate more of the better and less of the good. Good and relate is defined as relative to each other, rather than being fed.



## Suggested actions

Ultimately, fine-tuning a large language model is about increasing the probability of generating good tokens and decreasing the probability of bad ones. The challenge is figuring out which tokens are good and which are bad - and this goodness is inherently relative to the group.

### Inspect your data thoroughly

Ultimately, you are increasing generation of the nice logits and decreasing the generation of the bad logits. You need to figure out which tokens are good and which tokens are bad. Good and bad is relative.

Please actually look at the data. WandB graphs does not suffice. You should invest in a nice dashboard that actually shows the data.

Look at the logits

Sample from the iteration and see how the logits has updated

Better reward attribution

Look at what are you rewarding



I should have studied 

This way if I need to try out a different training config I can just use ...?

I had some logic where I search for a good redaction length to start with.
This has caused much complexity.

There are times I did a 



I think certain parts of the algorithm should be simpler.

I have this logic where

I should have saved the training bits.


I should have conventional reinforcement methods to 


I think I might trying a new technique on a problem that is too hard.
Since I have .
Probably I should have tried solving ???



(Also include the path that I decided not to take and still agree with it.)

I spent a few weeks trying to ...

I do not believe that you can train a model to predict the whole output. You cannot just pass in a Sudoku. One cell to fill up yes, but you cannot solve the entire Sudoku. It does not make sense.

Chain of thought. The docstring is the chain of thought.




- You have prompt-completion pairs from the session. The completion is one turn taken by the model. The prompt is all the tokens before the completion.
- You get the model to generate multiple completions given the prompt.
- You have an evaluator that calculates the best completion given the prompt.
- You train on the best completion.
- Repeat.

The purpose of evaluation is to understand whether a model is performing well at a certain task. If the model is not performing at a certain task, effort should be input . Of course, measuring whether how well the model is performing is not that straightforward.

In SWE-bench, you can use the process provided by the benchmark to evaluate the model. If the model is asked to fixed a bug, 

Evaluation is different if you are looking at coding sessions and sandbox benchmarks. When looking at coding sessions, you will need to evaluate whether the response made by the agent is good.

This is how I expect frontier AI companies use coding sessions to evaluate their models. Assume they want to decide whether their newly trained model performs better than the model that is involved in the coding session.

One entry in the evaluation is one turn taken by the model.

Once you are able to evaluate, you can train. This is how I think training could be done

-

This is how validation could be done

- You have a held out set of sessions.
- You train the model to generate multiple completions given the prompt.
- You train the model to generate multiple completions given the prompt.


- They look at one turn taken by the model
- For each coding session they look 
- They run the same prompt against other

Of course, there is still value training in sandboxes.


There may be no right answers. But there are wrong answers. If the model is producing the wrong answer, we should train the model to produce the okay answers.

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



# Random comments (will classify)

I want to take the opportunity to share which papers I kept, and my thoughts on reading paper.

I have not written any real papers.

Authors want to get their work published.

You need to understand the motivation of the author

Academia is not that efficient. My estimate is that the industrial labs has more impact per unit spend. Of course, there are labs that create more impact than the others.

There is a parable where you visit a sensei, and your cup is full you cannot pour any more you need to empty your cup

Cite eugeneyan on something about learning.

Learning by doing?

You will be talking to chatbots and asking you what is new. It is like you are the prof and you have a graduate student that understands you well. People should publish their conversations with the paper.

Examples are important. I read the examples first before the abstract. Examples communicate taste the best.

What exactly the model did not say. Even papers contributing to the frontier of open source do not declare everything

Capture the author's intuitions.

Writing papers is performative. Reading papers is performative.

This is list not meant to be a list of papers which are better. It is just printouts that I decide to keep for now.

Good to review old papers to understand what people are thinking at that time.

I can't read without a pen.





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





https://hamel.dev/blog/posts/evals-faq/#q-how-do-i-choose-the-right-chunk-size-for-my-document-processing-tasks Agents work now. Agents know how to search for text. You no longer need the "naive vector database retrieval". Claude Code could read code and policies just with string search. Discussions on chunk size for embeddings is no longer relevant. Probably the discussion should be framed as a retrieval system. With the opportunity to do multiple retrieval, I do not think models need perfect search terms every time. What we should compare is the task performance and cost. If there is a simple task but the model is taking unnecessarily long time probably you should investigate.



---


AI models are better now. You can get AI models to brainstorm edge cases with you. (Is there mention similar to this?)

Some evals are now unnecessary with better models. You might want to have an evals on whether the model is querying with the correct search term, but this is not necessary anymore.