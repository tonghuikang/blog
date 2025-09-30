---
layout: post
title: Introduction to dynamic programming
---

These are some notes on dynamic programming.

## What is dynamic programming?

Dynamic programming solves problems by

- breaking them down into overlapping subproblems
- solving the subproblems
- reusing solutions to subproblems


These are what I consider canonical problems in dynamic programming:

- Coin change - how many ways are there to exchange k cents with 1, 2 and 5 cent coins?
- Knapsack - Given a set of items with positive integer weight and value, how do you choose items to maximize value for a given weight limit?
- More problems are listed at [cp-algorithms.com](http://cp-algorithms.com/dynamic_programming/intro-to-dp.html)


## Formulating a dynamic programming problem

You need to define the following:

- What exactly is a state (what exactly is a subproblem - what is the (input) key and what is the (output) value)
- How do you transition between states (how do you use solve the current subproblem with other subproblem)

You need to estimate the following:

- Total number of states
- Total number of transitions

Use this estimate to determine if your solution will run within the time limit.


## Top-down approach and bottom-up approach

In the top-down approach, you start by calling the function to compute the full problem.
In the bottom-up approach, you start by calling the function to compute the smallest possible subproblems.


A top-down approach would look like this:

```python
from functools import cache

@cache
def knapsack(weight_remaining: int, current_item: int) -> int:
    # returns the maximum possible value

    if current_item == len(item_values):
        return 0

    # do not take the item
    maximum_value = knapsack(weight_remaining, current_item + 1)

    item_value = item_values[current_item]
    item_weight = item_weights[current_item]

    # take the item if possible
    if item_weight <= weight_remaining:
        maximum_value = max(
            maximum_value,
            item_value + knapsack(
                weight_remaining - item_weight, current_item + 1
            )
        )

    return maximum_value

knapsack(total_weight, 0)
```

A bottom-up approach would look like this:

```python
dp = [0 for _ in range(total_weight + 1)]

for item_value, item_weight in zip(item_values, item_weights):
    new_dp = [0 for _ in range(total_weight + 1)]
    for previous_weight in range(total_weight + 1):
        # do not take the item
        new_dp[previous_weight] = max(new_dp[previous_weight], dp[previous_weight])
        # take the item if possible
        if previous_weight + item_weight <= total_weight:
            new_dp[previous_weight + item_weight] = max(
                new_dp[previous_weight + item_weight],
                dp[previous_weight] + item_value,
            )
    dp = new_dp

# the result is max(dp)
```

Top-down approaches are easier to understand because the transition logic lives alongside the state definition.
It's clear that the state is (weight_remaining, current_item) and the function returns the maximum value.
The state representation and transitions are harder to understand in the bottom-up approach.

Top-down approaches might have high constant factors that can cause you to exceed the time limit.
One source of the overhead is the Python call stack.
For the bottom-up approach, it is clearer where the compute bottlenecks are.

Top-down approaches might manage sparsity better.
Maybe for some variants of the knapsack problem you do not need to compute all the possible states, just a small subset of it.
It is harder to implement a bottom-up approach that takes advantage of this observation.

