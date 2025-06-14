---
layout: post
title: We should scale eval
---
We should evaluate on everything. This is where to find what to evaluate on.

## Product complaints

- https://x.com/chipro/status/1933905211308835092






## Product usage (add footnote instead)


I do not know what privacy practices do frontier companies have.

Is 

- Anthropic Clio https://www.anthropic.com/research/clio




## Feedback

ChatGPT left-and-right comparison

If you want to train




## Textbooks

Reading the textbook - do the exercises (cite example), do the homework

If you want to train on a textbook, traditionally serialize the textbook into a stream of text and train the model to predict the next word in the textbook. You can do more with this.



## Forums

If you want to train on forum, traditionally serialize the forum into a stream of text and train the model to predict the next word in the forum. You can do more with this.




## Benchmarks

LMSys


If you want to train on forum, traditionally serialize the forum into a stream of text and train the model to predict the next word in the forum. You can do more with this.

LMSys







Notes
- Training on my data takes a different meaning





These are the existing axes of scaling

- Data (Amount of information used for pretraining, amount of information used for post-training)
- Model (Larger models with more parameters)
- Output (Getting the model to generate more outpu)


## Find evaluation ideas from everywhere

People using your product. Get permission, somehow. This is why frontier labs are building products.

Published complains about chatbot products that might not be yours

Reading the textbook - do the exercises (cite example)

Forum replies - whether you understand the references (cite example)

An alternate solution to a Codeforces problem (cite example)

Benchmarks - LMSys. I suspect the Gemini team is closely monitoring the LMsys arena





## Make everything a benchmark

If the model could not figure out a joke - add it into a benchmark

If the model fails at simple math - add it to a benchmark

The size should be as big as Wikipedia




## Now you can evaluate on everything

It is okay to not perform perfectly in every benchmark. The first step to improvement is awareness.

I think there are some things that LLMs should not be training on. (Sam Altman the perfect AI is a small model that has lots of context)






Principles
- Proactively find failure cases. Reported cases in the wild, reported cases from competitor's products. Ask for feedback from users. Fin
- All failure cases should have an eval. N+1 evaluation.
- Train the model on these evals. Before release, evaluate the improved model on these evals.




## What is meant by scaling evaluation

Within evaluation, there are multiple ways to scale


Diversity of evaluation tasks
- LMsys. I suspect the Gemini team is closely monitoring the LMsys arena
- You want to evaluate the model on all possible use cases



Duration of evaluation tasks
- You want your models not just solve 5-second problems, or just 5-minute problems, but 5-hour problems or even 5-year problems. Your evaluation should also test whether the models can solve tasks that require a long time to solve.



Analysis of response
- Given a response - how could the response be better? Given two responses, which response is better?
- The OpenAI model spec has a pretty comprehensive specification on how to choose one response over the other.
- You want increase the length of the instructions to cover all possible corner cases.
- For each entry in the specification, I would expect at least 100 test cases constructed to test a model before release. There are probably even more test cases.



Analysis of process
- There are generated tokens by the model that are not shown to the user (what is shown is considered the response). The process could include thinking and use of tools such as web search. You also want to analyze the process.
- Even though the response may be exactly the same, the process matters.
- For solving math problems, you do not want the model to be repeating irrelevant thought processes. You also do not want the model to be cheating. You want to inspect the process.
- For use of web search tools, you want to ensure that the search terms are efficient.
- I would expect a model spec on the process, even if it not intended to be shown to the user.
- You do not want to solve a task. You want to solve a task with multiple different ways. To consider mastery on the mathematical problem, you want to be able to solve the math problem in all the multiple ways. You want to analyze whether each step in solving the math problem.




Analysis of training
- If a model could not perform at a task, could you explain why? If a model could indeed perform at a task, could you explain why? What changes in the pre-training or post-training is needed to ensure that the model is able to solve the problem?



Correctness standard of tasks
- Duration of tasks
	- You want to collect tasks that happen on a longer horizon
- Comparison of results
	- Is one response better than the other?
	- What is the rulebook?
- Debugging of performance
	- You want to understand what 



## Evaluation results can be used for post-training

Training on test set?


- Collecting tasks
- This also means building longer tasks.
- Taking snapshots of tasks
	- You want the model to be able to predict whether a step is correct
- Spotting obvious mistakes
- And automating all these


Should you outsource?


When we spot an AI or a human failing at a task in the wild, we want to collect this task to build our evaluation.






## AI can help to scale evaluation


Before we release the model, we do want to test



Constitution

- The human legal system has the following structure - constitution, legislation, case law - in this decreasing order of precedence.
- You can amend the constitution or enact legislation.
- A constitution needs to be interpreted. Legislation. When legislation conflicts with the constitution, .



--- 

## You should be able to reason and cite why one response 

TBC


## Compute cost is the downside to scaling eval

You want to be careful what you train the model with - in pretraining and posttraining.



## You can evaluate on everything though you don't need

I don't think this is a capability we require the model to have. I don't think we should train the model to memorize all the street names of the world.



## AI will build the eval system

I would expect the evaluation rulebook to be larger than the legal literature, and larger than Wikipedia.

To determine whether one response is better than the other, you may need to do retrieval.







How is scaling eval different from scaling posttraining

- Not very different?
- You can evaluate everything
- You would not posttrain on everything

We want to document 

Given two responses, you could describe which one is better

Monitor the leaderboard

Have your own standards

You want a system where
- that describes how it would have responded
- that evaluates its own responses
- even before you are ware

When you read a piece of work, evaluate whether could you have done it


Search and learning - you need to search what you are bad at


User feedback is a form of eval, not the eval.



## Random

Scaling posttraining versus scaling eval - eval tells you the direction you should improve your performance

