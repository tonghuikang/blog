---
layout: post
title: Introduction to dynamic programming
---

These are some notes on dynamic programming.

## What is dynamic programming?

It is a way to solve a problem by breaking it down into subproblems.


These are what I consider canonical problems in dynamic programming:

- Coin change - how many ways are there to exchange k cents with 1, 2 and 5 cent coins?
- Knapsack - Given a set of items with positive integer weight and value, how do you choose items to maximize value for a given weight limit?
- More problems are listed at [cp-algorithms.com](http://cp-algorithms.com/dynamic_programming/intro-to-dp.html)


## Formulating a dynamic programming problem

You need to define the following:

- What exactly is a state
- How do you transition between states

You need to estimate the following:

- Total number of states
- Total number of transitions

Check this estimate to see whether you will exceed the time limit.


## Top-down approach and bottom-up approach

In the top-down approach, you start by calling the function to compute the full problem.
In the bottom-up approach, you start by calling the function to compute the smallest possible subproblems.


A top-down approach would look like this.

```python
@cache
def knapsack(weight_remaining: int, current_item: int) -> int:
    # returns the maxmimum possible value

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

Top down approaches are easier to understand.
The transition logic lives alongside the state logic.
It is very clear that the state is (weight_remaining: int, current_item: int) and returns the maximum value.
For the bottom-up approach, it is harder to see what exactly is the transition.

Top down approaches might exceed time limit.
For Python there is a default recursion limit of 1000.
Also the Python code needs to maintain the call stack which might be additional overhead.
For the bottom up approach it is clearer where the compute bottlenecks are.

Top down approaches might manage sparsity better.
Maybe for some variants of the knapsack problem you do not need to compute all the possible states, just a small subset of it.
It is harder to implement a bottom-up approach that takes advantage of this observation.


