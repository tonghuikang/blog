---
layout: post
title: The next generation model should be multichannel
---
I explain how humans are multichannel, and how models could be multichannel too.


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


## Natively multichannel

I explain my expectation of what is meant by natively multichannel.

The model should be able to
- Spin up modalities
- Wind down or suspend modalities
- Decide their output modalities
- Decide the extent of parallelization of the modalities

TODO: explain

TODO: explain how this can be used as a visual assistant

TODO: explain how this is used in robotics


## Architecture

I think the architecture will be very similar to the standard decoder architecture, with the following differences
- Instead of one stream of inputs, you have multiple stream of inputs.
- Instead of one stream of outputs, you have multiple stream of outputs

I think the rest of the architecture would look similar.

There is this question of whether the outputs should be parallelized.

If you are driving and talking to your front-seat passenger, the two process would not depend on each other. In this case, you can parallelize the driving-related outputs and the conversation-related outputs.

If you are thinking and talking, your thought process needs to align with what you say. I present a scenario. You are in this rapid fire conversation where you answer questions quickly. You are asked - what is your favorite color. You don't really have a favorite color, your verbal response is 50% red and 50% blue. The thought process is also 50% red and 50% blue. If we sample both tokens in parallel, your what you thought is different from what you said.[^k] Ideally, we should sample the thought token first, and then the verbal token so that the verbal token can depend on the thought token.

[^k]: This might be a human experience as well. Also, I think I need a better example.

TODO: example of how the generation would look like



## Evaluation

TODO

The rewards are not longer that verifiable?

You are grading a presentation rather than whether they solve a math model.



## Training

TODO

Training is harder because you need to replay the scenario while training.



## Footnotes

