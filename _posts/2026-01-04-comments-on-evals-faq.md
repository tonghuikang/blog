---
layout: post
title: My comments on the Evals FAQ
---
Hamel's evals FAQ is a great resource.

https://hamel.dev/blog/posts/evals-faq/

Many of the ideas I have been promoting aligns with the Evals FAQ. The Evals FAQ is a trusted resource.

All opinions here are my own, and do not represent the prevailing opinions or practices of any organization.


## Sections that I agree and promote

These are ideas that I have been promoting. I should have cited the Evals FAQ when promoting my ideas.

---

> Why do you recommend binary (pass/fail) evaluations instead of 1-5 ratings (Likert scales)?
> 
> Having binary options forces people to make a decision rather than hiding uncertainty in middle values. Binary decisions are also faster to make during error analysis - you don’t waste time debating whether something is a 3 or 4.

I was requested to make classification graduated. It was proposed that in the future we can have different treatment for difference scales and we can reuse the classification. I am against this idea. Either it is bad, or it is not.


---

> Q: How should I version and manage prompts?
> 
> There is an unavoidable tension between keeping prompts close to the code vs. an environment that non-technical stakeholders can access.
> 
> **My preferred approach is storing prompts in Git.** This treats them as software artifacts that are versioned, reviewed, and deployed atomically with the application code.

There is indeed a requirement for non-technical stakeholders to read and write prompts. Prompts should already be easily readable if your organization has good AI tooling to point you to the exact prompt.

There is also the case where you want to "write" and test the prompts[^system]. I would refer the observability system to just "reroll" the prompt than to be the source of truth for the prompts.

I really dislike working with a system where the true prompt and the application logic are in separate places.

[^system]: My view of my role as a prompt engineer is not to write the prompt, but to correctly build the system for other people to write the prompts.

---


>Q: How many people should annotate my LLM outputs?
>
>A single expert eliminates annotation conflicts and prevents the paralysis that comes from “too many cooks in the kitchen”. The benevolent dictator can incorporate input and feedback from others, but they drive the process.

Annotating the ground truth should not be a democracy. Worse, they treat the annotations as ground truth, and attempt to curve-fit the prompt to the ground truth that contradicts with itself.


## Sections that I would add or remove


Evals should allow for ambiguity. You do not need to classify everything. But if your classifier is not classifying anything it is bad.

AI models are better now. You can get AI models to brainstorm edge cases with you. (Is there mention similar to this?)




## Sections that I disagree

> Be [wary of optimizing for high eval pass rates](https://ai-execs.com/2_intro.html#a-case-study-in-misleading-ai-advice). If you’re passing 100% of your evals, you’re likely not challenging your system enough. A 70% pass rate might indicate a more meaningful evaluation that’s actually stress-testing your application. Focus on evals that help you catch real issues, not ones that make your metrics look good.

I do not agree that passing 100% of your evals is wrong in itself. Of course, the value of evals that pass 100% is up to question.

When there is a failure in the eval, either one or multiple parts are wrong - the model, the prompt, or the label (or the llm-as-a-judge evaluator). You should find out which one is it. It is possible that the label is wrong. The case might be borderline and probably should allow the system make either classification and not compute loss. If the prompt is wrong, you probably could tweak the prompt. If the model is wrong, you likely could not do anything. My point here is, when there is a mistake, something has to be wrong.

There could still be value for evals that pass 100%. Probably you have a classifier that classifies whether something is adult. The requirements is quite loose. You only need to correctly if something is obviously [adult](https://en.wikipedia.org/wiki/I_know_it_when_I_see_it), or obviously not adult. There are a lot of borderline cases that you are okay with the system with tagging either way. Models today can perform 100% at this task.

What you should not do is to squeeze in the borderline examples to make the eval perform at 70%. Similar to how "the goal of evaluations isn’t to pat yourself on the back for a perfect score", it should also be the case the "The goal of evaluations isn’t to pat yourself on the back for an imperfect score".

Of course, monitoring is still essential. At launch, your score could be 100% but you should collect examples of obviously adult and obviously not adult cases.

Even if you did not manage to collect additional failure examples, the eval still serves a check when you migrate models or prompts. The eval is like a unit test that is only run once every model migration.


## Footnotes
