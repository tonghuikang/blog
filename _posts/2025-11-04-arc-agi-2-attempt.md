---
layout: post
title: My attempt on ARC-AGI-2
---

Here I share the motivations and lessons behind my attempt at [ARC-AGI-2](https://arcprize.org/arc-agi/2/)

To be upfront, my accuracy score on the evaluation set is [zero](https://www.kaggle.com/code/huikang/arc-agi-2-code-approach/).
I also do not claim to have improved performance even on the data I have trained on.

In any case, these are my contributions, in two html files

- Golden solutions partial dataset - [arc.huikang.dev](https://arc.huikang.dev/)
- Finetuning dashboard - [traces.huikang.dev](https://traces.huikang.dev/)

I hope this is interesting.

The code is [here](https://github.com/tonghuikang/arc-agi-2).


## What I am betting on

This is what I observe

- LLMs are already good at LeetCode problems.
    In addition, it seems that LLMs can solve LeetCode even without a dedicated thought process. 
- The code solutions to ARC-AGI problems is not much harder than LeetCode problems.
    There are no advanced data structures.
    There is no need to optimize for time complexity.
    There are no edge cases that you find out and think through.
    Most of the time, you just need to put for loops in the correct places.
    For half of the ARC-AGI-2 eval set problems, I think I can write the code in under 10 minutes.

I thought that I could easily achieve 6% just by lightly aligning the LLMs. As you can see, this is much harder than expected.

I see writing or following a procedure[^LLM-only] to be the way to solve ARC-AGI. As a human, you solve ARC-AGI with a process. You copy the input, change the grid size, change some colors - you follow some procedure. The procedure can be codified, with code.

[^LLM-only]: Even if we have a LLM-only solution to solve ARC-AGI, it will involve the LLM reasoning by the coordinates, and making one operation at a time.
    Instead of writing code and executing it, it simulates the execution of the code.



## General approach

This is my approach

- I create a set of "golden" solutions
- I use the golden solutions to guide the reinforcement learning



## Golden solution

This is one golden solution [example](https://arc.huikang.dev/?task=007bbfb7)


```python
def solve(grid: list[list[int]]) -> list[list[int]]:
    """
    Observation:
    1. Input is an n×n grid (in all examples, n=3)
    2. Output is an (n²)×(n²) grid (for n=3, that's 9×9)
    3. The output is conceptually divided into an n×n array of blocks, each block is n×n
    4. For position (i,j) in the input grid where grid[i][j] != 0, the block at position (i,j) contains a complete copy of the input
    5. For position (i,j) where grid[i][j] == 0, the block at position (i,j) is all zeros

    Procedure:
    1. Get the dimension n of the input grid
    2. Initialize an (n²)×(n²) output grid with zeros
    3. For each position (i,j) in the n×n input, if the value is non-zero, copy the entire input grid into the corresponding block starting at output row i*n, column j*n
    4. Return the output grid
    """

    n = len(grid)
    output_dim = n * n
    output = [[0] * output_dim for _ in range(output_dim)]

    # Iterate through each position in the input grid
    for block_row in range(n):
        for block_col in range(n):
            # Check if this position has a non-zero value
            if grid[block_row][block_col] != 0:
                # Calculate the starting position of this block in the output
                start_row = block_row * n
                start_col = block_col * n

                # Copy the entire input grid to this block
                for r in range(n):
                    for c in range(n):
                        output[start_row + r][start_col + c] = grid[r][c]

    result = output
    return result
```

There are multiple parts to this golden solution

- The function signature. `def solve(grid: list[list[int]]) -> list[list[int]]:` Import statements are expected to be inside the function definition.
- Observations.
    I intend the trivial observations to be listed earlier.
    I do not intend subsequent observations refute prior observations.
- Procedure. What the code should do.
    This should describe the overall approach to map the input to the output.
- Code, probably with comments.
    Inner function definitions and import statements are allowed.
    It is intended that the code follows the described procedure.
    When writing code, the model is not supposed to discover whether the procedure is wrong.
- Return statement `return result`


Note that there is no thought process involved.
The observations and the procedure is intended to be the thought process.

Note that I do not leave space for the model to reflect on its own outputs.
There is no "Wait, I might be wrong, the correct observation should be ...".
This will mean that it is inevitable that the model can be wrong and is not able to fix its mistakes.
However, there is also a check at the end where I will run the code to confirm if it is correct on the example test cases.
I just need the model to be right in approximately 1 in 64 times.



## Prompting

When I ask the LLM to generate the solution, I have a prompt. The prompt looks like this

```
<|im_start|>user
Implement a Python function that maps the input to the output.

The function docstring should include
- some key observations
- the general procedure

def solve(grid: list[list[int]]) -> list[list[int]]:
    """
    Observations:
    1. Mention the key patterns in the input and output
    2. (other key patterns)
    3. ...
    ...

    Procedure:
    1. Mention key steps involved in solving the problem
    2. (other key patterns)
    3. ...
    ...
    N. Return the result
    """

    <implementation of the procedure here>

    return result

Do not write anything else outside the function.


- Example 1 -

Example input 1:
000
077
000

(transposed view):
000
070
070

Matrix size: 3 x 3

Example output 1:
000000
077770
000000

(transposed view):
<transposed view>

Matrix size: 3 x 6

{other example cases, and also the test cases}

<|im_end|>
<|im_start|>assistant
def solve(grid: list[list[int]]) -> list[list[int]]:
    """
    Observations:
```

I describe some characteristics of my prompt

- The deliverable is simple - write a function.
    There is no requirement to use my predefined functions.
    The model already knows how to transpose a matrix.
- The assistant prefix.
    The function signatures tells the model that is the input and output.
    By ending with `Observations:`, I want the model to go straight into writing observations.
- Input matrix.
    I provide the inputs as numbers.
    I think the tokenizer for the model I am using (`Qwen3-4B-Instruct-2507`) already treats individual numbers as a token each.
    I also provide the transposed matrix.
    I hope with the transposed matrix it is easier for the model to see which cells are above one another.
- Input features.
    I provide information on the matrix size.
    I considered adding a lot more features, to inform the model what to try.
    These are some features that I have considered - where the symmetry is, number of islands, the size of each islands, what the shapes are, repetition patterns.
    However, I do not want to add these features early because it adds to the prompt input size.
    With a longer prompt input size, I need more GPUs to finetune.
    I want to prove that I am able to solve some problems first, before adding the features.

I hope the model can work with this prompt and probably generate a function that is able to map the example input to the example output. If the function could map the example input to the example output without hardcoding, the function should be able to map the test input to the test output.



## Training procedure

This is the training procedure I eventually settled with.

- The last `k` tokens of the golden solution is redacted.
- With the last `k` tokens missing, I sample the next tokens `{t}`.
    The teacher token from the golden solution is added to the set of tokens.
- For each token in `{t}`, I do multiple rollouts.
    - For each rollout, the rollout reward is one if the solution is correct. The reward is zero if the solution is wrong.
    - The action reward for each token `t` is the average over its rollout rewards.
- With the action rewards, the advantage for each sampled token `t` is calculated.
- If the advantage is positive, I will train the model to increase the probability of generating the token. If the advantage is negative. I will train the model to decrease the probability of generating the token.
- The value `k` is updated. Whether I increase or decrease `k` depends on the state reward. The state reward is the weighted probability average of action rewards.


There are some modifications from the GRPO-style reinforcement learning. What is different here:

- The action is one token, not the whole sequence.
- I removed the G-term, the O-term, the KL term.
- The advantage value is normalized to either 1, 0 or -1.
- The advantage calculation is different. Even if the reward of the action is positive, I may not be confident in the reward. (For example, if you have a pair of 8 rollouts, one with 4 correct and one with 5 correct, how confident are you that one is really better than the other?)
- The clip value is different. For positive advantage, I attempt to halve the logprob (there will be adjustments so that the sum of probabilities is still one). For negative advantage, I attempt to increase the logprob by two. After each iteration of training, I check whether the logprob has indeed moved to where I intend it to move.

I describe my motivations behind my changes to GRPO in this [blog](https://blog.huikang.dev/2025/10/28/group-relative-policy-optimization.html).



## Visualizing the training

Instead of numbers, I want to look at the data.
I hope more people look at the data, and make it easy to look at the data.

Let me walkthrough the visualization.

- The default [view](http://traces.huikang.dev/), which you can filter by [problem](http://traces.huikang.dev/?problem=1fad071e) and redaction [length](http://traces.huikang.dev/?problem=1fad071e&redacted=201).
- The prompt modal, which is accessible by clicking on the problem hash.
    The darker the color, the larger the token logprob.
    The color indicates whether the currently tuned model produce a higher completion probability for the token.
    If you mouseover a token, you can see the logprob from tuned model and the logprob from the reference model.
- The completion modal, which is accessible by clicking on the squares.
    Each completion is one token.
    Similarly, if you mouseover the token, you can see the tuned model probability and the reference model probability.
    I have one completion modal for each action.
    The completion modal shows the completion (action) reward, as well as my measure of confidence for the action. 
    Then the rollout information follows. It shows the full function for the completely rolled-out text, and the rollout reward.


The visualization surfaces common mistakes made by the model.

- [f2829549](https://arc.huikang.dev/?task=f2829549) is about finding cells that are not colored in either partition.
    - The model would [initially](http://traces.huikang.dev/?problem=f2829549&redacted=68) compare with the first column with the last column.
    - The correct solution involves comparing the first column with the fourth column.
- [6150a2bd](https://arc.huikang.dev/?task=6150a2bd) is about rotating the model by 180 degrees.
    - The model would [initially](http://traces.huikang.dev/?problem=6150a2bd&redacted=172) rotate 90 degrees
- [ed36ccf7](https://arc.huikang.dev/?task=ed36ccf7) is about rotating the matrix by 90 degrees.
    - The model would [initially](http://traces.huikang.dev/?problem=ed36ccf7&redacted=96) rotate the wrong direction.


The visualization surfaces some words that are important in context.

- [1fad071e](https://arc.huikang.dev/?task=1fad071e) counts the number of 2x2 blue blocks.
    - The model would [initially](http://traces.huikang.dev/?problem=1fad071e&redacted=201) generate " list" in the sentence "Return as a single-row list".
    - The golden solution suggests a space " " which sets up the generation of " 1x5 matrix".
    - However, the space is not necessary the only optimal next character to generate. If the model generates " matrix", the model can get an increase in reward.
- [5582e5ca](https://arc.huikang.dev/?task=5582e5ca) is about finding the most common element.
    - The model would [initially](http://traces.huikang.dev/?problem=5582e5ca&redacted=158) generate "examples" in "In all examples, the final output grid ..."
    - The sentence in the golden solution is "In all training examples, the most frequent value appears exactly 3 times."
    - My algorithm explores other tokens that are also able to achieve a significantly higher than average reward, such as " given", " test", " the", " provided", along with " training" from the golden solution.
    - This way we do not only encourage the model to generate the token from the golden solution, but also other tokens with significantly better reward.

I hope people look at what exactly are they training on, and whether they have achieved the training objective.
When people share the results, I hope they also share some illustrative examples from the data[^data].

[^data]: I published a game visualizer for a Kaggle simulations [competition](https://www.kaggle.com/code/huikang/kore-2022-match-analysis/output?select=gameplay.gif) back in 2022.
    This was made into a popular tool for the [competition](https://www.kaggle.com/competitions/kore-2022/discussion/323495).


## Implementation

I need to decide on level of abstraction to work with.

There are these levels of abstraction that I could have worked with
- You do not finetune the model at all.
    People won cash prizes in [AIMO 1](https://www.kaggle.com/competitions/ai-mathematical-olympiad-prize/writeups/after-exams-3rd-place-solution) and [AIMO 2](https://www.kaggle.com/competitions/ai-mathematical-olympiad-progress-prize-2/writeups/aliev-3rd-place-solution-report) without finetuning the model.
- You fine-tune the model, but treat the whole fine-tuning process as a black box.
    This is similar to the experience of using OpenAI finetuning API.
    You treat the entire finetuning dataset as a prompt.
- You use open source finetuning packages without modification.
    You would still probably tune some hyperparameters (the group size G)
    You inform your hyperparameters based on the metrics (loss, reward, KL divergence, grad norm).
- You write your finetuning pipeline from standard libraries.
    You define some libraries as standard (PyTorch, vLLM) which you do not intend to modify.
    You avoid any other packages except these standard libraries, you implement them from scratch.
- You modify underlying standard libraries (PyTorch, vLLM) code as well.
    You might want to modify PyTorch internals to achieve higher performance.
    You might want to edit vLLM code to implement something new.

How you choose your level of abstraction depends on your objective.
How much effort are you willing to spend?
How confident are you of your capabilities?
What do you want to learn?



**I decided to go with implementing the fine-tuning pipeline from scratch with standard libraries.**

I want to learn what it is like to build a fine-tuning pipeline from scratch.
I also want the flexibility to try out different loss functions and training patterns.
I want to prove my capability.

Another factor that affected my decision is that now we have Claude Code and GPT-5.
You can get questions about the code somewhat answered in the terminal where you execute your code.
I cannot imagine learning PyTorch in the previous year.

There are some risks with implementing the fine-tuning pipeline from scratch.
There is not really a good reference implementation I could follow.
It is very possible that I am missing a layer normalization somewhere in my model definition.
I can mitigate this risk with some checks - for example comparing my logprobs with vLLM's logprobs to check that they are within range.



**This is my training setup that builds from PyTorch and vLLM**

- I deploy four types of containers on Modal
    - Reference model vLLM inference "reference server" - For calculating reference model logprobs.
        There is one container.
    - Tuned model vLLM inference "inference server" - For calculating next token logprobs and rollouts.
        There are two containers - one that is deploying and one that is serving.
    - Training server - Receives training entries and enqueues the training process.
        Each training datapoint consists of the prompt, the completions and the target logprob.
    - Code execution - Receives code and executes the code.
        I got code execution to be remote so that my computer is not burdened with code execution compute.
- My local MacBook will be calling the vLLM inferences, training and execution APIs



**This is what happens when I start the training process**

- A script is started on my local MacBook.
- The script will enqueue ARC-AGI problems I am training on.
    The ARC-AGI problems are dequeued in parallel for processing, and re-enqueued after processing
- When a problem is processed
    - I retrieve the current redaction length.
    - I call the reference server for the logprobs.
        (I only need to call this once per problem because I can cache the logprobs, the reference model is not being updated anyway)
    - I call the inference server for the logprobs.
    - I choose what tokens will be given a rollout.
    - I call the inference server again for the rollouts.
    - When I get all the rollouts, I call the execution server to execute the code.
    - I calculate the rollout reward for each rollout.
    - I calculate the action reward for each token.
    - I calculate the advantage for each token.
    - I calculate the target logprob.
        If the advantage is positive, I want to increase the logprob to the target logprob.
        If the advantage is negative, I want to decrease the logprob to the target logprob.
    - With the (prompt, completion tokens, advantages, target logprobs), I send this training entry to the training server.
    - Depending on the state reward (probability weighted average of action rewards), I update the redaction length for the problem.



**This is what happens in the training server**

- When a training entry is enqueued
    - I dequeue from the queue 4 training entries
    - For each training entry
        I calculate the loss with the forward pass
        I calculate the gradient with backpropagation
    - With the accumulated gradients, the optimizer takes a steps and update the weights
- At approximately every three minutes
    - I pause the training process and save the model weights to disk.
        Saving the model weights took 30 seconds.
    - I kill one of the "inference server".
        So that it reloads the model weights from disk.
        Loading the model weights takes 40 seconds.




**You see that I make training and inference an API.**

There are some benefits in this arrangement.
- I can develop my code on my notebook.
    Whenever I edit my code, I do not need to spin up a GPU server.
    I also do not need to SSH into a GPU server to edit my code.
- I can easily scale up and scale down my GPU usage.
    The GPU are only active when I am running the compute that requires GPUs.
- I can provide clarity what is being passed in training.
    The training entry includes only information necessary for training.
    This way I can debug individual components.



**You may notice that my training is not exactly on-policy.**

For example, for a certain prompt (prompt + golden solution at a certain redaction length), for a model version 100, for a set of next tokens the true rollout reward is [0.5, 0.6, 0.7], and its advantages [-1, 0, +1]. We will train the model to generate more of the third token with the higher rollout reward. However, for model version 101, the true rollout reward is [0.8, 0.7, 0.6] and its advantages [+1, 0, -1].
If we use the rollout rewards of model version 100 to train model version of 101, it means that we are not training model version 101 in the correct direction. On-policy training would mean that I can training model version 101 with the rollouts of model version 100.

However, I do not think that this is a huge concern. Good tokens to train on are likely to be good for most model version. We saw the data.

I still think we should get rollout from updated models, for the following reasons
- Your rollout rewards are more accurate.
    While it is unlikely that positive advantage actions can become a negative advantage action within a few model versions, it is possible that this is true after many model versions.
    You do want to ensure that you are still training your model to generate the positive advantage actions.
- You want to caculate rollout rewards with the latest model which is the most competent.
    Even if you do not face the scenario of positive advantage actions becoming negative advantage, you still want to be able to find postive advantage tokens.
    For example, we start with a model that could not implement the code for a particular problem even given the correct observation and procedure.
    You cannot find positive advantage tokens for the observation and procedure, because none of the rollout would have positive reward.
    Only after you train the model and updated the vLLM server, then you can find positive advantage tokens in the observation and procedure.


[^tinker]: When Thinking Machines announced their product Tinker, I can see the point.
    There is a lot of creative things you can do in post-training.
    However, the infrastructure you need to maintain is a pain.



## Some interesting challenges I discovered

These are some war stories of me implementing the training procedure from PyTorch and vLLM.
Many of these challenges cannot be fully resolved with the resources I have, and I need to decide when to move on.



**vLLM and my PyTorch is producing different logprobs for the default model weights.**

To check that my PyTorch reimplementation of the model architecture is indeed correct, I compare the logprobs generated by the model.
Even though I load from the same set of weights, used the same quantization (all bfloat16), the logprob could be different.
As long as I get logprobs to a similar amount (+/- 0.25), I assume that I am fine.
I think I should spend my time on other things.



**vLLM sleep did not work (when I tried it in August)**

There are better ways to update the inference server other than restarting it.
vLLM offers a [sleep mode](https://docs.vllm.ai/en/latest/features/sleep_mode/) where you can offload the weights and reload the weight.
However, I think I face some issues after the model waking up.
Apparently it has something to do with the buffers.
I have not checked the state of the art now.
Currently it takes 30 seconds to save the weights, 40 seconds to load the weights from scratch.
Even eliminating this time fully is not critical for me, for now.



**The granularity of bfloat16 is pretty low**

In float32, the exponent is 8 bit and the fraction is 23 bit.

In bfloat16, the exponent is 8 bit and the fraction is 7 bit.

Here are some [illustrative](https://flop.evanau.dev/brainfloat-converter) numbers
- The next larger number of 1.0 is 1.0078125
- The next larger number of 16.0 is 16.125

The next larger bfloat16 number is approximately 0.78% larger.

If your entire model is in bfloat16 and you want to decrease the absolute value of the logprob by 0.5% in each individual GRPO iteration, you might not be able to backpropagate the gradient.

If you still plan to train with a fully bfloat16 model, you need to make sure your logprobs actually move.

I tried to train in float16 (5 bit exponent, 10 bit fraction) but the model will start throwing NaN outputs within one or two rounds of weight updates. float16 is not an option for training.



**Flash attention is only available in float16 or bfloat16**

Flash Attention is essential for both training and serving LLMs.
I wrote more about Flash Attention [here](https://www.quora.com/How-does-flash-attention-work/answer/Tong-Hui-Kang-1).

Flash attention is [only](https://github.com/Dao-AILab/flash-attention/blob/ad70a007e6287d4f7e766f94bcf2f9a813f20f6b/README.md?plain=1#L111) [available](https://github.com/Dao-AILab/flash-attention/blob/ad70a007e6287d4f7e766f94bcf2f9a813f20f6b/csrc/flash_attn/flash_api.cpp#L373) in float16 or bfloat16, for both PyTorch and vLLM.

If you choose float32 for vLLM serving, it will default to [not](https://github.com/vllm-project/vllm/blob/7bdb42b2f22f14bf450e084b8f9938f598c08f9b/vllm/platforms/cuda.py#L227) use Flash Attention.



**You can mix float32 and bfloat16 attention in PyTorch**

For this I will need to cast the QKV states to bfloat16 before passing it to the attention module, and then cast back to the original dtype. 
The mathematical operation is to drop the 16 out of the 23 bits.

The code looks like this.

```python
# Flash attention requires fp16 or bf16
input_dtype = query_states.dtype
if input_dtype not in [torch.float16, torch.bfloat16]:
    query_states = query_states.to(torch.bfloat16)
    key_states = key_states.to(torch.bfloat16)
    value_states = value_states.to(torch.bfloat16)

# Flash attention expects (batch, seq_len, heads, head_dim)
# Current shape: (batch, heads, seq_len, head_dim)
query_states = query_states.transpose(1, 2).contiguous()
key_states = key_states.transpose(1, 2).contiguous()
value_states = value_states.transpose(1, 2).contiguous()

# Flash attention with automatic causal mask for decoder
# Note: flash_attn_func handles the scaling by sqrt(head_dim) internally
attn_output = flash_attn_func(
    query_states,
    key_states,
    value_states,
    dropout_p=self.attention_dropout if self.training else 0.0,
    causal=True,  # Use causal mask for autoregressive decoder
    softmax_scale=None,  # Let flash attention handle the scaling
)

# Transpose back to (batch, heads, seq_len, head_dim)
attn_output = attn_output.transpose(1, 2).contiguous()

# Convert back to original dtype if needed
if input_dtype not in [torch.float16, torch.bfloat16]:
    attn_output = attn_output.to(input_dtype)
```

In this mixed-precision training, even with a low grad norm clipping, my logprobs can still move in the direction that I want in much smaller steps.


**vLLM does not offer mixed precision serving**

To reduce training-serving discrepancy, I also want vLLM to offer mixed precision serving.
I can choose the [dtype](https://github.com/vllm-project/vllm/blob/315068eb4a4b87a54ea201898b2fb6267f147eb3/vllm/config/model.py#L138-L146) for the entire model, but cannot choose a different dtype just for the attention module.

In vLLM, there is this `--override-attention-dtype` option, but it is only for [AMD GPUs](https://github.com/vllm-project/vllm/blob/315068eb4a4b87a54ea201898b2fb6267f147eb3/vllm/config/model.py#L492).



**Training in float32 and bfloat16 does not translate to serving in bfloat16**

When I trained on a token in float32. It increase the logprob from -10.0 to something like -0.5 in many GRPO iterations.

However, when I deploy the model to vLLM in bfloat16, the logprob for the token is still at -10.0. I validated that both PyTorch and vLLM are loading the the same weights. It seems that most of my gradient updates went to the 15 bits of fraction which nudged the model to make a very different prediction.



**The logprobs does not move**

I eventually trained and served the model entirely in bfloat16.

Initially when I train the model in bfloat16, the logprob did not move.
I need to relax my grad norm clipping so that I can even move the logprob.

However, I still want to move the logprob with the minimum amount possible.
I had different grad norm clipping values increase over the different GRPO iterations.
Eventually the logprob moved, but I still have suspicions about which weights are actually being updated.



## Performance analysis

As mentioned, my score for the competition is still zero.

The [original](https://www.kaggle.com/code/huikang/arc-agi-2-code-approach/output?scriptVersionId=262016237) model did manage to solve the first problem correctly, as did my [finetuned](https://www.kaggle.com/code/huikang/arc-agi-2-code-approach/output?scriptVersionId=273076021) model.

I thought about all the things that need to be right for my approach to work.

- I could generate golden solutions, and the golden solutions are actually good.
- I could move the individual logprobs in the direction that I want.
- When I move individual logprobs in the direction that I want, similar logprobs would also move in the direction that I want
- When I move individual logprobs in the direction that I want, I do not break the model - I do not move other logprobs in the directions I do not want.
- Training on the golden solution generalizes to sequences that the model would generate. The golden solution is generated by Claude Code after multiple iterations. This code might not be natural code that the model would generate.
- My training implementation is actually correct. I did not construct the model architecture wrongly. The training serving discrepancy is acceptable.
- The LLM could be finetuned to recognize patterns from 2D matrix represented in a string.
- Training on the training set improves performance on the training set, even though I am training on individual tokens.
- Training on the training set improves performance on the slightly different version of the training set (the expected algorithm is the same, but all the test cases are different)
- Training on the training set improves performance on test sets of similar difficulty.
- Either I am able to fine-tune long context, or short context fine-tuning generalizes to long context.
- I do not run out of GPU credits doing all of these.


This is what you would have seen if my training is indeed successful

- For a particular problem, for a particular redaction length, after a few iterations of training, the state reward improves to close to one.
- Then we set a larger redaction length. The state reward also successfully improves to close to one.
- We set a larger redaction length again, and until the redaction length is equal to the full golden solution minus the assistant problem. The state reward of the fully redacted solution is still close to one. This means that we could solve the problem.
- For similar problems not in the training set, their state reward also increases to one.

As you can see, while I am able to move the individual logprobs in the direction that I want, it does not seem to generalize to solve the problem.




## What I should have done

I should have saved the training data (the tuples of prompt - completion tokens - advantages).
This way I can warm start my training.
Currently finding these tokens is time consuming, I need to try different redaction length and compute many rollouts.
Reusing this data might cause some issues that comes with training off-policy.
In any case, I can still use this data to narrow down which tokens are useful, for a more on-policy training.
With this training data I can also visualize over the golden solution what are the tokens that are important for training.

There are times I am wasting GPU compute.
There are times I assumed that the training server is working but it is not.
This resulted in the wasted compute from the inference server.

I probably could think of a better unit testing strategy.
Similar to software engineering processes, every change to the code should be tested to ensure that you are not breaking previously working features.
For example, if I am training to increase a certain logprob, I need to prove that I am increasing the logprob.
I did implement some unit testing, but I did not really follow them closely, or keep the tests well-maintained.

I should also check my assumptions.
There is an assumption that my observations and procedures in the docstring are correct.
For example, I could have spent time to check whether a frontier model could reliable follow instructions in the docstring and reliable write the solution.
If a frontier model could not do it, I should not expect that I am able to tune a model to generate a similar solution.

There are many things I do want to look at.
When I update the weights, how many weights are really updated?
Is it that only weights of a certain type or layer is being updated?
We can track the gradient norm (the sum of the square of the gradients), can we track other metrics as well?
Do I have exploding weights?
Do I have exploding hidden states?
How do the attention weights look like?
I do hope to have access to good tooling so that I can build a better intuition when training.
Looking at the generated data has benefitted me a lot.
We should also look into how the data is generated.


For some reason I do not have much regret about this, even though I am scoring zero. I do have some regrets for [other](https://www.kaggle.com/code/huikang/code-interpreter-baseline) [Kaggle](https://www.kaggle.com/competitions/ai-mathematical-olympiad-progress-prize-2/discussion/571230) [competitions](https://www.kaggle.com/competitions/konwinski-prize/discussion/568634), but for some reason I do not really regret my work here even though I spent much more time on this. Probably because I am scoring zero and I am just too far from getting any medals. Probably because I am just doing a side project, and any valid submission is a bonus. Probably because I spent very limited time on Kaggle notebooks and the development environment is more ergonomic and the changes are easily tracked.

I hope this is interesting to you too.



## Footnotes






