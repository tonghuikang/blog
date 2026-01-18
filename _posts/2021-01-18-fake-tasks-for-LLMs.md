---
layout: post
title: Tasks that you should on train or evaluate your LLMs
---
When a frontier LLM fails at a task, you should critically evaluate whether your task is wrong.

You should be ware of this and stop training and evaluation LLMs on fake tasks.



Tasks that require pure memorization.
LLMs should not be tasked to remember everything. The evaluation here is to defer to actual resources.
An AI system is still expected to memorize everything. If you provide the LLM access to Wikipedia and search.


Needle in a haystack problem. I do not think LLMs is expected to have. I think it is even ok for LLMs to have a sliding context window of 32000 tokens and the LLM is very careful on what should be placed in the 32000 tokens. Beyond 32000 tokens, the correct approach to the needle in the haystack problem is to do a string search over previous context.


Tasks that require a playbook.
You cannot expect an LLM to serve as your lawyer with providing access to the lawbook?
Facts change over time.


Tasks that are better served with tools.
Multiplication without thinking. You are still able to expect LLMs manually manipulate digits to solve multiplication problems.


Tasks on noisy data.
Any attempt to curve fit to noisy data.
This is not a Kaggle competition where you want to curve fit a prompt to a dataset that is not always correct. There should be a mindset change here. When forcing a classification, there should be a set of data we are ok classification either way.







