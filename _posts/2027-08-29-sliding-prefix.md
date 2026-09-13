---
layout: post
title: Thoughts on sliding prefix
---

Recently there is paper that was published "Prefix Sliding for efficient test-time scaling".

I have some thoughts.



# What the idea actually is

You could achieve similar performance with lower compute by dropping the KV cache, without training.

This is based on the observation that the attention weights between the latest token and the middle tokens is very low anyway.

Even if the KV cache of the middle portion is completely dropped, the computed output state does not change much anyway.

This saves KV cache (because you no longer need to store the KV values of the full prefix),
and saves compute (because you do not need to dot product)

For the given constants
- N is the current length of the sequence
- L is the sum of the length of the prefix combined with suffix.

For full attention
- Memory grows up to O(N)
- Compute per additional token is O(N)

With sliding prefix
- Memory grows up to O(L)
- Compute per additional token grows up till O(L).

Where L is the sum of the length of the prefix combined suffix.

There are some assumptions
- You will never need to rollout from the middle.
- Only the prefix contains important information.


# Possible winning idea in AIMO3

I think someone could have won AIMO3 with this idea.

You will need to implement this however.
I think LLMs at the time should be powerful enough to implement without much supervision.

Opus 4 et al should be able to implement with reference.
I think GPT-5.6-sol could implement without reference.

vLLM, of course, does not support this



# Implementation details

This could have well been invented at the start of the year.


You will need to implement vLLM from scratch.

Notes on the user turn.

Notes on saving prefix.

Even though sliding window attention saves, it does not necessarily.

This is something like making global attention into starting-and-sliding window attention.

There are a lot of features in vLLM that we take for granted.
Therefore I see some sense in startups trying to optimize based on your inference pattern.






# Visualization ideas

By dropping the prefix, I wonder how would tokens change.
I would want to see which token in a 80k token (aimo.huikang.dev/tokens) would change.

I would expect performance for needle-in-a-haystack to drop very significantly.
(I think doing well in needle in a haystack is a non-goal in the critical path towards AGI.
AGI should be using tools to find the needle.)



# Training

I think training is a headache

Sliding window attention

You do not want to train the agent to hallucinate

This could have been the winning idea for AIMO.
I think this could reliably increase the points by two.



# Future directions

Agents should be able to consciously decide which tokens attend (???) to.
(Is this RLM?)



