---
layout: post
title: My attempt on ARC-AGI-2
---

Here I share the motivations and lessons behind by attempt at [ARC-AGI-2](https://arcprize.org/arc-agi/2/)

To be upfront, my accuracy score on the evaluation set is [zero](https://www.kaggle.com/code/huikang/arc-agi-2-code-approach/).
I also do not claim to have improved performance even on the data I have trained on.

In any case, these are my contributions, in two html files

- Code solutions - [arc.huikang.dev](https://arc.huikang.dev/) for some ARC-AGI problems
- Finetuning dashboard - [traces.huikang.dev](https://tonghuikang.github.io/grpo-grind-11/)

I hope this is interesting.



## What I am betting on

This is what I observe

- LLMs are already good at LeetCode problems.
    In addition, it seems that LLMs can solve LeetCode even without a dedicated thought process. 
- The code solutions to ARC-AGI problems is not much harder than LeetCode problems.
    There are no advanced data structures.
    There is no need to optimize for time complexity.
    There are no edge case that you find out and think through.
    Most of the time, you just need to put for loops in the correct places.
    For half of the ARC-AGI-2 eval set problems, I think I can write the code in under 10 minutes.

I thought that I could easily achieve 6% just by lightly aligning the LLMs. As you can see, this is much harder than expected.

I see writing or following a procedure[^LLM-only] to be the way to solve ARC-AGI. As a human, you solve ARC-AGI with a processes. You copy the input, change the grid size, change some colors - you follow some procedure. The procedure can be codified, with code.

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
Implement a Python function that maps the input to the outuput.

The function docustring should include
- some key observations
- the general prodcedure

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

{other example cases, and also the test cases}

<|im_end|>
<|im_start|>assistant
def solve(grid: list[list[int]]) -> list[list[int]]:
    """
    Observations:
```

I describe some charactertics of my prompt

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
- With the last `k` tokens missing, I sample the next token `{t}`.
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
- The advantage calculation is different. Even if the reward of the action is positive, if I am not confident that the reward. (For example, if you have a pair of 8 rollouts, one with 4 correct and one with 5 correct, how confident that one is really better than the other).
- The clip value is different. For positive advantage, I attempt to halve the logprob (there will be adjustments so that the sum of probabilties is still one). For negative advantage, I attempt to increase the logprob by two. After each iteration of training, I check whether the logprob has indeed moved to where I intend it to move.

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
    The completion modal shows the completion (action) reward, as well as my measure of confidence of whether the action 
    Then the rollout information follows. It shows full function for the completely rolled-out text, and the rollout reward.


Certain words are important

http://traces.huikang.dev/?problem=1fad071e&redacted=201

http://traces.huikang.dev/?problem=5582e5ca&redacted=158

http://traces.huikang.dev/?problem=59341089&redacted=74

(todo: explain)


Fixing mistakes

http://traces.huikang.dev/?problem=f2829549&redacted=68

http://traces.huikang.dev/?problem=ed36ccf7&redacted=96

http://traces.huikang.dev/?problem=6150a2bd&redacted=172

(todo: explain)


Mistakes

http://traces.huikang.dev/?problem=00576224&redacted=132

You can see that the state reward at this redaction length was initially above 0.5.
However, after training on other tokens, the state reward at this redaction length decreased to almost zero.

In the most recent action sampling, the three completion tokens are pretty much equivalent to each other - it is just a closing bracket with different amount of succeeding spaces.



## Implementation

I need to decide on level of abstraction to work with. There are these levels of abstraction

- You do not finetune the model at all.
    People won prizes in AIMO 1 and AIMO 2 without finetuning the model
- You finetune the model, but the whole finetuning process as a black box.
    This is as-if you are using OpenAI finetuning API.
- You use open source finetuning packages and you intend
- You write your
    You still treat 
- You modify underlying packages PyTorch and vLLM code as well.
    This involves getting into PyTorch internals or vLLM implementation.
    For example, you want some features that they have not implemented.

This depends on my objective.
I want to learn and prove my capability.

I decide to work with PyTorch and vLLM.
I want to build the finetuning from scratch, from where the loss is computed.

I run the risk from implementing wrongly.
It is very possible that I am missing a layer normalization somewhere and my model is just entirely wrong. 
I have some checks - for example comparing my logprobs with vLLM's logprobs to check that they are within range.

This year is a special year.
This year we have Claude Code and GPT-5.
This is the time where you can learn asking anything about the codebase with AI, while the AI that not yet powerful enough to do everything for you.
This window will not last long.

I also made training and inference an API.
To make an inference, I will make a REST API call to a vLLM server.
To train the model, I will make a REST API call with the prompt, the completions and the target logprob I want for the training.


I try to do on policy training.
I don't think we need to be that on-policy.
Gradient updates has to be on policy.
The generated data does not need to be on-policy.
Why do I still want on-policy.

I saved the weights to disk.
I simply restart the vLLM server.
Saving the weights took 30 seconds. The vLLM server takes 40 seconds to start.
There is this sleep and wake, but I could not get it to work.

Training machines and inference machines could be two very different machines.

When Thinking Machines announced their product Tinker, I can see the point.
There is a lot of creative things you can do in post-training.
However, the infrastructure you need to maintain is a pain.




## Performance analysis

As mentioned, my score for the competition is still zero.

Some basic cases could still be solved, even after finetuning. See Kaggle notebook.

This is a list of everything needs to be right for this work

- I could generate enough golden solutions
- Given the golden docstring, (or the LLM could have already done this)
- The LLM could be easily tuned to recognize patterns
- The LLM does not need extensive chain of thought to recognize patterns
- At least 1 in 64 rollouts needs to be correct
- Training on the training set improves performance on the training set (I am stuck here)
- Training on the training set improves performance on a similar test set
- Either I am able to fine-tune long context, or short context fine-tuning generalizes to long context


While all of these happens, it assumes that I have enough GPU credits.



## What I should have done

(Also include the path that I decided not to take and still agree with it.)

I spent a few weeks trying to ...

I do not believe that you can train a model to predict the whole output. You cannot just pass in a Sudoku. One cell to fill up yes, but you cannot solve the entire Sudoku. It does not make sense.

Chain of thought. The docstring is the chain of thought.

Overall it is still fun. I learnt a lot of things. I do have some regrets for other[AIMO-1] Kaggle[AIMO-2] competitions[Konwinski], but for some reason I do not really regret my work here even though I spent much more time on this. Probably this is because I score zero and I am just too far from getting any medals. Probably because I am optimizing for learning rather than optimizing for medals. Probably I am working mostly off Kaggle and the development environment is much more egronomic. Probably I could use the GPU credits more efficiently.



## What I observed


Training-serving descrepancies

These are currently the constraints in open source software

- vLLM
- Flash Attention is only available in float16 or bfloat16
- The minimum bfloat16
- You can write PyTorch code such that the model weights are in float32, the at
- vLLM does not

Quantization

vLLM

## Footnotes






