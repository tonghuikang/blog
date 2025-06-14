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
