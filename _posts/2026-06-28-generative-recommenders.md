---
layout: post
title: Design decisions of a generative recommender
---

Traditionally, recommendation systems retrieve and rank.
Generative models can help recommendation systems to retrieve and rank much better.

By now, there is plenty of literature of generative recommenders, and there are companies already productionizing generative recommenders [^PRS].

[^PRS]: I attended the [2026 Netflix Workshop on Personalization, Recommendation and Search](https://prs2026.splashthat.com/) (PRS), where LinkedIn, Pinterest and Netflix presented their generative recommendation system setup.

To understand literature on generative recommenders, you should be familiar with the design decisions of generative recommenders [^recsys-papers]. I write the key design decisions in this blog post.

[^recsys-papers]: Similarly, to understand papers in recommendation systems, you also need to understand the standard design of a recommendation system.
    You need to understand whether a paper is trying to improve the retrieval part or the ranking part of the recommendation system, or neither.
    Otherwise, you will just be very confused.


# Traditional recommendation systems

Traditionally, recommendation systems have two separate models for retrieval and ranking.

- The ranking model predicts a list of P(action), given features. 
    - Features generally come from three sources
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
    - The user two tower embedding is calculated with the retrieval model
    - Items with the most similar embeddings "candidates" are retrieved from the vector database
    - The list of P(action) is calculated for each candidate


# A baseline implementation of a generative recommender

I am describing an implementation of a generative recommender, not the implementation.
I think this implementation is the simplest end-to-end generative recommendation.
We will discuss design decisions of a generative recommender in future sections, with reference to this "baseline implementation".

All items are represented with a semantic ID triple.
- The number of possible semantic IDs is 1000.
    This means the number of possible semantic ID triples is 1 billion.
- There may be multiple items with the same semantic ID triple.
- There may be semantic ID triples that do not have items.
- The semantic ID design decision is out of scope for our discussion here.
    We assume we have an ideal set of semantic IDs.

All users are represented by their history of items.
- If you skipped item 1 (i1), clicked on item two (i2), the relevant part of the history would look like
    `(i1-s1) (i1-s2) (i1-s3) (skip) (i2-s1) (i2-s2) (i2-s3) (click)`
    - where `i2-s3` refers to the 3rd element of the semantic ID triplet of item 2.

- Offline processes
    - The generative model is trained to predict every next token in the sequence
    - During indexing
        - You calculate the semantic IDs of each item
        - You store ordered lists of semantic ID triples to items
            - You also store ordered lists of semantic ID prefixes to items
- Online processes
    - The generative model generates multiple semantic ID triplets to retrieve
        - Content with the same semantic ID will be retrieved
    - The generative model predicts the action token for the item
        - The P(skip), P(click), P(downvote)
        - There will be a value function that decides how to weigh the action probabilities
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
- There are tools that efficiently serve LLMs out of the box and form great benchmarks
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
        - There is a decision to be made
        - One implementation of Google uses eight (citation needed).
        - Eugene Yan's implementation uses 3 (cite his blogpost).
    - Include realtime information
        - Examples - freshness, popularity
        - We could have a token that indicates the popularity of the item
        - (Number of likes and upvotes at the time of interaction)
    - Include author information
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
- In the "baseline" implementation, each user is represented with an item-action pair sequence, and nothing else

Decisions
- Information to include
    - User context information
        - In what context was the user exposed to the item?
        - Examples: device type, entry point, time of day
    - Completeness of information
        - Not all actions by the user involve an item
        - Example includes going to the setting page to turn off notifications
- Handling excessive user context
    - We are likely to have users that have hundreds of thousands of interactions with the platform.
    - We need to decide what information to exclude


In the baseline implementation, the user is represented as a sequence like
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

In the baseline representation, the model will predict a set of semantic ID triplets.
Content matching the semantic ID triplet is retrieved.
If there is insufficient content, content matching a prefix of the semantic ID triplet is retrieved.

Unlike two tower, there is no embedding retrieval.

Decisions on semantic ID retrieval
- You want a set of semantic ID triplets for retrieval
- You can do something like greedy best-first search
    - You start with the greedy sequence (each token chosen in the triplet has the highest probability)
    - Then for each prefix you greedily choose the highest probability next token that is not already chosen
    - You end up with a set of semantic ID triplets with the highest probabilities
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

In a generative recommendation system, you can autoregressively generate the sequence.
The second content to recommend depends on the first content to recommend.
If you really like a creator, the system should not prevent you from showing consecutive content from the same creator.



### Pretraining

In the baseline implementation, training is done from scratch.
There is no need for the model to be good at English and semantic ID.

Decisions
- Model architecture
- Initialization weights
    - Maybe just start from random weights
    - Do you really need your model to be good at math or human language?
- What is masked
    - Do you really need to mask user device for example?
- Metrics that you should look at
    - Should you just look at validation loss?
- How often should you pretrain your model?
    - Pretraining is expensive.
        - For a model of X million activated parameters, each with an average sequence length of Y, for Z users, even without counting the quadratic attention term, you need at least XYZ floating point operations.
            - Note that each entry point of DLRM training is one interaction, whereas each entry point of generative recommender model pretraining is one sequence.
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

What do you want to analyze when you have your LLM

These are some analysis that you could do

- Attention weights
    - What tokens were used to predict the action token?
- What-if analysis
    - If the user had upvoted a content, would that change our prediction of whether the user likes the content
    - (assuming that the user also experiences and reacts in exactly the same way after the perturbation)
    - (You can also observe how all the logprobs would have independently changed)
    - (You can do this analysis in traditional recommender system)



### Migration

If your product uses the traditional recommendation system, you do not just migrate to the generative recommender in one shot.

You will need to start with the end in mind.

What would the eventual state look like?
You will need to make most of the design decisions early.

You need to justify your headcount and the compute expenditure.
You need to propose milestones that you promise to hit.

Possible milestones
- Semantic IDs
    - Reasonable clustering
- For the ranking model
    - Match action AUC in a similar setting as DLRM
    - As you increase more data, you can achieve better action AUC
- For the retrieval model
    - Match recall@K

What would the end state look like?
You do not want to migrate halfway and you will need to maintain both systems.
Will your company still even be around when you finish your migration?



### Iteration

Congratulations in advance on your migration to generative models.

This is still not the end, it is always likely there is room for improvement.

You want to design a system that can be easily iterated on.

These are components that could be iterated on
- Semantic ID
- Model architecture
- Sequence modelling (item and user representation)
- Post-training
- Value function

Let's say your entire system is built on semantic ID.
Then you find out that half the level one IDs are effectively useless because they map to spammy content.
If you want to replace the semantic ID, you need to replace the entire system.
You need to pretrain a model in parallel, you need to serve models in parallel.
Your A/B test will involve all the surfaces.
If you do not design your system to easily change and test any component, you will be stuck with those components.


# Conclusion

I hope this is a comprehensive list of the design decisions when building a generative recommender.


# Footnotes
