---
layout: post
title: My predictions for AI in 2025
categories: ai
---

We have already made superhuman systems in Chess and Go. The equivalent would be a model that is able to attain better than the average human 
This will be the first superhuman system that require human language. 






However, I don't think the effort spent on this  . In any case, I would expect this to be SSI.inc's first product.

This will be the first 


We still need to build the online judging platform for the AI.

Unlike training the superhuman competitive programmer, the AI will only be given access just enough information to understand what are competitive programming problems.

What is different here is that there will be no external resources.

This training process will involve inventing problems
- Invent problem
- Decide which problems are worth solving
- Generate the test cases
- Write a brute force solution
- There is a natural challenge of inventing problems. These are probably open problems. The AI agents within the system will attempt to improvement.


The AI may be given this algorithms as they are included in an introduction to algorithms.
- Euclidean algorithm
- Dijkstra algorithm


The AI system will need to invent all the [advanced algorithms](https://cp-algorithms.com/)
- Segment tree
- Red–black tree



This is what we will observe in the system
- Creating their own benchmark on what is a nice problem
- Cleaning up code 
- Building their own Wikipedia of knowledge
- Sharing sample code
- Debating on complexity
- Pointing out mistakes in solution by adding test cases


Note that the interactions are still controlled. The community doesn't build the judge, they just use it.


The result is a mini scientific community.

I believe that competitive programming is the first scientific community that we can meaningfully automate. We have solved Chess and Go, but their moves are limited. There are an exponential



This is for academic interest.
To prove the claim, you actually need to publish the pretraining dataset for public scrutiny. Even so that does not really change the conclusion, we do expect most of the knowledge is created in the selfplay output.

This is analoguous to AlphaZero. AlphaZero can be trained with pure sel

What is different here
- AlphaZero can use a random number generator. There are plays that a learned amateur will not make. AlphaZero will create their own puzzles and solve their own puzzle. Same for this



Code is the easiest real-world system that you can interact with. In the past we interacted with Physics simulators.



The AI will write their own Wikipedia on the learnings. There will be weak solvers and strong solvers and they can compare themselves on the leaderboard.



After showing that we are able to ship the  





The idea of competitive programming is to write a program that produces a certain output for a given input under time and memory constraints.


This will involve trivial manipulating problems (e.g. make an offline problem and online problem). The system will check itself with brute force code. The problem bank is already huge, I don't think it is necessary to invent completely new problems.





I predict an AI. If there are problems that could not be solved, it is because of the ambiguities of the problem statement writing, rather. AI should be able to take that feedback and fix it.

by the end of 2025, AI should be able to set a competitive programming contest.

I think this requires inventing problems and solving those.

Editorials, solutions, understand the merits, improve the train of thought.


By end of 2025, there should be an AI system that is able to solve all current and future competitive programming problems.


Given knowledge limited to the introduction to algorithm course, a rigorous definition of what are good programming problem, produce the superhuman competitive programmer.

This is more for demonstrating the ability for AI system to produce a non-trivial amounts on knowledge.

This would mean identifying competitive programming knowledge in the pretraining data and removing it. There are extra steps involved that do not translate to immediate performance.

AlphaGo was developed before AlphaZero. It makes sense show that AlphaGo works first.

This is narrow ASI that involves human language.

It will be interesting to see that the AI from the community versus AI trained with access to the hardest human problems.

When this is complete, we will see academic efforts to reproduce this - similar to Karpathy's training runs to produce GPT-2. However, this is bottlenecked by code execution.





I can claim that I have sent the dataset to the best prompt engineer in the world and this is their best performance. We can now decide whether to launch and move on. If we want to improve the prompts.

Instead of passing (prompt + input) to the model provider, I could pass pointer({training input, training label}) + input) to the model provider and the model provider retrieves the prompts.

Few shot examples serves as pointer({training input, training label})

If Anthropic wants me to use their model for production purposes, it would be great if they help us find a prompt that satisfies our purposes. Currently, I can talk to one of their friendly solution engineers where we offer a dataset and they help us find a prompt (but I am not too sure it is a really good use of their time).

It is not their job to tell us what makes sense to use LLM and what does not make sense to use LLMs.

Maybe o1 model can do this well?

It is in the incentive for the model provider to

This is the input I want to pass to the model provider

This is the output I want from the model provider.








I hope the prompting could make it to the post-training dataset of the most advanced models.


There are obvious things I want to automate. I do not want to change the text in the prompts anymore. When my job is classification, my job is classification. When my job is generation, my job is generation. As long as the job is done (without cheating), I do not care how the prompts are written.






I really hope this part of my job is automated away so I can focus on data and impart my tastes based on my interpretation the company's strategies.






- Sometimes I might just need to apply heuristics on the output
	- If the model provider uptime is bad, what should be the default judgment?
	- Are there some heuristics I can apply to improve the performance (if a certain word appears in the input).





Although I think I can go to an Anthropic solution engineer and ask them to help us save money, I don't think it is really in their interest.

There is space for a provider-agnostic prompt optimizer. When my job is classification, my job is classification. Of course, I would expect the . I will pay per outcome for the provider-agnostic prompt optimizer. This is equivalent to me posting the (not very sensitive) [data](https://github.com/tonghuikang/automatic-prompt-engineer/blob/master/qiqc_truncated.csv) on Fiverr and asking pay $5 for anyone who can come up with a prompt that achieve a better performance.

They should also include an analysis on whether how important is each few shot examples. Maybe I will pass unlabelled examples and it will flag to me which examples are likely very wrong.





There should be a product that only helps developers classify

Developers should have access to the prompts.

Serve the developers rather than the model providers

Outcome-based pricing here.


The optimizer can provide me options - for each model provider, what is the average cost per input - and it makes it easy for me to do the performance quality tradeoff. In my current workflow, I can only manage one model at a time.


Maybe fine-tuning BERT models is the most cost-efficient way to do classification. This could be an API served by the prompt optimizer.














## Generation and classification

All AI applications can be summarized into two uses
- Classification, where the output is one of countable set of labels
- Generation, where the output is a string of text




## Prompting techniques for non-reasoning models

I used to strongly argue that model should reason first, and make the judgment later. I no longer feel this way. I have multiple experiences where I could not beat the performance of a prompt provides their classification in the first token.

If your output looks like this, are you really doing chain-of-thought?

```
<reason>This content is acceptable. It's a (redacted). The content is (redacted), and doesn't fall into any of our low-quality categories. It's not (redacted). This type of content could lead to (redacted).</reason> <classification>Acceptable</classification>
```

Of course, in solving mathematical prompts, it is very important that reasoning happens before submitting your answer.

My view on prompting techniques - whatever that works. I don't care.





Gradient-based methods.

Just finetune a 200m parameter model instead (but serving calling a general purpose 8b model can be cheaper than keeping a 200m parameter model live)




## Outcome based prompting

Do not talk to me until either
- you have a prompt that can curve fit to my examples
- you ran out of money (then give me your best results)


You specify the outcomes
- I want to write a song that heavily references algorithms (subject to constraints)
- I want to create a boardgame about on AGI (has to include the OpenAI board drama, Chatbot Arena, etc)
- What is the role of intermediaries? Why don't you call O1-pro instead? Outcome-based pricing? When does the bidding happen?




## What I mean by prompting

I define what is meant by prompting - the activity to craft text so to achieve better performance at a repeatedly executed task.







## Tool use

There is a lot 

The underlying case is classification. Has the customer agreed to make the booking?



LLM providers should provide the code to write the tool use

I still don't know how to use tools

Writing Python code to solve problems is already tool use. It just happen that the training dataset has this format.

We expect a padagraaim. It is still easier and cheaper to serve general purpose models with their use cases defined with prompts.

Squeeze whatever you learnt from the tools within 100k tokens. Leave the remaining 32k tokens for generation.

100k input tokens, with the standard transformer architecture that we have, when cached isn't that expensive.





## We should no longer be writing any prompts

When you do classification, your job is classification

When you do generation, your job is generation

Few shot examples should serve a case law.

LLM providers should provide this.







## Benchmarks should accelerate the progress



## The path to superintelligence


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




It will take a lot of conscious effort and engineering to build the competitive programming supercommunity. It will take more time and inputs from mathematical experts to automate mathematics. We will get there, ultimately, we all live under the same laws of Physics.

#### Robotics

The first thing we need to have is a generic robotics model.

Robots that repair themselves, robots that improve their own models.




## AI should interpret my intentions

When I type a word into Google search, I am usually doing a spell check.

I only have time to write two words.

When I do a search on Google
- Retrieve who asked the quote
- 


Consider these Google search queries

```
Sutstker
ippudo
necessarily


```


## AI needs to be clear on who they serve

The salesperson wants to sell.

Who does the AI represent

We are okay with talking to people who do

Do I trust Google search who is trying to sell me ads

Humans need to build a model who to trust and who to not trust.






It will be slow, but we will get there. Ultimately, we live under the same laws of Physics.



I write my predictions regarding AI for the year 2025 and beyond.








# Recreating mathematical knowledge

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




# Verifier for mathematics

Unlike competitive programming, mathematics is not that verifiable.




# Only specific fields of math would be solved

AlphaGeometry requires

Now we have AI that is able 

There are certain tasks that can be solve
- Integration (MIT Integration Bee)
- Counting problems, and checking with computers

The effort to verify [issues in the mathematical proof](https://en.wikipedia.org/wiki/Brandolini%27s_law)

Not for code though


# Software engineering community

Unlike the competitive programming community. the community will need to build tools for themselves.

They will figure out what is cool. They will decide how much compute resources to allocate to run an experiment.




# General mathematical fields should remain unsolved

Pareleman's proof took years for, and require back-and-forth

Until we have a verifier that is able - even show gaps in proof of published human work, then we can trust the proof written by AI

Verifiable tasks maybe? Prime factorization?




# Experimental scientific fields should remain unsolved

We are only interested in the science that is verifiable and falsifiable.

Particle Physics

Biology

Automated experiments

Science is falsifiable. No comment on philiosohpy. I don't understand the appeal of Freud.

Think of experiments that can be proven within a classroom-sized laboratory. This should be automated.

Again you need good taste on what ideas is worth persuing. Unlike running code, the cost of interacting with the real world costs much more time and money.

Solve all the trivial problems. Automate the verifications - similar to running a docker container, you ship a container-sized container lab that shows how to reproduce your work.

Scientific equipments?




# Any work that can be verified should be automated

It is all about connecting the APIs and training to connect the APIs

Fixing the lint errors in the code base.

Writing a prompt that fits the prompt.

Writing documentation that could be followed. Poe server bot documentation is bad.



# Any work that you can call someone to do can be done satisfactorily

Fiverr but for five hour or five day tasks. I think this is what Sierra is doing - outcome based pricing.

Maybe we will have a bidding market.




# Work that require context and not verifiable is still done by humans

Improving recommendation systems.

This will eventually be automated - this is the point where people should agree it is AGI.




# Robotics is about connecting the APIs

I think we have the ingredients to solve the problem.

Whether the table is clean can be verified

This is now about execution

Robotics needs to be solved first before we automate experimental science.




# General robotics model

Given any sensors, it can quickly learn its sensor

The learnings on how to use sensors will be added to their prompts

It is still a pain to set up hardward and I swore off hardware.





# Communication

Sonnet is preferred because it somehow communicates better.

For general purpose models, it is important to write where the output will be displayed.




# Consumer fine-tuning

I don't think this is a huge trend.




# Products

Serious LLM providers should have their own products so that they can iterate

Products that serve the interests of the user, and only the interests of the user

AI agents

You go talk to your AI talk to my AI talk to me.




# We live under the same laws of Physics

There are things

There are things that 




# Everything is next token prediction

What is not next-token - image.

Probably an image can be composed of tokens?

The stroke of the paint brush is a set of tokens. Executing a flood fill is a set of tokens. Retriving an image . I don't think image output is necessary, but it does help.

Image input is tokens?

Tokens are clear and interpretable. If we want to move away it is more for inference speed reasons. Frontier research should still use tokens.




# Live output

This is an API implementation problem. The new inputs is just completion but by the environment.

Do you need a million tokens?

Tokenizers - I think they are fine.




# The transformer architecture should be sufficient

TBC

If someone wants to come up with a new architecture, sure, they will need to prove themselves.

Some ideas
- Jagged attention - the full attention matrix within each sources, KV search still happens across 1 million sized context. Not too sure how the positional embeddings will be affected







# Conclusion

This is magic, but it needs to be carefully planned.

I think we have a better idea of what is needed.

Everything will change?







For example I want to classify whether a piece of content has adult themes.

I need to think 
- Is content asking about puberty considered having adult themes?
- Is commentary on war considered adult themes?

Even though the edge cases are not heavily represented in the impression sample, it can change the product over time. 

, then there is a lack of war related content and people stop writing about war and move elsewhere.

After thinking through edge cases. Maybe for most of these categories. Maybe for some of these cases it is very obvious to the human but LLM fails at this.

Even though edge cases are not represented well . 

On why should you care about edge cases.


- Edge cases - for an aligned human it is clear what the classification should be, but might be challenging for LLMs
- Case in point - promotional filter on content with great citations
- It is possible that these edge cases has outsized impact on the system. Promotional content and citations
- When you write your examinations
- When you iterate your prompts, you expand this dataset.
- How big is the dataset? How many questions do you have in your college admission examinations? The math you use at work may be repetitive and mundane, but the college admission examinations should be comprehensive and intentional.
- Maybe the math you need to use in college is to calculate your GPA. But that does mean college admissions tests should only test addition and division.
- If you ask your AI to do topic classification does it refuse to tag topics to adult content?

In your testing set, you should include a 

- You face the beginner error of using accuracy as a metric on a very unbalanced dataset.
- My recommendation is an impression sampled dataset and an edge case dataset.
- Maybe you sample questions by impressions
- This is meant for illustration
- average user experience is your performance at work. could answer math phd questions but don’t know how to do addition and you do addition for work


- Impression-sampled example
- Edge-case focused example - maybe from your experience with the product, from mistakes from another system (e.g. maybe 20% of feed-impressioned sampled content is promotional, and 0.1% of feed-impressioned sampled is very high quality and contains correct in-text citation, and it is very bad if we penalize the high quality content without knowing)
    - Example - promotional prompt
- ???



Should I talk about both classification and generation? I think I should just focus on classification.

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



The employee cannot deliver value if you cannot communicate with them. The same principle applies to AI.

You cannot expect autoregressive LLMs to provide the correct integer answer to a math problem in the first few tokens. However, users may want to see the answer in the first line.

Equivalent to scoring well on standardized examinations, doing well on in the chatbot arena does not mean you are a better communicator. The things to optimize for if you want to do well in the chatbot arena is not the same things to optimize for if you want to be the go-to chatbot for your queries.

I imagine in the chatbot arena having wrong guesses is better than . However, 

Why Sonnet is sticky

Doing well 

I expect generic model providers to be aware their their content will be displayed. If you want to optimize for vanity metrics on the LM arena leaderboard, you want to display. If you want to respond in voice, you 

The first product prototype I am aware of is Khan Academy. o1 is the first model that explicit trained to do this.

The difference between a good engineer and a great engineer is how they communicate. Communication is not just words. It involves awareness, reflecting, and preparations.

When I do Google search, I still don't read their AI generated summaries. I will ask AI directly for this. I want to read the ground truth, the texts from the horses mouth along with the stamp of approval by the masses. 