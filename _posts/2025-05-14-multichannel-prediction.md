---
layout: post
title: The next generation model should be ambidextrous
---

I think this is worthy of being GPT-5.
I won't be surprised if this is called GPT-4a (a for ambidextrous) or GPT-4m (m for multichannel) though.



## Think of how you converse

If humans hold conversations like the current chatbot that is made of alternative user assistant pairs
- You only consume words
- You do not interrupt the other person at all
- You need to wait for the other person to stop before you start thinking
- You start talking after you finish thinking
- You only produce words

We don't converse like how the current chatbots do.

This is what humans do
- You look at body language of the person talking
- You could interrupt the person if appropriate
- While the other person is talking, you are thinking
- You present gestures or certain body language
- You words has a certain emphasis or tone
- While you are talking, you (should) read the facial expression of your audiences
- You may be multitasking - for example walking up the stairs, eating food, or even driving

Note that you have multiple input channels
- Voice input
    - The speaker's sound
    - Surrounding noise
- Visual input
    - The speaker's body language and gestures
    - The speaker's slides
    - Other actions going on in the environment
- Touch feedback
    - Whether are you actually stepping on something while walking
    - Whether do you feel the accelerating if you are driving
- Prior internal thoughts

Note that you have multiple output channels
- Voice output
    - What you voice
- Movements
    - Your body language and gestures
    - Background movement activity - e.g. walking
- Internal thoughts
    - Interpreting what the speaker said (almost always subconscious)
    - Interpreting what the speaker mean (usually subconscious)
    - Preparations to follow-up the conversation
    - Thought process irrelevant to the conversation - how to merge on the highway


Note that you have multiple input channels and multiple output channels.

Humans are multichannel.

We should train models that should at least be able to converse like humans.

The model should be multichannel. We can scale the number of channels.



## Difference between Omnimodality and Multichannel

OpenAI introduced [GPT-4o](https://openai.com/index/hello-gpt-4o/) on March 13, 2024. The 'o' in 4o refers to omnimodality.

The demo presented where you can video call the AI.

The AI takes in
- Prior text input
- Sound streaming input
- Video streaming input

The AI produces
- What you said
- What the model says
- Sound streaming output

I would agree that GPT-4o is already somewhat multi-channel.
The input is multi-channel - sound and video.
I am not too sure to what extent the output is multi-channel.
It is possible that a separate model is used to transcribe the utterances of the user and the model. 

However, there is still some shortcomings here.

- The set of input modalities is fixed and could not scale
- The model does not think and talk at the same time [^1]
- The model is not manipulate phyiscal objects at the same time

[^1]: OpenAI introduced [o1](https://openai.com/o1/) on September 12, 2024
    If you interact with the o-series models on OpenAI first-party app ChatGPT, or use their [reasoning summaries](https://platform.openai.com/docs/guides/reasoning?api-mode=responses#reasoning-summaries), the model thinks and "talk" at the same time.
    In some sense, the o-series models is somewhat multi-channel.
    I am not sure if the o-series models is the one producing the reasoning summaries.

The model is not truly multi-channel.
We want the model to be natively multi-channel.




## Architecture

I think the architecture will be very similar to the standard decoder architecture.

Instead of one stream of inputs

You can have the model to wind-up and wind-down on demand.


## Think of how humans are ambidextrous


## Everything could still be modelled as a next token prediction



## Robotics


## Training

Imitation learning

The chain of thought is mostly synthetic data and we could train on it.



## Inference

Reading might not be easily parallelizable anymore?





## Consciousness

In this definition, consciousness is the ability to produce interpretable tokens that the model itself could interpret.


## Signs

OpenAI response API







The environment is a sampler


Omnichannel etc
You think while you speak
You interpret what people say while you speak



When I was in undergrad I was informed - (cite Ilya's video) - if you can predict the next token, you understand.

Next token prediction could be a lot of things. Jason Wei's slides?

When you write the first token you already somewhat planned what to do at the end.

Some tokens are easier than the others

Everything can be formulated as next token prediction (as long as the output is next)

Diffusion?
Image generation?
Voice?

Large concept models?

At this point it is somewhat of a ___
"Everything follow the law of Physics"
"God has a plan for everything"
If it doesn't you just redefine your task


You can train a model to predict the next prime number of a large prime number, but this does not mean you should.
You should still train the model to either use tools to calculate, or use reasoning to calculate by hand.





