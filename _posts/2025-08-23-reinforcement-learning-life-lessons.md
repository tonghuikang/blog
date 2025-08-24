---
layout: post
title: Life Lessons from Reinforcement Learning
---
I watched Shusen Wang's [video lectures](https://www.youtube.com/@ShusenWang/playlists) on reinforcement learning.

I think this is a more readable version of Sutton's [book](http://incompleteideas.net/book/the-book-2nd.html) reinforcement learning.

I write down some life lessons.



You need to define your reward [^reward]

[^reward]: The reward is denoted $R$.
	If you do not define your reward, there is no direction on what you are optimizing for.

You need to define the return - based on much you value the reward you get today versus the reward you get tomorrow [^discount_factor]

[^discount_factor]: The discount factor is denoted $\gamma$ .
	Return is denoted $G$. 
	$G = R_t + \gamma R_{t+1} + \gamma^2 R_{t+2} + \dots$
    In most cases, we want a discount factor that is less than one, even for scenarios where you do not really mind the difference of the length of the solution - like chess games.
    We want to avoid optimizing for solutions that are roundabout.

A policy considers a state and suggests a set of actions for the next step [^policy]

[^policy]: A policy is denoted $\pi(a | s)$.
	Why is policy a set of actions rather than one actions
	There are some games where the suggested action has to be probabilistic otherwise you will be taken advantage of (rock-scissors-paper, poker).
	Even when we know that there are perfect actions, (e.g. chess games)

There exist an optimal policy that maximizes the return. [^optimal_policy]

[^optimal_policy]: This is denoted as $\pi^*(a \vert s)$.

Given a state, there exist a function that calculates the best expected return. [^optimal_state_value_function]

[^optimal_state_value_function]: This is denoted as $V^*(s)$

Given a state and a policy, there exist a function that calculates [^state_value_function]

[^state_value_function]: This is denoted as $V_{\pi}(s)$





There exist 

There exist a set of optimal actions for every state.

If you know the optimal action to take, you have the optimal policy.






There exist 

You should take the best action

You are going to overestimate if you take the top of the estimate

You can learn without playing the entire game in full
