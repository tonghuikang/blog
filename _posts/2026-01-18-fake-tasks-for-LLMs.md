---
layout: post
title: Fake tasks for LLMs
---
When a frontier LLM fails at a evaluation test case, you should critically evaluate whether your test case is worth passing.

I write come evaluation test cases that I think LLMs should no longer be evaluated on.


## Unreasonable memorization tasks

There are evals tests whether the LLM remember certain things (MMLU).

This is the README example in [MMLU dataset](https://huggingface.co/datasets/cais/mmlu) 

```
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

I argue that this is an unreasonable memorization task[^bits]. LLMs do not need to memorize this to helpful. Neither do doctors need to memorize this to execute their work.

Even as we do not expect LLMs to always provide the perfect answer to this, we still expect AI systems to solve this task perfectly. AI systems are more than just models. AI systems involves LLMs having access to tools such as web search.

[^bits]: There is this theory that LLMs memorize 3.6 bits of information per parameter (citation needed). Based on this budget model providers should probably at least have some internal standards on what LLMs are supposed to know and not supposed to know.



## Super-long context retrieval

There are currently evals that tests whether a model can retrieve a specific piece of information buried in a very long context. Model providers boast that their models could memorize the context well into the [millions](https://cloud.google.com/blog/products/ai-machine-learning/the-needle-in-the-haystack-test-and-how-gemini-pro-solves-it)

I argue that this is non-goal. Humans could solve very long problems without the ability to memorize the entire conversation history. A math professor does not need to recall what did they do exactly 300 days ago to solve an open math problem that requires a lot of research and trial and error.

Without this super-long context retrieval requirement for LLMs, we can focus on the real tasks that LLMs should be good at.

However, I still expect AI systems to be perfect at super-long context retrieval. LLMs should be able to use tools to query the history and perfectly retrieve any specific piece of information perfectly.




## Tasks that require a playbook

Some evaluations test whether an LLM can answer domain-specific questions - legal advice, medical diagnoses, tax regulations.

You cannot expect a lawyer to do well at their job without access to the legal resources. Similarly, you cannot expect the LLM to perform as well as the lawyer without access to the same set of legal resources.

LLMs should have baseline domain knowledge, like a human professional would. We should avoid having evals that simply tests the LLMs without providing them access to the necessary legal resources.



## Tasks that are better served with tools

Some evaluations test raw computation - multiplying large numbers, performing complex arithmetic, counting characters.

We should not be evaluating LLMs on whether they can do 100-digit multiplication without chain of thought.
LLMs should be able to figure out and follow recipes to do 100 by 100 digit multiplication in O(n²) tokens.

LLMs should be evaluated on whether can they discover and execute algorithms, not whether they can compute magically[^architecture].

[^architecture]: It is still interesting exercise to design weights to a given neural network architecture to multiply integers without a thinking process.


## Tasks on noisy data

We should not use the same mindset we used to participate in traditional Kaggle competitions to train LLMs.

In traditional Kaggle competitions, you do whatever it takes to maximize your score on the leaderboard, even if it means training on incorrect labels in the training set. We should not carry this mindset to evaluating LLMs.

I expect model providers to remove inconsistent or ambiguous test cases when evaluating their models internally.

Some evaluations use datasets where the labels are inconsistent or ambiguous - different annotators disagree, or the categories are not clearly defined.

The mindset of training LLMs should be different from the mindset of participating in Kaggle competition where you want to curve fit a prompt to a dataset that is not always correct.

Borderline examples should not be in the evaluation at all.[^evals]
You only label what is obviously in one category and what is obviously in another.
If it is borderline, you do not include it - because in production, you are fine with either classification.

The fake task is forcing a ground truth label on something that does not have one, then penalizing the model for "getting it wrong".

Models are good enough to distinguish genuine mistakes from borderline examples.
The human's role is to validate that meta-judgment - to confirm that yes, this example is genuinely ambiguous and both classifications are acceptable.

[^evals]: I have previously written that when writing prompts to models, there are borderline inputs where you should not penalize models for giving the wrong response. My example was on [classification](https://blog.huikang.dev/2026/01/04/comments-on-evals-faq.html), 


## Summary

I hope we have higher scrutiny over the test cases we are evaluating the LLMs.

I also hope that you understand the difference in standards that we apply to LLMs and to AI systems. There are tasks we expect AI systems to solve perfectly, but do not expect LLMs to get correct.

So when an LLM fails a benchmark task, ask yourself: is the model wrong, or is the task wrong?


## Footnotes



