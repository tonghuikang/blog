---
layout: post
title: The next generation model should be multichannel
---

I explain how humans are multichannel, and how models should be multichannel too.


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
    - What you utter
- Movements
    - Your body language and gestures - including the intention to interrupt, and whether to be interrupted
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
- Spin up channels
- Wind down or suspend channels
- Decide to spin up and wind down channels
- Decide the extent of parallelization of the channels

I would demonstrate this capability with these use cases initially.
- An interviewer with social awareness (elaborated below)
- A natively multichannel coding agent

Let's say the AI is assigned an interview someone. Someone who has played a key role in training a system that solves all competitive programming problems better than any human in the world - and achieving this feat from near-zero knowledge on competitive programming.

The AI did their own research - reading up the interviewee's previous publications, the official blog posts, and also online discussions about the impact.
	
The interview between the AI and the human starts. The interview is a video call.
The AI has an avatar. It could be a circle, it could be an anime-style character, or it could be a photorealistic human. It starts of with a few easy questions.

While the interviewee is talking, the AI is not idle. This is what the AI is doing
- Parsing what the interviewee is saying
- Researching for additional context of what the interviewee meant
- Interpret what the interviewee wants to talk more about

The AI may want to interrupt the interviewee. These are scenarios where interruption is appropriate
- The interviewee appears uncomfortable (through body language) about sharing certain information.
- The interviewee repeats information that is already published elsewhere and we do not see anything new being added.

The AI could display "body language" that signals its intention.
The intention to interrupt is ultimately not really that binary - it is an spoken negotiation between the conversation participants.
Again, the model should be able to interpret the extent to which the interviewee is responsive to the AI's body language.

All these happens on a single model.



## Architecture

I think the architecture will be very similar to the standard decoder architecture, with the following differences
- Instead of one stream of inputs, you have multiple stream of inputs.
- Instead of one stream of outputs, you have multiple stream of outputs

I think the rest of the architecture would look similar.

There is this question of to what extent the outputs should be parallelized.

If you are driving and talking to your front-seat passenger, the two process would not depend on each other. In this case, you can parallelize the driving-related outputs and the conversation-related outputs.

If you are thinking and talking, your thought process needs to align with what you say. I present a scenario. You are in this rapid fire conversation where you answer questions quickly. You are asked - what is your favorite color. You don't really have a favorite color, your verbal response is 50% red and 50% blue. The thought process is also 50% red and 50% blue. If we sample both tokens in parallel, your what you thought is different from what you said.[^k] Ideally, we should sample the thought token first, and then the verbal token so that the verbal token can depend on the thought token.

[^k]: This might be a human experience as well. Also, I think I need a better example.



## Initial training

The first step of making a multichannel model is to roleplay as one.

The process will follow this pattern
- Bootstrap the initial expected outputs with the current models
- Train a multichannel model to produce the bootstrapped outputs
- Develop an evaluation framework
- Iteratively improve the multichannel models

I think the models these days are powerful enough to roleplay as multichannel models - just the resulting performance could be far more improved. Similarly, I think it is possible to get models from early 2024 to roleplay as reasoning models (o1 was released in September 2024) - just that the performance is not as good as the later o-series models. [^3]

[^3]: There are papers in 2025 that suggests by finetuning a base model lightly, the model can perform as well as the initial o1 model (citation needed).

I think there are some models that could be trained as exercise, if not already done
- For the 4o model that powers the realtime voice assistant - try also training the model to natively produce text on what the user has said and what the assistant has said. This task should be quite verifiable.
- For the o-series models that powers reasoning, instead of using a separate model for summaries or interleaving summaries and actual actions, generate the summary in a separate channel.

These exercises should validate that we can indeed train models with multichannel outputs.

We can then proceed with more meaningful multichannel outputs.
- The internal thought process. This is like generating subtitles to the conversation live - instead of what is said, we infer what is thought. We want to monitor whether the thought process makes sense.
- Body language. This is like imagining how the body language would look like in an audio podcast. Again, we want to monitor whether the body language makes sense. This could help to animate the model, and make talking to the model a better experience.



## Evaluation

As always, if you cannot evaluate what is better, you cannot improve.
The same rule also applies to multichannel models.

For most of the current LLMs, the LLMs works on problems undisturbed.
However, multichannel models interact with the users.

The process to properly evaluate multichannel models, would be different from evaluating the current LLMs.

For the multichannel models, the model affects how the user will respond in the next few seconds, and the actions from the user will affect what the model should be generating.

It becomes a chicken-and-egg problem - you need a good multichannel model to evaluate a good multichannel model.

For example, you want to make your multichannel model to have the capability to interview someone and extract valuable information for publication. You need to build a multichannel model that simulates the interviewer. The objective here is the amount of information you manage to extract.

Assume with the initial training we could we a working model that is able to simulate a live interview.

Now we need to model the rewards so that we can tune the model in the correct direction.

Since we have an objective of extracting useful information, we could have something like an outcome reward.
This outcome reward is analogous to obtaining the correct answer by the reasoning models.
We need to be careful on what is meant by useful information here.
For example, getting the interviewee to say more words does not mean the information is useful.

We might want to assign some process reward.
This process reward is analogous to evaluating whether the model has made the correct step in the reasoning.
This evaluates whether the model is making the correct actions given a context.
Should the model interrupt the interviewee? Were good questions (definition needed) asked by the AI?
We also want to review the internal thoughts of the model.
We need to write standards, and give examples for these standards, and grade according to these standards.
We can then use these standards to iteratively improve the model.



## Scope of use

We want models to be superhuman at communicating with humans.

The main benefit of multichannel models is to achieve most efficient possible communication with humans.
Again, there are no rules in Physics or theoretical computer science that we cannot achieve this.

I would expect a vast majority of the token we generate will still be in the single channel setting.
Achieving better performance at hard reasoning tasks is a non-goal.
The key advantage of multichannel models intelligence with a low input/output bitrate (i.e. humans).

Another place I think multichannel models would be useful is when you have asynchronous tasks.
The human could ask the model to fix a bug in the codebase, and leave the model undistributed at the task.
However, to reproduce the bug it needs to run a bunch of terminal commands which takes time.
While the commands are running, the model should make progress towards the task - by reading the code.
The model should also be streaming the terminal logs as well to identify issues in the log.
If the model is multichannel, it could be more efficient at solving the bug - even though the model is working undisturbed.

Ultimately, I think the benefit for efficient communication with humans already justify this research direction.
Similar to how communication is a bottleneck of humans cooperating with each other, communication will become a bigger bottleneck of how we interact with AI.


## Footnotes

