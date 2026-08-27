---
layout: post
title: Fake tasks for LLMs
---
When a frontier LLM fails at an evaluation test case, you should critically evaluate whether your test case is worth passing.

These are some evaluation test cases that I think LLMs should no longer be evaluated on.


## Tasks on recalling facts not critical to your work

There are evals that test whether the LLM remembers certain things (MMLU).

This is the README example in [MMLU dataset](https://huggingface.co/datasets/cais/mmlu).

```json
{
  "question": "What is the embryological origin of the hyoid bone?",
  "choices": [
    "The first pharyngeal arch",
    "The first and second pharyngeal arches",
    "The second pharyngeal arch",
    "The second and third pharyngeal arches"
  ],
  "answer": "D"
}
```

I argue that this is an unreasonable memorization task[^bits]. LLMs do not need to memorize this to be helpful. Neither do doctors need to memorize this to execute their work.

Even as we do not expect LLMs to always provide the perfect answer to this, we still expect AI systems to solve this task perfectly. AI systems are more than just models. AI systems involve LLMs having access to tools such as web search.

[^bits]: Research shows that LLMs memorize approximately [3.6 bits](https://arxiv.org/abs/2505.24832) of information per parameter. Based on this budget, model providers should probably at least have some internal standards on what LLMs are supposed to know and not supposed to know.



## Tasks on recalling from a super-long context

There are currently evals that test whether a model can retrieve a specific piece of information buried in a very long context. Model providers boast that their models could memorize the context well into the [millions](https://cloud.google.com/blog/products/ai-machine-learning/the-needle-in-the-haystack-test-and-how-gemini-pro-solves-it).

I argue that this is a non-goal. Humans can solve very long problems without the ability to memorize the entire conversation history. A math professor does not need to recall what they did exactly 300 days ago to solve an open math problem that requires a lot of research and trial and error.

The goal here is to solve complex tasks with the minimum compute. I expect the solution to involve an AI system where the LLM manages its own context and queries previous context with tools. The solution does not necessarily require a model that is able to retrieve something within a million tokens.

This means I still expect AI systems to be perfect at super-long context retrieval. LLMs should be able to use tools to query the history and perfectly retrieve any specific piece of information.




## Tasks that require a playbook

Some evaluations test whether an LLM can answer domain-specific questions - legal advice, medical diagnoses, tax regulations.

You cannot expect a lawyer to do well at their job without access to the legal resources. Similarly, you cannot expect the LLM to perform as well as the lawyer without access to the same set of legal resources.

LLMs should have baseline domain knowledge, like a human professional would. We should avoid having evals that simply test the LLMs without providing them access to the necessary legal resources.



## Tasks that are better served with tools

Some evaluations test raw computation - multiplying large numbers, performing complex arithmetic, counting characters.

We should not be evaluating LLMs on whether they can do 100-digit multiplication without chain of thought.
LLMs should be able to figure out and follow recipes to do 100 by 100 digit multiplication in O(n²) tokens.

LLMs should be evaluated on whether they can discover and execute algorithms, not whether they can compute magically[^architecture].

[^architecture]: It is still an interesting exercise to design weights to a given neural network architecture to multiply integers without a thinking process.


## Tasks based on noisy data

We should not use the same mindset we used to participate in traditional Kaggle competitions to train LLMs.

In traditional Kaggle competitions, you do whatever it takes to maximize your score on the leaderboard, even if it means training on incorrect labels in the training set. We should not carry this mindset to evaluating LLMs.

I expect model providers to remove inconsistent or ambiguous test cases when evaluating their models internally.


## Summary

I hope we apply higher scrutiny to the test cases we use to evaluate LLMs.

I also hope that you understand the difference in standards that we apply to LLMs and to AI systems. There are tasks we expect AI systems to solve perfectly, but do not expect LLMs to get correct.

So when an LLM fails a benchmark task, ask yourself: is the model wrong, or is the task wrong?


## Footnotes



