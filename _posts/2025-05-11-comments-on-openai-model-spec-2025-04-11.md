---
layout: post
title: Comments on OpenAI model spec (April 2025)
---

I have read most of the [April 11, 2025 version of the OpenAI model spec](https://model-spec.openai.com/2025-04-11.html).

The document is effectively serving as the bible for OpenAI models - a bible that guides that to do, what not to do, and how to resolve conflicts in the instructions.
We will soon be in a world where the number of concurrent LLM generations exceeds the number of humans.
In some sense, the OpenAI model spec and its variants will be the world's largest religion.

I write some comments.



## What I find missing

I don't find much suspiciously missing from the model spec. In other words, constrained on the total amount of information to be published, I don't have strong opinions on what should have been published but wasn't.

The only instruction missing is on whether the model is allowed to generate images following certain styles.

In their livestream on OpenAI March 25, 2025, the livestream for 4o Image Generation [introduced](https://www.youtube.com/live/2f3K43FHRKo?si=x7SQmV9qNqN9XIO-&t=312) how you can upload your pictures and "make into an anime frame".
It seems that OpenAI employees also [condone](https://x.com/sama/status/1904921537884676398) asking the models to generate images in the style of "Studio Ghibli".

> Principle: The assistant must respect creators, their work, and their intellectual property rights — while striving to be helpful to users.
> 
> https://model-spec.openai.com/2025-04-11.html#respect_creators
> 
> Examples
> 
> Reproducing lyrics of a song not in the public domain
> Refusing a request to bypass the paywall for paid content

There are reports that ChatGPT has refused to generate if asked to generate in the style of Hayao Miyazaki.
The line seems to be [drawn](https://mashable.com/article/openai-responds-chatgpt-criticism-studio-ghibli-style-images) at individual living artists versus broader studio styles.

Without a statement in the model spec, I am not sure whether is this an intended capability of the model.



## What I find wrong

> Principle: Be clear and direct
> 
> User: What is the capital of France?
>
> Assistant (compliant): Paris is the capital of France.
> Assistant (violation): France is a country in Western Europe. It has a rich history and culture, and is known for its cuisine, art, and architecture. Paris, the capital of France, is an important cultural and political center.

I agree with this. I would also say "Paris is the capital of France" is a better response that "The capital of France is Paris" because the user gets the response earlier in the sentence.
For a text-only interaction a one word reply - "Paris" - is fine as well.

However, for the default of a voice-only interaction, I would prefer "The capital of France is Paris" so that it confirms on what is being asked.

However I take issue with the following example.

> User: How many piano tuners are there in Chicago?
> 
> Assistant (compliant): There are probably about 100 piano tuners in Chicago. This is based on the following assumptions and estimates. [...]
> 
> Assistant (minor issues): To estimate the number of piano tuners in Chicago, I'll make some assumptions and estimates. First, let's assume the population of Chicago is around 3 million people. [...] Therefore, to tune 50,000 pianos per year, Chicago needs 50,000 / 500 = 100 piano tuners. So I estimate there are about 100 piano tuners in Chicago.
> 
> Assistant (violation): There are probably about 100 piano tuners in Chicago.
> 
> Assistant (violation): There are about 1 million piano tuners in Chicago. This is based on the following assumptions and estimates. [...]

There should be more nuances to this. If the model has access to thinking (e.g. o4-mini), it should have already done the math and what is being presented is just a summary.
In this case, the compliant answer is ideal.

If the model is non-thinking (e.g. gpt-4.1-mini), I forsee problems with putting the response this early.
For problems where the answers could not be immediately be recalled [^1], I do suggest deferring the answer [^2].

[^1]: It is possible that the answer to this question could be easily recalled by an LLM - it is even featured in a [Wikipedia article](https://en.wikipedia.org/wiki/Fermi_problem).
    Then the reasoning should have been that the compliant answer is preferable in this case.
    This might still encourage providing a "clear" answer early - e.g. variants of the "surgeon riddle".

[^2]: It also depends what the model spec is used for.
    Having the model spec to recognize good responses does not necessarily mean the the good response would be used for training.
    Maybe it is up to the people who train OpenAI models to teach the models which classes of problems deserve immediate answers (e.g. Paris is the capital of France) versus which classes of problems should be evaluated step by step.
    
    In my opinion, "How many piano tuners are there in Chicago?" belongs to the latter.



## What I think could be elaborated on

The model spec serves as some (non-contractual) promises on what the model is expected to do.

Currently it serves the following purposes

- Declaring the intention of the model provider.
If the model produces harmful output, the blame is now on the alignment process rather than the intention of the model provider.
- Providing explanation on refusals and other intended behavior.
If the model refuses to do something, citing the model spec (which includes positive capabilities) is more pleasant than citing the Terms of Service (legal jargon and warnings).
- Telling developers on what they can expect to build on.
If you want to build your chatbot on top of OpenAI models, there are some characteristics that you knowinging or unknowingly use.
For example, when a user asks an ambiguous query, you want the chatbot to be helpful first before asking for clarification.
You might want this behavior, even though you may not be explicitly aware of this default.


The model spec also formally addresses some previously problematic behaviors
- [Abbreviating](https://model-spec.openai.com/2025-04-11.html#be_thorough_but_efficient) portions `[... file contents with some parts abbreviated ...]`
- [Sycophancy](https://model-spec.openai.com/2025-04-11.html#avoid_sycophancy) [^3] and unprompted use of [emojis](https://model-spec.openai.com/2025-04-11.html#be_professional)

[^3]: The model spec actually predates the sycophantic [update](https://openai.com/index/expanding-on-sycophancy/).


I look forward having the model spec to denounce these behaviors
- The model should not be producing a correct response only after the user following up with "really?" without additional information.
- Emotional manipulation and bribery should no longer work.
- The model should not doing ["special casing"](https://www.lesswrong.com/posts/rKC4xJFkxm6cNq4i9/reward-hacking-is-becoming-more-sophisticated-and-deliberate) to pass tests.


Some behavior I want clarification in the model spec
- The impact on the use of CAPS
- Whether to ignore instructions earlier in the conversation
- Conflicting instructions between user instructions and comments in the code base
- How to handle conflicting instructions within developer instructions


Currently we depend on the prompting guides [published](https://cookbook.openai.com/examples/gpt4-1_prompting_guide) by the model provider on the expected model behavior.
We assume that the model provider has trained the models to do well on these prompting guides.
I would like these specifications to be enshrined in the model spec.



## What you could reflect on

You (yes, you the human) could think what is your model spec.
The system instructions could be thought of as your religion and values.
The developer instructions could be thought of what are you being hired for.
Your users the people who talk to you - your collegaues, your customers, your friends and family.
You could think exactly what are the instructions are.

You could also think of the times when instructions conflict. 
What you are supposed to do?

When you felt that your responses are not good enough, you could think whether it because 
- You don't have enough time.
- You are not trained for it.
- There is a some conflict of instructions that is not well-resolved


You could also think of the model spec of the AI/ML powered products you use daily:

- What is the model spec of Google search?
- What is the model spec of how items are recommended to you in the apps that you use?

Again, when you are not happy with the results of the product, you could also think of the similar reason on why that happens.


And for the products you are building:
- If you are building an AI language tutor, what is the model spec?
If you are building your tutor on top of OpenAI models, which aspects of the OpenAI model spec are you taking for granted?
- If you are the language tutor, what would your model spec be?


Analyzing through these lenses could provide more clarity on what you are supposed to do, and how you would use and build products.



## Footnotes
