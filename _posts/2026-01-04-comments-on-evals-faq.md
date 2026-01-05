---
layout: post
title: My comments on the Evals FAQ
---
Hamel's evals FAQ is a great resource.

[hamel.dev/blog/posts/evals-faq/](https://hamel.dev/blog/posts/evals-faq/)

Many of the ideas I have been promoting[^prompting] align with the Evals FAQ.

The content here does not represent the prevailing opinions or practices of any organization.

[^prompting]: I have previously written about prompting projects [here](https://blog.huikang.dev/2024/12/31/prompting-projects.html).


## Sections that I agree and promote

These are ideas that I have been promoting.
I should have cited the Evals FAQ when promoting my ideas.

---
On [binary](https://hamel.dev/blog/posts/evals-faq/#q-why-do-you-recommend-binary-passfail-evaluations-instead-of-1-5-ratings-likert-scales) (pass/fail) evaluations instead of 1-5 ratings (Likert scales). 
 
> Having binary options forces people to make a decision rather than hiding uncertainty in middle values. Binary decisions are also faster to make during error analysis - you don’t waste time debating whether something is a 3 or 4.

For example, you want to classify whether content is adult. You might want to ask for a scale of 1 to 4 instead of a binary classification. On the adult side, you want a label of 1 if the content is [CSAM](https://en.wikipedia.org/wiki/Child_pornography) that you have to eliminate from your platform, and a label of 2 if it is merely adult. On the less adult side, you want a label of 3 if it is provocative that you do not want to show to new users, and 4 if the content is perfectly fine. Only users who opted in to adult content will see content with label 2.

I would rather we have three binary classifiers - on whether something is adult (1+2 vs 3+4), on whether something is CSAM (1 vs the rest), and on whether something should be shown to new users (4 vs the rest).

There are some arguments for having one classifier for all 4 labels

- You intend to run the LLM for all your content. You think running the LLM only once saves you money, compared to running the LLM three times for three separate classifiers.
- You think that having one system is simpler, as opposed to multiple systems. You think that one system is easier to maintain.

I argue that you should think harder whether having a graduated 1-4 scale is really a better system than having three binary classifiers.

- You need to think about what happens when you want to change one of the systems. Let's say you want to have a different standard on what is allowed to be displayed to new users (label 3 versus label 4). You need to ensure that your single LLM classifier still works for label 2 and label 1. Experimentation is also more complicated now.
- There might be different levels of scrutiny for different classifications - you are okay if label 3 versus label 4 is mixed up, but you do not want to mix up label 1 versus label 2 because accounts posting label 1 content will get banned.
- Aligning a binary classifier is much easier than aligning a graduated classifier. It should be easier and faster to align three binary classifiers independently, than to align one 4-class classifier. It is also easier to find cheaper and equally performant classifier if the task is just binary classification.

If your systems are uncoupled, you just need to align the parts that you need to align. Sure, it might cost more to run the LLMs three times, but engineering time usually costs even more money.

---
On [versioning](https://hamel.dev/blog/posts/evals-faq/#q-how-should-i-version-and-manage-prompts) and managing prompts
 
> There is an unavoidable tension between keeping prompts close to the code vs. an environment that non-technical stakeholders can access.
> 
> **My preferred approach is storing prompts in Git.** This treats them as software artifacts that are versioned, reviewed, and deployed atomically with the application code.
> 
> Prompt management tools are inherently limiting because they can’t easily execute your application’s code. Even when they can, there’s often significant indirection involved, making it difficult to test prompts with your system’s capabilities.

There is indeed a requirement for non-technical stakeholders to read and write prompts. Prompts should already be easily readable if your organization has good AI tooling to point you to the exact prompt.

There is also the case where non-technical stakeholders want to write and test the prompts[^system] without opening a terminal or Jupyter notebook. It should be possible to keep the prompts in git while they experiment with the different prompts.

[^system]: My view of my role as a prompt engineer is not to write the prompt, but to correctly build the system for other people to write the prompts.

---

On how many people should be [annotating](https://hamel.dev/blog/posts/evals-faq/#q-how-many-people-should-annotate-my-llm-outputs) LLM outputs

>A single expert eliminates annotation conflicts and prevents the paralysis that comes from “too many cooks in the kitchen”. The benevolent dictator can incorporate input and feedback from others, but they drive the process.

I have written exactly on this [before](https://blog.huikang.dev/2024/12/31/prompting-projects.html).

> I argue that democracy is a horrible way to build a dataset for LLM evaluation. Let’s say you want to build dataset to determine whether an advertisement is low quality. You get your team to label the content and treat the labels as immutable ground truth. But you notice the labels provided by your team often disagrees with each other.
> 
> If you pass this dataset to your colleague, your colleague is simply guessing what people are voting. Your colleague will likely not perform well. This is what you will be tuning your prompt to.

The FAQ suggests a benevolent dictator to own the prompts, which I agree.


## Sections that I would add or edit

Evals should only focus on cases where you care about. In other words, you do not need a ground truth label for everything.

For example the adult content classification, you only want to label what is [obviously](https://en.wikipedia.org/wiki/I_know_it_when_I_see_it) adult and what is obviously not adult. If something is neither obviously adult or obviously not adult, there is no need for a ground truth label. This means, in production, you are ok with the content being classified in either case.

---

I think some updates have to be made considering models are much more powerful now.

- I do not think we should spend effort ensuring that every step the model takes is correct. For example, I do not think we need to care whether every search term made by the model is ideal. We know that frontier models serve as reliable agents that complete tasks. They know when they are making mistakes. As model users, we should not need to scrutinize every step the model is making; we should be more concerned with the outcome.
- I think models could play a bigger role in prompting. One new use case for LLMs in building the evaluation dataset is to brainstorm the edge cases that we care about. LLMs could even agentically query your data for mistakes the binary classifier is making in production, and put these labels up for human approval.


## Sections that I disagree

On passing 100% of your evals

> Be [wary of optimizing for high eval pass rates](https://ai-execs.com/2_intro.html#a-case-study-in-misleading-ai-advice). If you’re passing 100% of your evals, you’re likely not challenging your system enough. A 70% pass rate might indicate a more meaningful evaluation that’s actually stress-testing your application. Focus on evals that help you catch real issues, not ones that make your metrics look good.

I do not agree that passing 100% of your evals is wrong in itself. Of course, you still need to justify the value of evals that you already score 100% (or any passing rate as well).

When there is a classification failure, either one or multiple parts must be wrong - the classifier (model + prompt), or the label (or the LLM-as-a-judge evaluator). You should find out which one it is. It is possible that the label is wrong[^borderline]. If the prompt is wrong, you can probably tweak the prompt. If the model is wrong, you likely cannot do anything. My point here is, when there is a mistake, something must be wrong.

[^borderline]: Again, the case might be borderline and probably should allow the system make either classification and not compute loss.

Mistakes are mistakes. It is possible to fix all these mistakes to get your eval to 100%. Models are better these days, and now you have AI to help you write and improve prompts. It is possible that you are not able to find any more mistakes with reasonable effort.

There could still be value for evals that pass 100%. For example, you have a classifier that classifies whether something is adult. The requirements are quite loose. You only need to classify correctly if something is obviously adult or obviously not adult. There are a lot of borderline cases where you are okay with the system tagging either way. Models today can perform 100% at this task. There is still value in this eval even though it passes 100%.

You can deploy this classifier and monitor mistakes in production. The classifier is likely to make mistakes (something that is obviously adult classified not adult), and you add the mistakes to the evaluation. Then you can tune the classifier to achieve performance on the mistakes and the initial dataset. The eval that passes 100% is still useful.

You can use the same eval when you migrate models. Models get deprecated, or you found a much cheaper model that is equally performant. The eval that scores 100% still serves as a unit test that is only run once every model migration.

What you should not do is try to add borderline examples to the dataset to make the eval perform at 70%. Similar to how "the goal of evaluations isn't to pat yourself on the back for a perfect score", it should also be the case that "the goal of evaluations isn't to pat yourself on the back for an imperfect score".


## Footnotes
