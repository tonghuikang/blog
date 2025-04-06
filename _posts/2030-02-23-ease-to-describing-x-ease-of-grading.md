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

This is concerned with the input - it is easy to provide all the information necessary to complete the task?

## Characteristics that make it easy to describe

### All information is provided in the input

Note that it is not required to fit all the input into some LLM context length.

I consider a Q&A task with the entire Wikipedia to be easy to describe.


### The longer the input the more difficult to describe the task is

You can satisify the criteria by stuffing a static copy of the entire Internet.
Even though I say that having the entire Wikipedia as a source is a task easy to describe, the entire Internet not necessarily is.
There are sites that you trust more than the others, and there are sites are parodies and with unreliable information. 


### The input does not contain explict information

There is a lot of organization knowledge involved. If you want to implement a button on Quora that does a certain functionality (i.e. send requests to answer to authors) there is a lot of context behind this implementation. There are design standards. You need to implement sensible logging. You don't just edit the HTML and a button appears, it has to work and it has to look nice in many places. Maybe the change is just 50 lines of code, but there is a lot of context involved. This is not easy to describe.
- You have to make assumptions of the decisions made in the past, and check whether the assumptions are valid. There will be documents that are inconsistent with each other. You will also need to make decision to follow - for example in the product there are two button styles you need to decide which style is to use, and usually one is more correct than the other.

The interface is complicated. In math you just write your answer on a piece of paper. For software engineering, you need to interact with the system and make multiple changes and test the changes. You get more inputs as you test the changes. And you don't have free access to the system, (i.e. Quora development servers).


### The outcome requested is unambiguous

This does not mean whether the outcome is easily graded.

In software engineering, the outcome may not be to write a commit.
If you want to AI to function like a software engineer, the correct outcome may be to point out that there is a bug in the code that makes it meaningless to write the commit.

(what other examples?)


### The interactions with the environment, if easy, are simple

What I describe as interaction - something that you could not predict. Walking up the stairs is an interaction with the environment, but it is predictable.
Is opening a door predictable?

It is still possible for me to consider a task easy to describe even though it requires an interaction with the environment.

I imagine another version or ARC-AGI where you are allowed to ask one clarification before receiving the test question.
(When I give interviews, I often ask the candidate to give me an example input and then I give them an output. However, they rarely do.)

Is playing a video game easy to describe? Claude Plays Pokemon with the goal of defeating Elite Four.

It depends on the objective? In software engineering you don't just ship a commit.

Interactions difficult to describe - you need to talk to another engineer whose capabilities and motivations are unknown.


## Common misconceptions

There are tasks that are easy to describe but very difficult for humans to complete without access to AI

Note that this does not indicate the difficulty the task is. There are tasks that are easy to describe but very hard even for the best human experts
- There are very hard competitive programming problems that can described as little as one line, but they have solutions. You can find these problems in AtCoder Grand Contest, or in the final problems of Div 1 Codeforces round.
- Mathematical contest problem - [Putnam Competition](https://en.wikipedia.org/wiki/William_Lowell_Putnam_Mathematical_Competition) each problem can be described with a small section of the paper, but 


## Discussion on certain examples


Debatable examples

Kaggle competitions. Even though all Kaggle competitions have a problem statement, this doesn't mean that the all the data you need to do well at a Kaggle competition is self-contained. In some competitions, you need to compile your own external data to gain an advantage. This depends on the competition.


Writing A-level General Paper essay. A good essay should be recognized as good in most marking rubrics. The knowledge needed to write an A-level General Paper could be derived from events that has happened yesterday. However, there are hidden rules in the essay. However, overall, it is still easier 


Open mathematical problems. I don't understand what the Rienmann . Unlike competitive programming problems, to even understand what the Riemann Hypothesis is about requires years of mathemtical foundation. You need to read. Some mathematical understanding may be unwritten as well.

It is not just about the problem itself. 
- prove any weaker results along the way
- clearly explaining how and why it overcomes the barriers that foiled previous attempts
- https://scottaaronson.blog/?p=458 
Even though open mathematical problems can be one line long, 


## The current state

- Companies have already experimented with offshoring work easy to describe
- OpenAI Deep Research
- Soon we will use AI to do all the work that is easy to explain
- If it takes more effort to get others to do I will still rather do it myself


# Ease of grading

Even though there is benchmarks, it does not mean that it is easy to grade.


## Characteristics that make it easy to grade

(explain)


### There are only a few things to grade

Qualified humans are consistent at grading the tasks

### Humans are consistent at grading

If the answer is correct it is correct


## Common misconceptions

Whether is it easy to grade does not depend on how difficult the task is.
Similar to the competitive programming problems etc.

Benchmarks do not capture everything.
There are some human activity.
Passing the benchmark does not mean that it is good???
There are tasks when you make it easy to grade it becomes meaningless to grade.


Treating a benchmark a ground truth does not necessarily make the underlying human task easy to grade.
Let's say whether you want grade an AI-generated Supreme Court judgement by passing it into a LLM that produces a score between 0 and 1 and treat that as ground truth.
The AI system that produces the highest scoring Supreme Court judgement may still be very bad.

The AI may be using the wrong methods to arrive at the correct output.
Maybe you can train an LLM to guess the answer or skip certain steps in the calculation. They get the reward, their answer is correct, but their process is not correct. Maybe more applicable for MCQ questions.

Scoring well at MMLU does not necessarily mean that it is more pleasant to talk the the AI.


## Discussion on certain examples


Kaggle competitions. Kaggle competitions are by definitions easy to grade, you only look at the private leaderboard score. You are free to do whatever that is legal and you can pay for to get the best private leaderboard score.
You might notice that I just argued that treating a benchmark a ground truth does not necessarily make the underlying human task easy to grade.
But the underlying task here is the Kaggle competition.
This might mean the result from the solutions in Kaggle competitions are not meaningful, but that is it the issue of the formulation of the Kaggle competition, rather than the formulation of the benchmark.

The biggest open mathematical problems. It took the mathematical community several years, also with several corrections from the Perelman. It will be plenty of time we see AI solving one of the problems for example.

Identifying an error in a mathematical proof. I think this is easy to grade - either an error is identified or the error is not identified. This is more difficult if there are more errors in the proof.
Before we see an AI solving all the IMO problems, we might first need a good classifier to assign score, and we can check how much it matches the historical IMO scores.

Writing A level General Paper essay. Then this is easy to grade. But this doesn't mean that the grading is good. You will be reward hacking the LLM.



## The difference between describing and grading


The ease of describing deals with the input. The ease of grading deals with the output.


Why do we care about the difference?

Generally we want to be more aware of your inputs and outputs.
When you design a benchmark measure a human task meaningfully? You need to be aware of the limitations - and whether the limitations deal with the inputs and outputs.

When you improve your AI on a benchmark, you need to understand whether are you really improving the AI in a correct direction.

When you choose the AI to adopt, you might look at benchmarks. You need to understand whether the benchmark mean what they mean.


## AGI easy to describe and easy to grade

It is possible that we discover a task that is easy to describe and easy to grade that AGI fails at.

Until we have not achieved


## The current state of AI

As of early 2025, this is the current state of AI.

|                                   | Easy to grade                                                                      | Difficult to grade                                                                                                   |
| --------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Easy to <br>describe**          | Better than the average professional, soon to be solved at a superhuman level      | AI can provide an acceptable response, but you can do it much better. You need to think of how to grade AI responses |
| **Difficult to <br>describe**<br> | You rather do this yourself, or break it down into tasks that are easy to describe | You need to make it easy to describe and verify for AI to be useful                                                  |

However, there are still plenty of tasks easy to describe easy to grade but are not fully solved by AI. I list some of these tasks, and I predict and expect huge progress to be made soon, if not already.





