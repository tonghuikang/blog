---
layout: post
title: Fake tasks for LLMs
---
When a frontier LLM fails at a task, you should critically evaluate whether your task is wrong.

A task is "fake" when the expected response in the evaluation differs from what the correct response should actually be.
You should stop training and evaluating LLMs on fake tasks.


## Tasks that require pure memorization

Some evaluations test whether an LLM can recall specific facts from memory - the capital of a country, the year a treaty was signed, the atomic weight of an element.

LLMs should not be tasked to remember everything.
The correct response is often to defer to actual resources.
If you provide an LLM access to Wikipedia and search, the LLM should use them rather than rely on potentially outdated or incorrect memorized facts.

The fake task is penalizing an LLM for saying "let me look that up" when that is the correct response.


## Needle in a haystack

Needle in a haystack benchmarks test whether an LLM can find a specific piece of information buried in a very long context.

LLMs should be designed to maintain the context they need to work with.
This likely involves giving LLMs the ability to directly manage their own context - deciding what to keep and what to forget.

Beyond what the LLM can hold in working memory, the correct approach to the needle in the haystack problem is to do a string search over previous context.
Testing whether an LLM can find a specific fact buried in 100k tokens of noise is testing something artificial.
In practice, the correct response is to use search tools over the context, not to perfectly attend to every token.


## Tasks that require a playbook

Some evaluations test whether an LLM can answer domain-specific questions - legal advice, medical diagnoses, tax regulations.

You cannot expect an LLM to serve as your lawyer without providing access to the lawbook.
LLMs should have baseline domain knowledge, like a human professional would.
But LLMs should always be expected to have access to reference materials - similar to how a human would.
We do not expect human lawyers to work without lawbooks, so we should not expect LLMs to either.

Facts also change over time.
Questions within the training window are fair game - asking about the US president in 2023 is a valid task for a model trained on data through 2024.
For questions after the knowledge cutoff, the model should have a principled response - acknowledge the limitation and defer to sources.
The fake task is expecting the model to know post-cutoff facts without retrieval.


## Tasks that are better served with tools

Some evaluations test raw computation - multiplying large numbers, performing complex arithmetic, counting characters.

We should not be evaluating LLMs on whether they can do 100-digit multiplication without chain of thought.
LLMs should be able to figure out and follow recipes to do 100 by 100 digit multiplication in O(n²) tokens.

The valid test is whether LLMs can discover and execute algorithms, not whether they can magically compute.
Testing 100-digit multiplication without chain of thought is like testing if someone can multiply in their head blindfolded - irrelevant to real capability.
The correct response is to use a calculator or follow a systematic algorithm, not to output the answer in one step.


## Tasks on noisy data

Some evaluations use datasets where the labels are inconsistent or ambiguous - different annotators disagree, or the categories are not clearly defined.

This is not a Kaggle competition where you want to curve fit a prompt to a dataset that is not always correct.

Borderline examples should not be in the evaluation at all.[^evals]
You only label what is obviously in one category and what is obviously in another.
If it is borderline, you do not include it - because in production, you are fine with either classification.

The fake task is forcing a ground truth label on something that does not have one, then penalizing the model for "getting it wrong".

Models are good enough to distinguish genuine mistakes from borderline examples.
The human's role is to validate that meta-judgment - to confirm that yes, this example is genuinely ambiguous and both classifications are acceptable.

[^evals]: I have previously written about this [here](https://blog.huikang.dev/2026/01/04/comments-on-evals-faq.html).


## Call to action

Benchmark creators should be aware that their benchmarks can be wrong.
Benchmark creators usually build a benchmark and move on with their lives - they are not expected to maintain the benchmarks.
Benchmark users should be aware of this.

Similar to humans, you need to have your own judgment on what is right and wrong.
External resources and evaluations serve to inform, but you need to decide what you want to learn.
When an LLM fails a benchmark task, ask yourself: is the model wrong, or is the task wrong?



