---
layout: post
title: Ease of describing vs Ease of grading
---
The tasks we assign to humans can be classified into this two-by-two matrix. I explain the classification.

|                               | Easy to grade                              | Difficult to grade                     |
| ----------------------------- | ------------------------------------------ | -------------------------------------- |
| **Easy to <br>describe**      | Competitive programming                    | Writing an A-level General Paper essay |
| **Difficult to <br>describe** | Implementing a button on the Quora website | Improve Quora recommendation systems   |


# Ease of describing

This is concerned with the input - is it easy to provide all the information necessary to complete the task?

## Characteristics that make it easy to describe

### All information is provided in the input

Note that it is not required to fit all the input into some LLM context length.

I consider a Q&A task with the entire Wikipedia to be easy to describe.


### The longer the input the more difficult to describe the task is

You can say that you provide a static copy of the entire Internet and say that "all information is provided in the input" and the task is easy to describe.
However, I would say that replacing the input with from the entire Wikipedia to the entire Internet will make it hard to describe.
With more input there will be more conflicting information (and then?)
There are sites that you trust more than the others, and there are sites that are parodies and with unreliable information. (elaborate more?)


### The input does not contain implicit information

There is a lot of organizational knowledge involved. If you want to implement a button on Quora that does a certain functionality (i.e. send requests to answer to authors) there is a lot of context behind this implementation. There are design standards. You need to implement sensible logging. You don't just edit the HTML and a button appears, it has to work and it has to look nice in many places. Maybe the change is just 50 lines of code, but there is a lot of context involved. This is not easy to describe.

You have to make assumptions about decisions made in the past, and check whether the assumptions are valid. There will be documents that are inconsistent with each other. You will also need to make decisions to follow - for example in the product there are two button styles you need to decide which style to use, and usually one is more correct than the other.

The interface is complicated. In math you just write your answer on a piece of paper. For software engineering, you need to interact with the system and make multiple changes and test the changes. You get more inputs as you test the changes. And you don't have free access to the system (i.e. Quora development servers).


### The outcome requested is unambiguous

This does not mean whether the outcome is easily graded.

In software engineering, the outcome may not be to write a commit.
If you want AI to function like a software engineer, the correct outcome may be to point out that there is a bug in the code that makes it meaningless to write the commit.


### If the AI requires to interact with the environment, the interactions with the environment are simple and predictable

What I describe as interaction - something that you could not predict. Walking up the stairs is an interaction with the environment, but it is predictable.
Is opening a door predictable?

It is still possible for me to consider a task easy to describe even though it requires an interaction with the environment.

I imagine another version of ARC-AGI where you are allowed to ask one clarification before receiving the test question.
(When I give interviews, I often ask the candidate to give me an example input and then I give them an output. However, they rarely do.)

Is playing a video game easy to describe? Claude Plays Pokemon with the goal of defeating Elite Four.

It depends on the objective. In software engineering you don't just ship a commit.

Interactions difficult to describe - you need to talk to another engineer whose capabilities and motivations are unknown.


## Common misconceptions

There are tasks that are easy to describe but very difficult for humans to complete without access to AI.

Note that this does not indicate how difficult the task is. There are tasks that are easy to describe but very hard even for the best human experts:
- There are very hard competitive programming problems that can be described in as little as one line, but they have solutions. You can find these problems in AtCoder Grand Contest, or in the final problems of Div 1 Codeforces round.
- Mathematical contest problems - [Putnam Competition](https://en.wikipedia.org/wiki/William_Lowell_Putnam_Mathematical_Competition) problems can each be described with a small section of paper, but require deep mathematical insight to solve.


Building a benchmark by simplifying tasks may make the benchmark less meaningful.


## Discussion on certain examples

Debatable examples:

Kaggle competitions. Even though all Kaggle competitions have a problem statement, this doesn't mean that all the data you need to do well at a Kaggle competition is self-contained. In some competitions, you need to compile your own external data to gain an advantage. This depends on the competition. (explain?)

Writing A-level General Paper essay. A good essay should be recognized as good in most marking rubrics. The knowledge needed to write an A-level General Paper could be derived from events that happened yesterday. However, there are hidden rules in the essay. However, overall, it is still easier to describe than many other tasks.

Open mathematical problems. I don't understand what the Riemann Hypothesis fully entails. Unlike competitive programming problems, to even understand what the Riemann Hypothesis is about requires years of mathematical foundation. You need to read extensively. Some mathematical understanding may be unwritten as well.

It is not just about the problem itself:
- Prove any weaker results along the way
- Clearly explain how and why it overcomes the barriers that foiled previous attempts
- https://scottaaronson.blog/?p=458 
Even though open mathematical problems can be one line long, they require enormous context.


## The current state

- Companies have already experimented with offshoring work easy to describe
- OpenAI Deep Research
- Soon we will use AI to do all the work that is easy to explain
- If it takes more effort to get others to do it, I will still rather do it myself


# Ease of grading

Even though there are benchmarks, it does not mean that a task is easy to grade.


## Characteristics that make it easy to grade

### There are only a few things to grade

Qualified humans are consistent at grading the tasks.

### Humans are consistent at grading

If the answer is correct, it is correct for everyone evaluating it.


## Common misconceptions

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


## Discussion on certain examples

Kaggle competitions. Kaggle competitions are by definition easy to grade - you only look at the private leaderboard score. You are free to do whatever that is legal and you can pay for to get the best private leaderboard score.
You might notice that I just argued that treating a benchmark as ground truth does not necessarily make the underlying human task easy to grade.
But the underlying task here is the Kaggle competition itself.
This might mean the results from the solutions in Kaggle competitions are not meaningful, but that is an issue with the formulation of the Kaggle competition, rather than the formulation of the benchmark.

The biggest open mathematical problems. It took the mathematical community several years, with several corrections from Perelman, to verify his solution to the Poincaré conjecture. It will be a long time before we see AI solving one of these major problems.

Identifying an error in a mathematical proof. I think this is easy to grade - either an error is identified or the error is not identified. This becomes more difficult if there are multiple errors in the proof.
Before we see an AI solving all the IMO problems, we might first need a good classifier to assign scores, and we can check how much it matches the historical IMO scores.

Writing an A-level General Paper essay. This is difficult to grade consistently. But this doesn't mean that the grading is good. You might end up reward hacking the LLM.


## The difference between describing and grading

The ease of describing deals with the input. The ease of grading deals with the output.

Why do we care about the difference?

Generally, we want to be more aware of the inputs and outputs.
When you design a benchmark to measure a human task meaningfully, you need to be aware of the limitations - and whether the limitations deal with the inputs or the outputs.

When you improve your AI on a benchmark, you need to understand whether you are really improving the AI in the correct direction.

When you choose which AI to adopt, you might look at benchmarks. You need to understand what the benchmarks actually mean.


## AGI: easy to describe and easy to grade

It is possible that we discover a task that is easy to describe and easy to grade that AGI fails at.

For a system to be considered AGI, I expect AGI to be able to solve all tasks 

Until we have achieved AGI, there will likely be such tasks remaining.


## The current state of AI

As of early 2025, this is the current state of AI.

|                                   | Easy to grade                                                                      | Difficult to grade                                                                                                   |
| --------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Easy to <br>describe**          | Better than the average professional, soon to be solved at a superhuman level      | AI can provide an acceptable response, but you can do it much better. You need to think of how to grade AI responses |
| **Difficult to <br>describe**<br> | You rather do this yourself, or break it down into tasks that are easy to describe | You need to make it easy to describe and verify for AI to be useful                                                  |

However, there are still plenty of tasks easy to describe and easy to grade but are not fully solved by AI. I list some of these tasks, and I predict and expect huge progress to be made soon, if not already.