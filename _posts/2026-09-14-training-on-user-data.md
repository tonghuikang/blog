---
layout: post
title: What is meant by training on user data
---

There is a [controvesy](wikipedia URL) [^wikipedia] on whether AI has trained on mathematician's data.

I think it is a good time to understand the different ways your data could be trained on.

[^wikipedia]: There is Wikipedia page on this.
    Notice OpenAI claims nothing in two months, but the mathematicians has been using the software since a year ago.

John Schulman [noted](https://x.com/johnschulman2/status/2097440545853637108) that "there are different kinds of training on user data* with very different privacy/IP implications"

> - pretrain on user data, with users' tokens as prediction targets: high regurgitation risk, improper
> - use user prompts to distill large models into small ones: low regurg. risk, some companies probably do this
> - use user traces to construct RL tasks: low regurg. risk, because RL has low memorization abilities, but can extract customer IP, depending on how it's done. Ranges from benign "use explicit user feedback in reward model training" to invasive "upload user's coding environment and commit history to turn into rl envs"

This is how I break down "training on user data".

There are three different aspect on user data.

- Information
- Feedback
- Context



# User information

There are some arugments that this could help with how the user responds.
This might help to simulate how the user responds.

User input does not necessary mean the user prompt.
Tool output could be considered user input as well.

For example the tool output could be printing SSH keys [^guidance].
If you train on the output, you run the risk of regurgitating the SSH keys.

[^guidance]: It seems that recent coding agents (could you check whether is the instruction in the harness?) takes step to avoid printing the keys.

There might be some capability when training on user data.
(I think there a 2026 paper saying that training on command line output helps to improve performance on terminal bench?)
You get to better predict how the user responds.
Even so, I think you should still avoid 
There are more risks in training on user information.
User information might contain malicious instructions as well.
Late-stage training with user information make malicious behavior more likely.


The line here is to train on user data.

I hope that AI products can promise that they do NOT train on user information.
I do not think you need to train on user information to do well.
They should not need to.



# User feedback

The most crude way is that you ask the user to provide thumbs up or thumbs down to the input.
However such feedback is sparse.

I think intelligence would have been involved in collecting user feedback.

Similar to human interactions, you do not ask for explicit thumbs up or down.
You can interpret from the rest of the conversation, the body language and their actions.

It is possible that the agent runs a completion of ("is the user happy with the input")

This is used to judge the responses.

One crude implementation is this. 
There are a lot of biases in this approach.
For example you are serving two users,
one who is very friendly to the model and often sends appreciation,
one who often throws f-bombs at the model no matter how good the model is doing.
You should not just train on the trace

You probably do not every need user feedback to understand how well you have done.
When you learn to solve a mathematics problem, you can review the steps that you have taken.
You could tell yourself how well you have done, and then improve on it.

AI product should still provide affordances for users to provide feedback.
User feedback is still helpful to identify places where the model can improve.



# User context

The real world is full of tasks.

I think there is a lot of potential in training on user context in a way that is privacy preserving.

For a given trace, you can reroll every step in the user output.

You do not need the environment, you just need the user trace.
Of course, the trace can come from the environment.

The measurement here is whether AI is making the correct action at every step.

You are not reproducing user data as well.
It is possible that the AI needs to repeat the user private information, but the AI is not trained to memorize one.



# Conclusion

I hope AI products do NOT train on user information.

User feedback could be used to identify useful user context that could be used to train the model.
I think there is a lot of potential is using user context, combined with user feedback, to train models.

I believe that training on user context do not hurt user privacy.
The model just gets better at tasks you might be doing.
The model learns the best thing to do given the context.

We would still require user consent though.
The user does not necessary want the model to be better at the job that they do.
