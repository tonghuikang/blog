---
layout: post
title: My attempt on ARC-AGI-2
---

ARC-AGI 2

You can see the problems in this site that I have built.

To be upfront, my score on the evaluation set is [zero](https://www.kaggle.com/code/huikang/arc-agi-2-code-approach/).
I also do not claim to have better performance even on the data I have trained on.

In any case, these are my contributions, in two URLs

- Code solutions for some ARC-AGI problems https://arc.huikang.dev/?task=007bbfb7
- Finetuning dashboard https://tonghuikang.github.io/grpo-grind-11/

I hope this is interesting.



# What I am betting on

This is what I observe

- LLMs are already good at LeetCode. LLMs could perform better than me at LeetCode. ARC-AGI problems is not much harder than LeetCode problems.
- LLMs are bad at recognizing patterns

I just do not believe the LLMs cannot write code to solve to get at least 5% in the ARC-AGI-2 eval set.
I could solve more than half ARC-AGI-2 eval set eval set in under 10 minutes each, with code. I do not believe AI cannot do this.

I believe getting LLMs to write code is one path to solving ARC-AGI-2 completely.


This is my approach

- I create a golden dataset
- I use the golden dataset to guide the reinforcement learning



# Golden solution

For each problems, I find the tokens that could generate significantly better performance.

This is one example of the golden solution

```
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

There are multiple parts to the solution

- The function signature. `def solve(grid: list[list[int]]) -> list[list[int]]:` Import statements are expected to be inside the function definition.
- Observations. I intend the trivial observations to be listed earlier
- Procedure. What the code should do.
- Code, probably with comments. Inner function definitions and import statements are allowed.
- Return statement `return result`



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



# Implementation

You need to choose the level of abstraction to work with. I am not going to modify PyTorch code or vLLM code, I trust that they are efficient.

I implement from PyTorch. I want to learn.

I run the risk from implementing wrongly. It is very possible that I am missing a layer normalization somewhere and my model is just entirely wrong. I have some checks - for example comparing my logprobs with vLLM's logprobs to check that they are within range.

Now there is Claude Code and GPT-5.


Redact the last line. Train whether it could produce the last line



# Performance analysis

As mentioned, my score for the competition is still zero.

This is a list of everything needs to be right for this work

- I could generate enough golden solutions
- Given the golden docstring, (or the LLM could have already done this)
- Training on the training set improves performance on the training set (I am stuck here)
- Training on the training set improves performance on a similar test set
- Either I am able to fine-tune long context, or short context fine-tuning generalizes to long context
- I have enough GPU credits




# Alternatives considered

- Chain of thought. The docstring is the chain of thought.



# What did I actually end up with

When it is quite clear that LLMs could not easily do the job, I spent my time on something else instead.



# What I should have done

I spent a few weeks trying to ...



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



# Fine-tuning procedures

SFT



