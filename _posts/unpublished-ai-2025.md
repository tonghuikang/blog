---
layout: post
title: My predictions for AI in 2025
categories: ai
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






