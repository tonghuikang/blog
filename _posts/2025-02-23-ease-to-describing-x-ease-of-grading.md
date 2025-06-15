---
layout: post
title: Ease of describing vs Ease of grading
---
The tasks we assign to humans can be classified into this two-by-two matrix. I explain the classification.

|  | Easy to grade | Difficult to grade |
| - | ------------- | ------------------ |
| **Easy to <br>describe** | Competitive programming | Writing an A-level General Paper essay |
| **Difficult to <br>describe** | Implementing a button on the Quora website | Improve Quora recommendation systems |

I will share my judgment and explanation on whether the tasks are easy to describe and grade.


# Ease of describing

This is concerned with the input - is it easy to provide all the information necessary to complete the task?

Competitive programming. This is easy to describe. Note that even if the task is very difficult for the average human, it is still easy to describe.

Playing Pokemon. If you specify the objective - for example defeating the Elite Four and the Champion - the task becomes easy to describe.

Searching a static copy of Wikipedia to answer a factual question. If the questions are well-formed, I think this task is easy to describe.
However, I don't think searching a static copy of Internet to answer a factual question is a easy to describe task.
There are sites with information that contradicts each other, there is information on the Internet that is unreliable or even intended to be false.

Writing a commit to fix a reproducible bug. I think this task is easy to describe.
It is possible for AI (and humans) to write bad code to monkeypatch a bug, if you require AI to not do this, the task becomes difficult to describe.
In general, if you expect AI to do something more instead of just writing a commit, the task becomes difficult to describe.

Implementing a button on an existing software product. I think this task is difficult to describe. There is a lot of organizational knowledge involved.
If you want to implement a button on Quora that does a certain functionality (i.e. send requests to answer to authors) there is a lot of context behind this implementation.
There are design standards. You need to implement sensible logging. You don't just edit the HTML and a button appears, it has to work and it has to look nice in many places.
Maybe the change is just 50 lines of code, but there is a lot of context involved. This is not easy to describe. [^1]

[^1]: [June 2025 update] I think now the problem is easy to describe if you could allow AI to access your codebase, access your design documents, and manipulate your browser.

Kaggle competitions. For Kaggle competition beyond the tutorial competitions (e.g. Titanic dataset), I would argue that Kaggle competitions are hard to describe.
Even though all Kaggle competitions have a problem statement, this doesn't mean that all the data you need to do well at a Kaggle competition is self-contained. In most competitions, you need to compile your own external data to gain an advantage. This depends on the competition.

Writing an A-level General Paper essay. A good essay should be recognized as good in most marking rubrics. The knowledge needed to write an A-level General Paper could be derived from events that happened yesterday. However, there are hidden rules in the essay. However, overall, it is still easier to describe than many other tasks.

Proving the biggest open mathematical problems. Unlike competitive programming problems, years of mathematical foundation is required to even understand what the Riemann Hypothesis is about. You need to read extensively. Some mathematical understanding may be unwritten as well. It is not just about the problem itself, you need to prove weaker results along the way, you need to clearly explain how and why it overcomes the barriers that foiled previous attempts. Even though open mathematical problems can be one line long, [they have enormous context](https://scottaaronson.blog/?p=458).


# Ease of grading

This is concerned with the output - are we able to grade the task consistently and meaningfully?

Competitive programming. This is easy to grade. We have been grading this automatically.

Playing Pokemon. If you specify the objective - for example defeating the Elite Four and the Champion - the task becomes easy to grade as well.

Minecraft. However, if you give AI access to Minecraft and ask them to "build something great", or build "a church for themselves" the task is not easy to grade.
It is easier to grade if you ask AI to replicate a certain object in Minecraft.

Kaggle competitions. Kaggle competitions are by definition easy to grade - you only look at the private leaderboard score. You are free to do whatever that is legal and you can pay for to get the best private leaderboard score.
You might notice that I just argued that treating a benchmark as ground truth does not necessarily make the underlying human task easy to grade.
But the underlying task here is the Kaggle competition itself.
This might mean the results from the solutions in Kaggle competitions are not meaningful, but that is an issue with the formulation of the Kaggle competition, rather than the formulation of the benchmark.

IMO problems, with a rubric.
As long as human judges mostly agree the score (0 to 7) that should be awarded to a solution, I think IMO problems are easy to grade.
However, I would expect the rubric to be updated based on the solutions.
For example we expect a problem to be proved in a certain way, and the rubric has defined points awarded for certain steps.
However, if a contestant attempts to prove a problem in another way, and the rubric has not defined points for certain steps. There could be multiple reasonable ways to update the rubric.
Before we see an AI solving all the IMO problems, we might first need a good classifier to assign scores, and we can check how much it matches the historical IMO scores.

Writing an A-level General Paper essay. This is difficult to grade consistently. But this doesn't mean that the grading is bad. You might end up reward hacking the LLM.

The biggest open mathematical problems. This is difficult to grade. It took the mathematical community several years, with several corrections from Perelman, to verify his solution to the Poincaré conjecture. It will be a long time before we see AI solving one of these major problems.


## The difference between describing and grading

The ease of describing deals with the input. The ease of grading deals with the output.

Why do we care about the difference?

Generally, we want to be more aware of the inputs and outputs.
When you design a benchmark to measure a human task meaningfully, you need to be aware of the limitations - and whether the limitations deal with the inputs or the outputs.

When you improve your AI on a benchmark, you need to understand whether you are really improving the AI in the correct direction.

When you choose which AI to adopt, you might look at benchmarks. You need to understand what the benchmarks actually mean.


## AGI: easy to describe and easy to grade

For a system to be declared AGI, I expect AGI to be able to solve all existing tasks that are easy to describe and grade.

It is possible that we discover a task that is easy to describe and easy to grade that AGI fails at.
Even after a system to be declared AGI, it is still possible to discover tasks easy to describe and grade the system is bad at.
I would expect the system to be easily updated to solve the discovered task.


## The current state of AI

As of early 2025, this is the current state of AI.

|                                   | Easy to grade                                                                      | Difficult to grade                                                                                                   |
| --------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Easy to <br>describe**          | Better than the average professional, soon to be solved at a superhuman level      | AI can provide an acceptable response, but you can do it much better. You need to think of how to grade AI responses |
| **Difficult to <br>describe**<br> | You rather do this yourself, or break it down into tasks that are easy to describe | You need to make it easy to describe and verify for AI to be useful                                                  |

However, there are still plenty of tasks easy to describe and easy to grade but are not fully solved by AI (competitive programming, for example). I predict and expect huge progress to be made soon, if not already.