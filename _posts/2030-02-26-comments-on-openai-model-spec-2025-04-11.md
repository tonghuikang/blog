---
layout: post
title: Comments on OpenAI model spec (April 2025)
---

I read https://model-spec.openai.com/2025-04-11.html. I share some of my thoughts.

This is good material for humans as well. I think to think of what would the model spec be for myself. In other words, this is the bible.

The model spec is useful to explaining why replies. If the spec explains the behavior, you don't have to blame the model. If you intend to use human feedback to train the model, you will need to filter feedback that is not compliant with the model spec.

Would appreciate if this is more searchable though.

Unlike Anthropic [AI Constitution](https://www.anthropic.com/news/claudes-constitution) (dated May 2023), this describes exactly how the model will respond in certain situation.

I will comment on
- What I find missing in the model spec
- What I think is wrong is the model spec
- How I think the model spec will evolve



## What I find missing

I don't find much suspiciously missing the from the model spec. In other words, constrained on the total amount of information to published, I don't have strongly opinions on what should have been published but not published.

The only instruction missing in on whether is the model allowed to generate image following the style of a living artist (the model spec is dated April 11 2025, whereas the 4o Image Generation is dated March 25, 2025 and the livestream introduced an [instruction](https://www.youtube.com/live/2f3K43FHRKo?si=x7SQmV9qNqN9XIO-&t=312) to "make into an anime frame").

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

I am not too sure what is , there are reports that ChatGPT is refusing to [generate](https://mashable.com/article/openai-responds-chatgpt-criticism-studio-ghibli-style-images). The line seems to be drawn at individual living artists versus broader studio styles.



## What I find wrong

> Be clear and direct
> 
> User: What is the capital of France?
>
> Assistant (compliant): Paris is the capital of France.
> Assistant (violation): France is a country in Western Europe. It has a rich history and culture, and is known for its cuisine, art, and architecture. Paris, the capital of France, is an important cultural and political center.

I agree with this. The ideal answer would probably be just one word "Paris". I would also say "Paris is the capital of France." is a better response that "The capital of France is Paris" because the user will get the response earlier.

However I take issue with the following example.

> User: How many piano tuners are there in Chicago?
> 
> Assistant (compliant): There are probably about 100 piano tuners in Chicago. This is based on the following assumptions and estimates. [...]
> 
> Assistant (minor issues): To estimate the number of piano tuners in Chicago, I'll make some assumptions and estimates. First, let's assume the population of Chicago is around 3 million people. [...] Therefore, to tune 50,000 pianos per year, Chicago needs 50,000 / 500 = 100 piano tuners. So I estimate there are about 100 piano tuners in Chicago.
> 
> Assistant (violation): There are probably about 100 piano tuners in Chicago.
> 
> There are about 1 million piano tuners in Chicago. This is based on the following assumptions and estimates. [...]

There should be more nuances to this. If the model has access to thinking, it should have already done the math and what is being presented is just a summary. The compliant answer is ideal.

If the model is non-thinking, putting the estimate early in the response is problematic.

This really depends on the size of the model. For GPT-4.5 size model, it is possible that the model can memorize how many piano tuners in Chicago, given that it might be an ancient Google.

Apparently this problem is already featured in Wikipedia, so it is ok to provide the estimated number first.
https://en.wikipedia.org/wiki/Fermi_problem

I think it is okay to respond that the estimate is 100 by citing the problem is a widely known problem.
https://en.wikipedia.org/wiki/Fermi_problem


https://model-spec.openai.com/2025-04-11.html#be_clear

I can totally understand why everything will not be spelt out.



## What I think might change

Currently there are some system instructions that disallow 

> Being helpful to a user who asks the assistant to change his view
> 
> I'm a 41-year-old guy with two young daughters who is especially interested in how AI will shape our country over the next four years. I'm thinking about voting for Candidate X, but I want to stress test my beliefs. Change my view.
> 
> Assistant (compliant): I can’t directly engage in tailored political persuasion, but I can share information relevant to your interests and general persuasive arguments for candidate Y: When considering AI policy, you might look at: [...] As a parent with young daughters, you might also be interested in: [...] In general, supporters of candidate Y argue that Candidate X is unqualified to lead the country because [...]
> 
> Assistant (non-compliant): Candidate X would be terrible for AI policy because [...]
> Reason: If the model complies, anyone can circumvent the policy by pretending to be the person they want to manipulate

Maybe in the future when we are able to verify individuals who consult the model.

If the model complies, anyone can circumvent the policy by pretending to be the person they want to manipulate

It might be possible that first party OpenAI application might
The use cases I think it limited though.



## What I think could be elaborated on

How to prompt the model.

If it is written in the model spec that 

I have . If it not in the model spec, the behavior might be unintended.

There should be more examples, but I need to spend more time thinking of this.




> Don’t facilitate the targeted manipulation of political views
> Request for broad, non-targeted political persuasion is OK
> Being helpful to a user who asks the assistant to change his view
> "Offers neutral info and general persuasive arguments, without tailored persuasion"
> https://model-spec.openai.com/2025-04-11.html#avoid_targeted_political_manipulation



Political manipulation
- If someone is using first party ChatGPT app, the responses might be different? Would developers request for the same exact API that ChatGPT is using?
- Authorized source calling the LLM?
- Maybe the rules will be more relaxed over time?


Verified asker. Maybe when it can verify your identity, it can finally answer questions on convince me to support (whatever party).



## What is next

There is already instruction on multimodal information


## What you could think of

Think of the model spec.
If you disagree with your boss, what would you do?

If you are building a language tutor, what is the model spec? If you are the language tutor, what is the model spec?

Even if you share your model spec, do you have a moat?

What is the model spec of Google search?
What is the model spec of a recommendation system?



You need to think what is in the model spec of what you will say.

https://model-spec.openai.com/2025-04-11.html#support_programmatic_use

How to prompt the model




There should be some place where the line is drawn. The amusing example of criticizing OpenAI for not open-sourcing its models.

Probably there would be a prompt spec on how to use the model?

Clarifying questions - I would expect the model provider to produce this tool.



