---
layout: post
title: Group Relative Policy Optimization
---

The expression for [GRPO](https://arxiv.org/abs/2402.03300) is presented in the DeepSeekMath paper (submitted Feburary 2024).

$$
\begin{split}
    \mathcal{J}_{GRPO}(\theta) &= \mathbb{E}{[q \sim P(Q), \{o_i\}_{i=1}^G \sim \pi_{\theta_{old}}(O|q)]}  \\
    & \frac{1}{G}\sum_{i=1}^G\frac{1}{|o_i|} \sum_{t=1}^{|o_i|} \left\{ \min \left[ \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})} \hat{A}_{i,t}, \text{clip} \left( \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})}, 1 - \epsilon, 1 + \epsilon \right)  \hat{A}_{i,t} \right] - \beta \mathbb{D}_{KL}\left[\pi_{\theta} || \pi_{ref}\right]\right\} ,
\end{split}
$$

Let me break down this expression component by component:

**$\theta$**: The policy parameters we are optimizing. $\pi_\theta$ is the current policy, $\pi_{\theta_{old}}$ is the policy from the previous iteration, and $\pi_{ref}$ is a reference policy (typically the supervised fine-tuned model before RL training).

**$\mathcal{J}_{GRPO}(\theta)$**: This is the objective function to be *maximized* (not a loss to be minimized). The goal is to find parameters $\theta$ that maximize expected returns while staying close to the old policy.

**Expectation $\mathbb{E}[\cdot]$**: We take the expectation over:
- Questions $q$ sampled from the question distribution $P(Q)$
- A group of $G$ output sequences $\\{o_1, o_2, ..., o_G\\}$ sampled from the old policy $\pi_{\theta_{old}}(O \vert q)$

**The $\frac{1}{G}\sum_{i=1}^G$ term**: This averages the objective over all $G$ sampled outputs in the group. Each question gets $G$ different rollouts, and we aggregate their contributions equally.

**The $\frac{1}{\vert o_i \vert}$ term**: This averages over all tokens in sequence $i$. The sequence $o_i$ has length $\vert o_i \vert$, so we sum over time steps $t=1$ to $\vert o_i \vert$ and normalize by sequence length.

**The KL term**: The expression $$\beta \mathbb{D}_{KL}[\pi_{\theta} \vert\vert \pi_{ref}]$$ is a regularization term (subtracted from the objective) that penalizes the new policy $$\pi_\theta$$ from diverging too far from the reference policy $$\pi_{ref}$$. The coefficient $$\beta$$ controls the strength of this constraint.

**The advantage $\hat{A}_{i,t}$**: This is calculated as the group-relative advantage. For token $t$ in sequence $i$:

$$\hat{A}_{i,t} = \tilde{r}_i = \frac{R(o_i) - \frac{1}{G}\sum_{j=1}^G R(o_j)}{\text{std}(R(o_1), \ldots, R(o_G))}$$

where $R(o_i)$ is the reward for sequence $i$. The advantage is computed by subtracting the mean reward across all $G$ sequences in the group and dividing by the group standard deviation to normalize the advantages. Note that the advantage is constant for all tokens in a sequence (it doesn't depend on $t$).


**What is the probability ratio?**

The ratio $$\frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})}$$ is the importance sampling ratio:

- The numerator is $$\pi_\theta(o_{i,t} | q, o_{i,<t})$$: the probability of token $$o_{i,t}$$ under the current policy $$\pi_\theta$$ being optimized
- The denominator is $$\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})$$: the probability of the same token under the old policy $$\pi_{\theta_{old}}$$ from the previous iteration

This ratio tells us how much more or less likely the token is under the new policy compared to the old policy.

If the advantage is positive, you are maximizing the ratio (multiplied by the advantage) until it reaches $$1 + \epsilon$$. In other words, you are increasing the probability of every token in the positive-advantage sequence by up to a factor of $$1 + \epsilon$$ (typically $$\epsilon = 0.2$$, so up to 20% increase).

If the advantage is negative, you are maximizing the ratio (which means minimizing it when multiplied by the negative advantage) until it reaches $$1 - \epsilon$$. This decreases the probability of every token in the negative-advantage sequence by up to a factor of $$1 - \epsilon$$ (typically down to 0.8, so up to 20% decrease)

There is this KL divergence term.

Note that this is an objective function. It is not a loss function. This is not meant to be differentiable.




## Comments on the objective function

The G term is fine, does not matter. Unless you are using different group sizes. For larger group sizes you want to give smaller weight to individual groups.

The O term is suspicious. Consider two sequences. Consider that you rollout three statements.

Advantage is suspicious. This means if you have the wrong thought process but the correct answer, you still get the full credit.

The odds term is suspicious?

If the old probability is already close to 1 you want to go even more than 1?





## What happens in practice

You should not put this into the loss function. See PPO.


Many of your tokens can actually go more than 1-e or 1+e. 

Or you simply stop before you get to 1-e or 1+e.




## What I think is valuable from GRPO

The group part. DPO is group size two

The online training part

SFT is imitation learning

The relative part. Although I don't know if it really increase, it seems to only check whether the advantage is better.




## How did the original GRPO work

Generating and training on its own output. The system does not attempt to force a elementary school student to recite the International Math Olympaid editorial solutions.

Happen to find a sequence that works, starting with simpler problems

Figuring out certain words that promote success.

I think this is more like SFT but on 



## Suggested actions

Ultimately, you are increasing generation of the nice logits and decreasing the generation of the bad logits. You need to figure out which tokens are good and which tokens are bad. Good and bad is relative.

Please actually look at the data. WandB graphs does not suffice. You should invest in a nice dashboard that actually shows the data.

Look at the logits

Sample from the iteration and see how the logits has updated

Better reward attribution




Footnotes

The few things I look at the paper - examples, figures (with huge suspicious), diagrams, before I read any words. 






Sample is always a sample an it is noisy

You should not attribute the entire sequence


The 1/G terms - I think it is unnecessary. If you want to maximize f(x) = -(x-1)^2,  it does not matter if you are maximizing f(x) = -(x-1)^2 or f(x) = -(x-1)^2.

The o term.
Consider two sequences.


The part on generating ca



The clip term


How I think it worked

It just happen to generate some sequence with positive rewards


What I think it should be

If a token i

You still need relative.





## How do you actually achieve the objective


> While this kind of clipping goes a long way towards ensuring reasonable policy updates, it is still possible to end up with a new policy which is too far from the old policy, and there are a bunch of tricks used by different PPO implementations to stave this off. In our implementation here, we use a particularly simple method: early stopping. If the mean KL-divergence of the new policy from the old grows beyond a threshold, we stop taking gradient steps.
> 
> When you feel comfortable with the basic math and implementation details, it’s worth checking out other implementations to see how they handle this issue!





# Ideas that are still useful from GRPO

In supervised finetuning -

In again

In GRPO



# Optimization function

GRPO optimization objective

TBC



# Algorithm




Cite deepseek GRPO algorithm


Why is it wrong.


What should people do

- Actually read the training logs. When did the Aha moment happen
- Read the logprobs


ARC-AGI example


