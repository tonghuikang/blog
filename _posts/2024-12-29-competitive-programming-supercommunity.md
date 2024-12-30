---
layout: post
title: My predictions for AI in 2025
categories: ai
---
The competitive programming community would be the first scientific community that we will automate.


# Superhuman competitive programmer by mid-2025

By mid-2025, there will be an AI system that is able to solve all current and future competitive programming problems.

These are the specifications of the set up
- The AI system will only be allowed one submission attempt.
- The AI system is allowed access to the code interpreter.
- The AI system is not allowed Internet access.
- The AI system is allowed access to lots of compute, but has to submit their answer within the human contest time limit.

There are likely some problems where the AI system fails, but that will be the fault of the [problem statement](https://x.com/giffmana/status/1870589383562477880) rather than the AI system.

This is my prediction how this is done
- Get access to all the competitive programming problems available in the world, along with their full test cases, and some correct submissions, and editorials.
- Improve the current reasoning models with reinforcement fine-tuning. This is my [speculation](https://www.quora.com/How-do-you-think-reinforcement-fine-tuning-was-implemented/answer/Tong-Hui-Kang-1) on how reinforcement fine-tuning was implemented.
- There will be problems that could not be solved. External resources (editorial, reference code, failing test case example) will be used to guide the chain of thought.
- Repeat until success.

I believe OpenAI already has the ingredients to solve this.




# Competitive programming supercommunity by mid-2026

By the middle of 2026, there will be an AI system trained from scratch that is able to solve all current and future competitive programming problems.


In AlphaZero, the training system is only given the rules of Go. In the supercommunity, the training system is only allowed knowledge up to what is covered in the course to the introduction to algorithms.


This is how I expect this to be done
- Start by solving the simplest problem
- Maintain a [leaderboard](https://judge.yosupo.jp/) of best solutions to equivalent problems
	- The leaderboard is updated when a significantly better solution is achieved
- Maintain a [Wikipedia](https://cp-algorithms.com/) of algorithms
	- When an algorithm is [invented](https://www.quora.com/What-are-some-algorithms-that-were-invented-due-to-competitive-programming/answer/Brian-Bi), the Wikipedia is updated
- Models learn from the created knowledge and attempt to solve harder problems.
- Harder problems are invented.
	- Valid test cases are invented with the problems.
	- Brute force code is written to rigorously check for correctness in small cases.
	- Inefficient algorithms are used to check more efficient algorithms.
	- Models might point out mistakes in the problem statements.
	- Models might point out mistakes in currently accepted solutions with edge cases.
- Repeat until success.


Note that these still require human input (but only at the start)
- Initial reasoning model (without knowledge of advanced algorithm).
- The roles each of the models is doing (problem solver, librarian, problem setter, problem checker, solution checker).
- The systems that the models interact with (submission platform, problem setting platform, solution, solution leaderboard, algorithm library)
- How are the models expect to respond to interact with these systems.
- The algorithms to improve the model (i.e. how reinforcement fine-tuning is implemented).
- Rigorous instructions on what is an interesting competitive programming problem.
- Rigorous instructions of what is considered progress in solutions.


The supercommunity will need to work on problems that they don't have knowledge that whether could it be solved. They do not have access to external resources (editorial, reference code, failing test case example). They need to create the resources themselves. I believe this is possible with the existing LLM architecture.


I expect the following challenges for such a system, which I don't think are insurmountable
- The community may not have a good taste on what good problems are
	- The community devolves to only inventing trivial permutations of elementary problems
- The community may not have a good taste of what good solutions are
	- The community may not be able to invent an algorithm to solve a problem
	- The community devolves to finding only trivial improvements in solutions
- The community may not be able to invent all the problems humans have invented
- The community may not be able to manage their knowledge correctly
- The community may not be able to learn from the collective knowledge


We can relax the community input restrictions and then tighten it as we 
- Maybe we can start with the superhuman competitive programmer first.
- Maybe the leaderboard would already be populated with problems that they need to solve, but without the solutions.
- Maybe the models will start with using OpenAI o3, which probably has some knowledge of the solutions to the hardest competitive programming problems.
- Maybe we can intervene in the training process when we discover that the community is going off-course.


If we successfully develop this supercommunity, we are likely to discover elegant problems that we have not discovered. We might also invent algorithms that have not been invented. We will also irrefutably demonstrate the ability of LLMs to create new knowledge.


This would be the first superhuman system that reproduces and advances scientific knowledge.


