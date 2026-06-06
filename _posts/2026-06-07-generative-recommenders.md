---
layout: post
title: Design decisions of a generative recommender
---

There was a PRS recently - https://prs2026.splashthat.com/

I made this some time ago https://tonghuikang.github.io/x-algorithm/retrieval.html

Multiple companies are productionizing generative recommenders

What is considered a generative recommender
- Inputs are tokens
- Outputs are tokens

First principles
- A quant with access to numbers and produce the best information
- Recommending long term historyx


# Design decisions

Item representation
- Pure ID
- Semantic ID
    - (please refer to eugeneyan blogpost on the full implementation)
- Item realtime information
- Author information
    - Elon Musk tweeting 67 versus me tweeting 67
- Interaction information


User representation
- Is a user merely a sequence of items


Sequence modelling
- TBC
- "Fuck you, show me the prompt"


Autoregressive generation
- TBC


Pretraining
- TBC


Posttraining
- TBC


Migration
- Milestones. What do you measure?
- How do you justify your investment
- Offline metrics


Iteration
- Shipping is not the end
- You need to be able to iterate
- Good luck with changing semantic ID
    - Maybe we can freeze the first two IDs, and tune the third and fourth
    - It is ok to have items map to multiple semantic IDs
    - Productionization of semantic ID is out of scope
- LLMs do not change tokenizers
- Do you want to throw out the entire codebase on every iterations?
    - Do you want to juggle abstractions
    - Only AI needs to understand the code

