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



# What I am betting on

This is what I observe

- LLMs are already good at LeetCode problems.
- The code solutions to ARC-AGI problems is not much harder than LeetCode problems.
    There are no advanced data structures.
    There is no need to optimize for time complexity.
    There are no edge case that you find out and think through.
    Most of the time, you just need to put for loops in the correct places.
    For half of the ARC-AGI-2 eval set problems, I think I could write the code in under 10 minutes.

I thought that I could easily achieve 6% just by lightly aligning the LLMs. As you can see, this is much harder than expected.

I still believe writing code is one way to solve ARC-AGI. As a human, you solve ARC-AGI with a processes. You do not just stream the output cell by cell - you copy the input, change the grid size, change some colors - you follow some procedure. The procedure can be codified, with code.

[^LLM-only]: Even if we have a LLM-only solution to solve ARC-AGI, it will involve the LLM reasoning by the coordinates, and making one operation at a time. It will still involve code.



# General approach

This is my approach

- I create a set of "golden" solutions
- I use the golden solutions to guide the reinforcement learning



# Golden solution

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
- Observations. I intend the trivial observations to be listed earlier
- Procedure. What the code should do.
- Code, probably with comments. Inner function definitions and import statements are allowed.
- Return statement `return result`


You have 
Currently it seems that AI is able to solve LeetCode problems without thinking.

Maybe not all the time, but at least 1 in 64 times of the times.

Why not thinking - I don't think I have enough GPUs.


# Prompting

When I ask the LLM to generate the solution, I have a prompt. The prompt looks like this

```
<|im_start|>user
Implement a Python function that maps the input to the outuput.

The function docustring should include
- some key observations
- the general prodcedure

def solve(grid: list[list[int]]) -> list[list[int]]:
    """
    Observation:
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

Probably I could have done serious prompt engineering in the prompts.

One way is to include a long list of ways ARC-AGI problems are solved.

However, this is something that should be done after I score 6% on the leaderboard.

I do not do this now because this will increase the context length and would require me more GPUs to train my LLMs.


# Training procedure

This is the general training procedure.

- The last k tokens of the golden solution is redacted.
- With the last k tokens missing, I sample the next token.
- For each token sampled, I do multiple rollouts.
    - For each rollout, the reward is one if the solution is correct. The reward is zero if the solution is wrong.
- The advantage for each sampled token is calculated.
- If the advantage is positive, I will train the model to increase the probability of generating the token. If the advantage is negative. I will train the model to decrease the probability of generating the token.
- The value k is updated. Whether I increase or decrease k depends on the average reward.


This is different from the usual GRPO-style reinforcement learning. What is different here:

- The action is one token, not the whole sequence.
- I removed the G-term, the O-term, the KL term.
- The clip value is different. For positive advantage, I attempt half the logprob. For negative advantage, I attempt to increase the logprob by two. After each iteration of training, I check whether the logprob has indeed moved to the direction I intend it to move.
- The advantage value is normalized to either 1, 0 or -1.
- The advantage calculation is different. Even if the reward of the action is positive, if I am not confident that the reward. (For example, if you have a pair of 8 rollouts, one with 4 correct and one with 5 correct, how confident that one is really better than the other).



# Some interesting examples

Certain words are important - cite URL

Fixing mistakes - cite URL

Until I am confident that one token is indeed better than the other. Even so, there are some slip throughs.
Sometimes if you have alternate spacing you can get a better reward. This is spurious. One way I could have accounted for this is whether the sample token would be unaffected if I run the formatter.

It still remains a question on whether these fixes generalize.


# Implementation

You need to choose the level of abstraction to work with. I am not going to modify PyTorch code or vLLM code, I trust that they are efficient.

I implement from PyTorch. I want to learn.

I run the risk from implementing wrongly. It is very possible that I am missing a layer normalization somewhere and my model is just entirely wrong. I have some checks - for example comparing my logprobs with vLLM's logprobs to check that they are within range.

Now there is Claude Code and GPT-5.



# Performance analysis

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



# What I should have done

(Also include the path that I decided not to take and still agree with it.)

I spent a few weeks trying to ...

I do not believe that you can train a model to predict the whole output. You cannot just pass in a Sudoku. One cell to fill up yes, but you cannot solve the entire Sudoku. It does not make sense.

Chain of thought. The docstring is the chain of thought.

Overall it is still fun. I learnt a lot of things. I do have some regrets for other[AIMO-1] Kaggle[AIMO-2] competitions[Konwinski], but for some reason I do not really regret my work here even though I spent much more time on this. Probably this is because I score zero and I am just too far from getting any medals. Probably because I am optimizing for learning rather than optimizing for medals. Probably I am working mostly off Kaggle and the development environment is much more egronomic. Probably I could use the GPU credits more efficiently.



# What I observed


Training-serving descrepancies

These are currently the constraints in open source software

- vLLM
- Flash Attention is only available in float16 or bfloat16
- The minimum bfloat16
- You can write PyTorch code such that the model weights are in float32, the at
- vLLM does not

Quantization

vLLM






