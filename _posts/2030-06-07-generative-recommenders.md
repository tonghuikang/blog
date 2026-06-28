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
- Offline processes
    - Ranking model is trained
    - Retrieval model is trained
    - Item two tower embeddings are calculated with the retrieval model, indexed in a vector database
- Online queries
    - The user two tower embeddings is calculated with the retrieval model
    - Items with the most similar embeddings "candidates" is retrieved from the vector database
    - The list of P(action) is calculated for each candidate


# An baseline implementation of a generative recommender

I am describing a implementation of a generative recommender, not the implementation.
I think this implementation is the simplest end-to-end generative recommendation.
We will discuss design decisions of generative recommender in future sections, with reference to this "baseline implementation".

All items are represented with semantic IDs triple.
- The number of possible semantic IDs is 1000.
    This means the number of possible semantic IDs triple is 1 billion.
- There may be multiple items with the same semantic IDs triple.
- There may be semantic IDs triple that does not have items.
- The semantic ID design decision is out-of-scope of our discussion here.
    We assume we have an idea set of semantic IDs.

All users are represented by their history of items.
- If you skipped item 1 (i1), clicked on item two (i2), the relevant part of the history would look like
    `(i1-s1) (i1-s2) (i1-s3) (skip) (i2-s1) (i2-s2) (i2-s3) (click)`
    - where `i2-s3` refers to the 3rd element of the semantic ID triplet of item 2.

- Offline processes
    - The generative model is trained to predict every next token in the sequence
    - During indexing
        - You calculate the semantic IDs of each item
        - You store ordered lists of semantic ID triple to items
            - You also store ordered lists of semantic ID prefixes to items
- Online processes
    - The generative model generates multiple semantic ID triplets to retrieve
        - Content with the same semantic ID will be retrieved
    - The generative model predicts the action token for the item
        - The P(skip), P(click), P(downvote)
        - There will be a value function that decides how to weigh the action probabilties
            - For example P(skip) + 10 * P(click) - 100 * P(downvote)


# Key benefits of a generative recommender

One model for inputs
- For a user with k interactions, the user is one sequence in the dataset
- The idea that training on a sequence trains on many objectives at the same time (cite Jason Wei blog)

One model for outputs
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

### Item representation

In the "baseline" implementation, each item is represented with a semantic ID triplet, and nothing else.

Design decisions in the item representation
- Information to include
    - Pure ID
        - Each item has its own ID
        - This is not sustainable in large scale recommendation systems
    - Semantic ID
        - There is a decision to be
        - One implementation of Google uses eight (citation needed).
        - Eugene Yan's implementation uses 3 (cite his blogpost).
    - Include realtime information
        - Examples - freshness, popularity
        - We could have a token that indicate the popularity of the item
        - (Number of likes and upvotes at the time of interaction)
    - Incldue author information
        - We could have something like an author semantic ID
        - We could include the popularity of the author
    - Include interaction information
        - Whether you follow the author at the time of impression

Putting it together

In the baseline implementation the item 
```
(i1-s1) (i1-s2) (i1-s3)
```

With the augmentation I described
```
(i1-s1) (i1-s2) (i1-s3) (age-s1) (popularity-s1) (author-s1) (followed-s1)
```

Note the order of the augmented information.
I place the augmented information after the semantic ID triplets.
The augmented information is only available after retrieving with the semantic IDs.


### User representation
- In the "baseline" implementation, each user is represented with item-action pair sequence, and nothing else

Decisions
- Information to include
    - User context information
        - In what context was the user exposed to the item?
        - Examples: device type, entry point, time of day
    - Completeness of information
        - Not all actions by the user involves an item
        - Example includes going to the setting page to turn off notifications
- Handling excessive user context
    - We are likely to have users that have hundreds of thousands of interactions with the platform.
    - We need to decide what information to exclude


In the baseline implementation the user is represented a sequence like
```
(i1-s1) (i1-s2) (i1-s3) (skip)
(i2-s1) (i2-s2) (i2-s3) (click)
```

With the augmented information, the user is represented with something like
```
(visit homepage) (device-id-s1) (referral-id-1)
(i1-s1) (i1-s2) (i1-s3) (skip)
(i2-s1) (i2-s2) (i2-s3) (click)
(follows author-1)
(installs app)
```

### Retrieval

In the baseline representation, the model will predict a set of semantic ID triplet.
Content matching the semantic ID triplet is retrieved.
If there is insufficient content, content matching a prefix of the semantic ID triplet is retrieved.

Unlike two tower, there is no embedding retrieval.

Decisions on semantic ID retrieval
- You want a set of semantic ID triplets for retrieval
- You can do something like greedy best-first search
    - You start with the greedy sequence (each token chosen in the triplet has the highest probability)
    - Then for each prefix you greedily choose the highest probability next token that is not already chosen
    - You end up with a set of semantic ID triplet with the highest probabilities
- There are likely other strategies
    - You can validate this by figuring out which strategy maximizes the value function later


### Ranking

In the baseline representation, the model will predict the action probabilities
```
(i1-s1) (i1-s2) (i1-s3) (skip)
(i2-s1) (i2-s2) (i2-s3) (?)
```

In traditional recommendation systems, you do pointwise ranking.
You rank everything at once.
You apply some business rules such that you do not show the same creator twice.

In generative recommendation system, you can autoregressively generate the sequence.
The second content to recommend depends on the first content to recommend.
If you really like a creator, the system should not prevent you to show consecutive content from the same creator.



### Pretraining

In the baseline implementation, training is done from scratch.
There is no need for the model to be good at English an semantic ID.

Decisions
- Do you really need your model to be good at math or human language?
- What is masked
    - Do you really need to mask user device for example?
- Metrics that you should look at
    - Should you just look at validation loss?
- How often you should pretrain your model?
    - Pretraining is expensive.
        - For a model of X million activated parameters, each with an average sequence length of Y, for Z users, even without counting the quadratic attention term, you need at least XYZ floating point operations.
            - Note that each entry point of DLRM training is one interaction, whereas each entrypoint of generative recommender model pretraining is one sequence.
            - In one backward pass for a sequence, you are training the model to predict the whole sequence, which usually contains many interactions.
    - You might want to pretrain a model every month.
    - You might want to pretrain a model as you add richer sequences
        - Maybe your first implementation of the generative recommender is the "baseline" recommender, which is shipped to everyone.
        - Then you want to add richer sequence information


### Posttraining

You might be doing this every day, or even continuously.

Decisions
- Should you serve only one post-trained model?
    - Of course in A/B testing you should serve multiple post-trained models
    - Should ranking and retrieval use the same post-trained model?
    - Should different surfaces use the same post-trained model?
- What offline metrics should you look at?


### Analysis

- This is more interpretable than DLRM
- "Prompt engineering"
- You can read the logprobs
- What-if analysis
    - If the user had upvoted a content, would that our prediction whether the user likes the content (assuming that the user also experience and react exactly similar after the perturbation)
    - (You can also observe how the all the logprobs would have independently change)
    - (You can do this analysis in traditional recommender system)


### Migration

- Milestones. What do you measure?
- How do you justify your investment?
- What hypothesis are you testing? How do you justify failure?
- Do you really want to replace both 
    - Feature parity?
    - No features needed? (It is easier to migrate to a generative recommender than to migrate from a generative recommender)
    - Unlike traditional rankers you need to log features (and ideally the features are logged realtime)
- (There is no point "derisking" with a transformer module - either you go all-in or do not bother trying)


### Iteration

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

