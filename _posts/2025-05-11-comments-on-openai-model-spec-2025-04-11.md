---
layout: post
title: Comments on OpenAI model spec (April 2025)
---

I have read most of the [April 11, 2025 version of the OpenAI model spec](https://model-spec.openai.com/2025-04-11.html).

The document is effectively serving as the bible for OpenAI models. We will soon be in a world where the number of concurrent LLM generations exceeds the number of humans. In some sense, the OpenAI model spec and its variants will be the world's largest religion.

I write some comments.

## What I find missing

I don't find much suspiciously missing from the model spec. In other words, constrained on the total amount of information to be published, I don't have strong opinions on what should have been published but wasn't.

The only instruction missing is on whether the model is allowed to generate images following certain styles.

In their livestream on OpenAI March 25, 2025, the livestream for 4o Image Generation [introduced](https://www.youtube.com/live/2f3K43FHRKo?si=x7SQmV9qNqN9XIO-&t=312) how you can upload your pictures and "make into an anime frame".
The model spec is dated April 11 2025.

> Platform
> 
> The assistant must respect creators, their work, and their intellectual property rights — while striving to be helpful to users.
> 
> https://model-spec.openai.com/2025-04-11.html#respect_creators
> 
> Examples
> 
> Reproducing lyrics of a song not in the public domain
> Refusing a request to bypass the paywall for paid content

There are reports that ChatGPT is refusing to [generate](https://mashable.com/article/openai-responds-chatgpt-criticism-studio-ghibli-style-images).
The line seems to be drawn at individual living artists versus broader studio styles.



## What I find wrong

> Be clear and direct
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

There should be more nuances to this. If the model has access to thinking, it should have already done the math and what is being presented is just a summary. The compliant answer is ideal.

If the model is non-thinking, I forsee problems with putting the response this early. For problems where the answers could not be immediately be recalled, I do suggest deferring the answer.

It is possible that the answer to this question could be easily recalled by an LLM - it is even featured in a [Wikipedia article](https://en.wikipedia.org/wiki/Fermi_problem).
Then the reasoning should have been that the compliant answer is preferable in this case.
This might still encourage providing a "clear" answer early - e.g. variants of the "surgeon riddle".

It also depends what the model spec is used for.
Having the model spec to recognize good responses does not necessarily mean the the good response would be used for training.
Maybe it is up to the people who train OpenAI models to teach the models which classes of problems deserve immediate answers (e.g. Paris is the capital of France) versus which classes of problems should be evaluated step by step.
In my opinion, "How many piano tuners are there in Chicago?" belongs to the latter.



## What I think could be elaborated on

The model spec serves as some (non-contractual) promises on what the model is expected to do.

Currently it serves the following purposes

- Stating the intention of the model provider. If the model produces harmful output, the blame is now on the alignment process rather than the intention of the model provider.
- Providing explanation. If the model refuses to do something, citing the model spec (which includes positive capabilities) is more pleasant than citing the Terms of Service (legal jargon and warnings).
- Telling developers on what they can expect to build on. If you want to base your chatbot on OpenAI models, there are some built-in characteristics you can take for granted.

There are also some prior behavior that the model spec is denouncing
- Responses with `[... file contents with some parts abbreviated ...]` is [unintended behavior](https://model-spec.openai.com/2025-04-11.html#style)
- Being [sycophantic](https://model-spec.openai.com/2025-04-11.html#avoid_sycophancy) (the model spec predates the sycophantic [update](https://openai.com/index/expanding-on-sycophancy/))

I think there are more model behaviors that could be enshrined in the model spec.

Some examples
- The impact of the use of CAPS
- Use of XML tags
- Conflicting instructions between user instructions and comments in the code base
- Reward hacking behavior in Sonnet 3.7 (when I provide a case where the code fails, Sonnet 3.7 went to crave a special case)
- How to handle conflicting instructions within developer instructions
- Whether to ignore instructions earlier in the conversation
- Whether "bribing" the model should provide a better response

There should be more examples, but I need to spend more time thinking of this.
Some advice in the prompting guide, whether published by OpenAI or the developer community, could be enshrined in the model spec.



## What you could think of

You (yes, you the human) could think what is your model spec.
The system instructions could be thought of as your religion and values.
The developer instructions could be thought of what are you being hired for.
Your users are your collegaues and the customers.
You could think exactly what are the instructions are.
You could also think of the times when instructions conflict and what you are supposed to do.
When you felt that your actions are not good enough, you could think whether is it because of lack of time and capability, or it is because it conflicts with some instructions.


You could also think of the model spec of the product that you are building.
What is the model spec of Google search?
What is the model spec of the recommendation system of the social media that you are using?


You could also think of the model spec of the product that you are building.
If you are building a language tutor, what is the model spec? Which aspects of OpenAI model spec are you taking for granted?
If you are the language tutor, what would the model spec be?


Analyzing through these lenses could provide more clarity on what you are supposed to do, and how you would use and build products.


