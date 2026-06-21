---
layout: post
title: Design decisions of a generative recommender
---

There was a PRS recently - https://prs2026.splashthat.com/

I made this some time ago https://tonghuikang.github.io/x-algorithm/retrieval.html

Multiple companies are productionizing generative recommenders


I assume that you are familiar with the key ideas of a traditional recommendation system.
- Retrieval and ranking
- Please refer to YouTube playlist.


# Traditional recommendation systems

Traditionally, recommendation system have two separate models for retrieval and ranking.

- The ranking model predicts a list of P(action), given features. 
    - Features generally come form three sources
        - user features (account age, last interacted content)
        - item features (item popularity, item topics of the most recent interacted content)
        - interaction features (whether the user "follows" the author)
    - Features generally fall into two types
        - dense features - each dense feature is a float number
        - sparse features - each sparse feature is a list of integers
- The retrieval model "two tower model" produces a pair of embeddings
    - a user two tower embedding for a user given user features
    - an item two tower embedding given item features
- During offline processes
    - Ranking model is trained
    - Retrieval model is trained
    - Item two tower embeddings are calculated with the retrieval model, indexed in a vector database
- During online query
    - The user two tower embeddings is calculated with the retrieval model
    - Items with the most similar embeddings "candidates" is retrieved from the vector database
    - The list of P(action) is calculated for each candidate


# One design implementation of a generative recommender

All items are represented with semantic IDs triple.
- The number of possible semantic IDs is 1000.
    This means the number of possible semantic IDs triple is 1 billion.
- There may be multiple items with the same semantic IDs triple.
- There may be semantic IDs triple that does not have items.
- The semantic ID design decision is out-of-scope of our discussion here.
    We assume we have an idea set of semantic IDs.

All users are represented by their history of items.
- If you skipped item 1, clicked on item two, the relevant part of the history would look like
    `(item-1-s1) (item-1-s2) (item-1-s3) (skip) (item-2-s1) (item-2-s2) (item-2-s3) (click)`

During retrieval
- TODO

During ranking
- TODO


Key ideas of generative recommender
- Train on the sequence
- For a user with k interactions, the user is one sequence in the dataset
- Everything is tokenizable
- The idea that training on a sequence trains on many objectives at the same time (cite Jason Wei blog)
- Inputs are variable length tokens
- The outputs are tokens
- Generalizable

What you should avoid in a generative recommender
- Use of embeddings as input
- Use of embeddings as output
- Feature engineering
- (There is no point "derisking" with a transformer module - either you go all-in or do not bother trying)

First principles
- A quant with access to numbers and produce the best information
- Recommending long term history
- There is no reason why a generative recommender cannot outperform normal recommenders


# Key motivations

One model to rule them all
- New product surface can reuse the user history and recommender model
- DLRM cannot do this
- Easier maintainability (if done correctly)
- If you want to continuously train the model, you only train one model.

One value to rule them all
- No more constraint system

Infrastructure and tooling for LLMs
- There are tools that efficiently serves LLMs out of the box and form great benchmarks
- You can actually see how individual parts of the history affect the final prediction

Interpretability
- It is much easier to perturb sequence history than features.



# Design decisions

Item representation
- Pure ID
    - Not sustainable with many items
- Semantic ID
    - (please refer to eugeneyan blogpost on the full implementation)
- Item realtime information
    - Number of likes and upvotes at the time of interaction
- Author information
- Interaction information
    - Whether you follow the author at the time of impression

You want to be explict if you are not including certain information.


User representation
- Is a user merely a sequence of items
- User signup information
- User realtime information
    - User device
    - Should allow null to be encoded

What is the user history exceeds the token length?


Sequence modelling
- What exactly is the input
- What exactly is the output
- "Fuck you, show me the prompt"


Autoregressive generation
- Do you generate the recommendations autoregressively?
- Constrained generation
    - Force certain elements at certain steps


Pretraining
- Do you really need your model to be good at math or human language?
- What is masked
    - Do you really need to mask user device for example?


Posttraining
- What offline metrics do you look at?


Migration
- Milestones. What do you measure?
- How do you justify your investment?
- What hypothesis are you testing? How do you justify failure?
- Do you really want to replace both 
    - Feature parity?
    - No features needed? (It is easier to migrate to a generative recommender than to migrate from a generative recommender)
    - Unlike traditional rankers you need to log features (and ideally the features are logged realtime)


Analysis
- This is more interpretable than DLRM
- "Prompt engineering"
- You can read the logprobs
- What-if analysis
    - If the user had upvoted a content, would that our prediction whether the user likes the content (assuming that the user also experience and react exactly similar after the perturbation)
    - (You can also observe how the all the logprobs would have independently change)
    - (You can do this analysis in traditional recommender system)


Iteration
- Shipping is not the end
- You want a hill-climbable system
- You need to be able to iterate
- Good luck with changing semantic ID
    - Maybe we can freeze the first two IDs, and tune the third and fourth
    - It is ok to have items map to multiple semantic IDs
    - Productionization of semantic ID is out of scope
    - LLMs do not change tokenizers
- Do you want to throw out the entire codebase on every iterations?
    - Do you want to juggle abstractions
    - Only AI needs to understand the code

