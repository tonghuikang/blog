---
layout: post
title: Tasks that are easy to describe and grade
---
The tasks we assign to humans can be classified into this two-by-two matrix. I explain the classification.

|                              | Easy to grade                                            | Difficult to grade                     |
| ---------------------------- | -------------------------------------------------------- | -------------------------------------- |
| **Easy to <br>describe<br>** | A-level math calculations<br><br>Competitive programming | Writing an A-level General Paper essay |
| **Difficult to describe**    | Implementing a button on the Quora website               | Improve Quora recommendation systems   |



# Ease of describing

This is concerned with the input - it is easy to provide all the information necessary to complete the task?

Tasks that are easy to describe can be described within a single piece of paper.

Note that this does not indicate the difficulty the task is. There are tasks that are easy to describe but very hard even for the best human experts
- There are very hard competitive programming problems that can described as little as one line, but it could be very difficult (but still solvable). You can find these problems in AtCoder Grand Contest, or in the final problems of Div 1 Codeforces round.
- There could be very 
- Mathematical contest problem - [Putnam Competition](https://en.wikipedia.org/wiki/William_Lowell_Putnam_Mathematical_Competition) each problem can be described with a small section of the paper, but 


What are characteristics of task that easy to describe?

The objective (?) is unambiguous.


There are no external data, or very limited external data.


What makes a task difficult to describe?

There is a lot of organization knowledge involved. If you want to implement a button on Quora that does a certain functionality (i.e. send requests to answer to authors) there is a lot of context behind this implementation. There are design standards. You need to implement sensible logging. You don't just edit the HTML and a button appears, it has to work and it has to look nice in many places. Maybe the change is just 50 lines of code, but there is a lot of context involved. This is not easy to describe.
- You have to make assumptions of the decisions made in the past, and check whether the assumptions are valid. There will be documents that are inconsistent with each other. You will also need to make decision to follow - for example in the product there are two button styles you need to decide which style is to use, and usually one is more correct than the other.

The interface is complicated. In math you just write your answer on a piece of paper. For software engineering, you need to interact with the system and make multiple changes and test the changes. You get more inputs as you test the changes. And you don't have free access to the system, (i.e. Quora development servers).

The approach to source for information is . There is a lot of noise in the information.

Of course, classification between whether a task is easy to describe or difficult to describe is blur.

Debatable examples
- Kaggle competitions. Even though all Kaggle competitions have a problem statement, this doesn't mean that the all the data you need to do well at a Kaggle competition is self-contained. In some competitions, you need to compile your own external data to gain an advantage.
- Writing A-level General Paper essay. A good essay should be recognized as good in most marking rubrics. The knowledge needed to write an A-level General Paper could be derived from events that has happened yesterday.
- Open mathematical problems. I don't understand what the Rienmann 



Examples of tasks easy to describe (low-context / no-context tasks)
- Doing A-level math calculations
- Writing an A-level General Paper essay
- Competitive programming

Examples of tasks difficult to describe (high-context tasks)
- Implementing a button on the Quora website
- Planning how to improve Quora recommendation systems

Implications
- Companies have already experimented with offshoring work easy to describe
- OpenAI Deep Research
- Soon we will use AI to do all the work that is easy to explain
- If it takes more effort to get others to do I will still rather do it myself






# Ease of grading

This is concerned with the output - it is easy to determine whether the output is good or not?

Characteristics of tasks that are easy to grade

There is a deterministic program to produce a given score.

The line is actually quite blur.

There are tasks when you make it easy to grade it becomes meaningless to grade.

Characteristics of tasks that are difficult to grade

- Cases where it is easy to compare for a better result.
- Fixed output versus open-ended output. This also means that you might be rewarding mathematical solutions that arrive at the correct answer with very wrong processes. It is possible that the open-ended output could be evaluated to a fixed output that could be evaluated (competitive programming).
- A lot of expertise is needed to grade the result. Maybe the AI can come up with a complicated proof with very advanced theorems, it requires a human expert to say that the proof is valid. Or probably constrain the output to use no more mathematics than what is elementary methods, and apply some limit to the output.

Determining whether a mathematical proof is correct. I think this is difficult to grade.

Identifying an error in a mathematical proof. I think this is easy to grade - either an error is identified or the error is not identified.

Making a task easy to grade might make the task meaningless

Are essays easy to grade? What if if you treat the LLM output as the ground truth. That will make it easy to grade. But that does not make the task meaningful.


Why it is difficult to grade is that the rewards are easily hacked. This means people use underhanded methods to obtain data to gain an advantage


Examples of tasks not easy to grade

- Open mathematical problems. It took the mathematical community several years, also with several corrections from the Perelman. It will be plenty of time we see AI solving one of the problems for example.


Debatable examples

- Writing A level General Paper essay where the grader is an LLM. Then this is easy to grade. But this doesn't mean that the grading is good. You will be reward hacking the LLM.








## The difference between describing and grading


The ease of describing deals with the input. The ease of grading deals with the output. There is some arguments to consider them the same. Maybe the description of how the output is graded should have been the input. But we keep them separate.






## The current state of AI

As of early 2025, this is the current state of AI.

|                                   | Easy to grade                                                                      | Difficult to grade                                                                                                   |
| --------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Easy to <br>describe**          | Better than the average professional, soon to be solved at a superhuman level      | AI can provide an acceptable response, but you can do it much better. You need to think of how to grade AI responses |
| **Difficult to <br>describe**<br> | You rather do this yourself, or break it down into tasks that are easy to describe | You need to make it easy to describe and verify for AI to be useful                                                  |

However, there are still plenty of tasks easy to describe easy to grade but are not fully solved by AI. I list some of these tasks, and I predict and expect huge progress to be made soon, if not already.





