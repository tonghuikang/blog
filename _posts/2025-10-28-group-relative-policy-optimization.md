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

**$\theta$**: The policy parameters we are optimizing. In the context of language models, $\theta$ represents all the neural network weights (typically billions of parameters).

**$\pi_\theta$** (the current policy): This is the language model parameterized by $\theta$ that we're currently optimizing. When we write $\pi_\theta(o_{i,t} \vert q, o_{i,<t})$, this represents the probability that the model assigns to generating token $o_{i,t}$ given the question $q$ and all previous tokens $o_{i,<t}$ in the sequence.

**$\pi_{\theta_{old}}$** (the old policy): This is a snapshot of the policy from the previous training iteration, with frozen parameters $\theta_{old}$.

**$\pi_{ref}$** (the reference policy): This is typically the supervised fine-tuned (SFT) model before any reinforcement learning training began.

**$\mathcal{J}_{GRPO}(\theta)$**: This is the objective function to be maximized. The goal is to find parameters $\theta$ that maximize expected returns while staying close to the old policy.

**Expectation $\mathbb{E}[\cdot]$**: We take the expectation over:
- Questions $q$ sampled from the question distribution $P(Q)$
- A group of $G$ output sequences $\\{o_1, o_2, ..., o_G\\}$ sampled from the old policy $\pi_{\theta_{old}}(O \vert q)$

**The $\frac{1}{G}\sum_{i=1}^G$ term**: This averages the objective over all $G$ sampled outputs in the group. Each question gets $G$ different rollouts, and we aggregate their contributions equally.

**The $\frac{1}{\vert o_i \vert}$ term**: This averages over all tokens in sequence $i$. The sequence $o_i$ has length $\vert o_i \vert$, so we sum over time steps $t=1$ to $\vert o_i \vert$ and normalize by sequence length.

**The advantage $\hat{A}_{i,t}$**: This is calculated as the group-relative advantage. For token $t$ in sequence $i$:

$$\hat{A}_{i,t} = \tilde{r}_i = \frac{R(o_i) - \frac{1}{G}\sum_{j=1}^G R(o_j)}{\text{std}(R(o_1), \ldots, R(o_G))}$$

where $R(o_i)$ is the reward for sequence $i$. The advantage is computed by subtracting the mean reward across all $G$ sequences in the group and dividing by the group standard deviation to normalize the advantages. Note that the advantage is constant for all tokens in a sequence (it doesn't depend on $t$).


**The probability ratio**:

$$\frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})}$$

- The numerator $\pi_\theta(o_{i,t} \vert q, o_{i,<t})$ is the probability of token $o_{i,t}$ under the current policy $\pi_\theta$ being optimized
- The denominator $\pi_{\theta_{old}}(o_{i,t} \vert q, o_{i,<t})$ is the probability of the same token under the old policy $\pi_{\theta_{old}}$ from the previous iteration

Note that if pi old already 0.99, the probability ratio cannot increase to 1.1, because probability cannot be more than one.


**The clipped objective**:

$$\min \left[ \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})} \hat{A}_{i,t}, \text{clip} \left( \frac{\pi_\theta(o_{i,t} | q, o_{i,<t})}{\pi_{\theta_{old}}(o_{i,t} | q, o_{i,<t})}, 1 - \epsilon, 1 + \epsilon \right)  \hat{A}_{i,t} \right]$$

Factoring out the advantage, with abridged notation:

$$\hat{A} \cdot \min \left[ \frac{\pi_\theta}{\pi_{\theta_{old}}}, \text{clip} \left( \frac{\pi_\theta}{\pi_{\theta_{old}}}, 1 - \epsilon, 1 + \epsilon \right) \right]$$

This min operation implements the clipping behavior:

**When advantage is positive** ($\hat{A} > 0$):
We will increase $\pi_\theta$ until the ratio reaches $1 + \epsilon$. In other words, we will increase $\pi_\theta$ until it is $(1 + \epsilon) \times \pi_{\theta_{old}}$.


**Example 1**: $\pi_{\theta_{old}} = 0.900$, $\epsilon = 0.2$, $\hat{A} = 1.0$

| $\pi_{\theta_{old}}$ | $\pi_\theta$ | Ratio | Clipped ratio | Clipped objective |
|---------------------|-------------|-------|---------------|-------------------|
| 0.900 | 0.800 | 0.889 | 0.889 | 0.889 |
| 0.900 | 0.900 | 1.000 | 1.000 | 1.000 |
| 0.900 | 0.950 | 1.056 | 1.056 | 1.056 |
| 0.900 | 1.000 | **1.111** | **1.111** | **1.111** |

We have not maximized the objective until $\pi_\theta$ reaches exactly 1.000 (the probability constraint). At this point, ratio = 1.111, which is still below the clip boundary of 1.2.

**Example 2**: $\pi_{\theta_{old}} = 0.010$, $\epsilon = 0.2$, $\hat{A} = 1.0$

| $\pi_{\theta_{old}}$ | $\pi_\theta$ | Ratio | Clipped ratio | Clipped objective |
|---------------------|-------------|-------|---------------|-------------------|
| 0.010 | 0.008 | 0.800 | 0.800 | 0.800 |
| 0.010 | 0.010 | 1.000 | 1.000 | 1.000 |
| 0.010 | 0.012 | **1.200** | **1.200** | **1.200** |
| 0.010 | 0.100 | 10.000 | **1.200** | **1.200** |
| 0.010 | 0.500 | 50.000 | **1.200** | **1.200** |

Notice that any value of $\pi_\theta \geq 0.012$ have the same objective value (1.200) because they exceed the clip boundary. The clipped objective alone does not constrain how large the probability goes.

**When advantage is negative** ($\hat{A} < 0$):
We will decrease $\pi_\theta$ until the ratio reaches $1 - \epsilon$. In other words, we will decrease $\pi_\theta$ until it is $(1 - \epsilon) \times \pi_{\theta_{old}}$.

**Example 3**: $\pi_{\theta_{old}} = 0.900$, $\epsilon = 0.2$, $\hat{A} = -1.0$

| $\pi_{\theta_{old}}$ | $\pi_\theta$ | Ratio | Clipped ratio | Clipped objective |
|---------------------|-------------|-------|---------------|-------------------|
| 0.900 | 0.900 | 1.000 | 1.000 | -1.000 |
| 0.900 | 0.800 | 0.889 | 0.889 | -0.889 |
| 0.900 | 0.720 | **0.800** | **0.800** | **-0.800** |
| 0.900 | 0.500 | 0.556 | **0.800** | **-0.800** |
| 0.900 | 0.100 | 0.111 | **0.800** | **-0.800** |

Notice that any value of $\pi_\theta \leq 0.720$ have the same objective value (-0.800) because they exceed the clip boundary. The clipped objective alone does not constrain how small the probability goes.


**The KL term**:

The KL divergence is subtracted from the objective as a regularization term:

$$\beta \mathbb{D}_{KL}[\pi_{\theta} \vert\vert \pi_{ref}]$$

This penalizes the new policy from diverging too far from the reference policy. The coefficient beta controls the strength of this constraint.

The GRPO paper estimates the KL divergence with the unbiased reverse-KL estimator (Schulman 2020):

$$\mathbb{D}_{KL}\left[\pi_{\theta} || \pi_{ref}\right] = \frac{\pi_{ref}(o_{i,t}|q,o_{i,<t})}{\pi_{\theta}(o_{i,t}|q,o_{i,<t})}- \log\frac{\pi_{ref}(o_{i,t}|q,o_{i,<t})}{\pi_{\theta}(o_{i,t}|q,o_{i,<t})} - 1$$

Taking the expectation over $o_{i,t} \sim \pi_\theta$ recovers the standard categorical $D_{KL}[\pi_\theta || \pi_{ref}]$, and each sample value is non-negative.


**Example 4**: How the KL gradient changes with different reference probabilities at the clip boundary.

Given: $\hat{A} = 0.01$, $\epsilon = 0.20$, $\beta = 0.02$, $\pi_{\theta_{old}} = 0.500$, $\pi_\theta = 0.600 = (1 + \epsilon) \times \pi_{\theta_{old}}$

| $\pi_{ref}$ | $\pi_{\theta_{old}}$ | $\pi_\theta$ | $\frac{dJ}{d\pi_\theta}$ (clip term) | $\frac{dJ}{d\pi_\theta}$ (KL) | Total gradient |
|------------|---------------------|-------------|-----------------------------------|------------------------------|----------------|
| 0.500 | 0.500 | 0.600$^-$ | +0.020 | -0.0056 | +0.0144 |
| 0.100 | 0.500 | 0.600$^-$ | +0.020 | -0.0278 | -0.0078 |
| 1e-50 | 0.500 | 0.600$^-$ | +0.020 | -0.0333 | -0.0133 |

For this worked example, you see that the overall gradient at the clip boundary could be positive or negative depending on $\pi_{ref}$. This means that $\pi_{ref}$ may be able to influence whether we update $\pi_\theta$ to at least the clip boundary, or we prefer somewhere short of that.

The clip term does not penalize if $\pi_\theta$ goes over the clipping zone, but the KL term may penalize that.

The clip term gradient (before the clip function applies):

$$\frac{dJ}{d\pi_\theta}(\text{clip}) = \frac{\hat{A}}{\pi_{\theta_{old}}}$$

The KL term gradient is:

$$\frac{dJ}{d\pi_\theta}(\text{KL}) = -\beta \cdot \frac{\pi_\theta - \pi_{ref}}{\pi_\theta^2}$$

They are equal (total gradient = 0) when:

$$\frac{\hat{A}}{\pi_{\theta_{old}}} = \beta \cdot \frac{\pi_\theta - \pi_{ref}}{\pi_\theta^2}$$

Expressing $\pi_\theta$ in terms of $\pi_{ref}$, let $c = \frac{2\hat{A}}{\beta \pi_{\theta_{old}}}$:

$$\pi_\theta = \frac{1 \pm \sqrt{1 - 2c\pi_{ref}}}{c}$$

The discriminant $1 - 2c\pi_{ref}$ is negative when $\pi_{ref} > \frac{1}{2c} = \frac{\beta \pi_{\theta_{old}}}{4\hat{A}}$. This means there is no real equilibrium point in the valid probability range where the clip gradient and KL gradient balance. In such cases, both gradients push in the same direction throughout (really?), and $\pi_\theta$ will be driven toward the boundary constraints (probability limit of 1.0 or the clip boundary).

For the worked example ($\hat{A} = 0.01$, $\beta = 0.02$, $\pi_{\theta_{old}} = 0.5$), we have $c = \frac{2 \times 0.01}{0.02 \times 0.5} = 2$:

$$\pi_\theta = \frac{1 \pm \sqrt{1 - 4\pi_{ref}}}{2}$$

The critical value where the clip boundary $\pi_\theta = 0.6^-$ is optimal occurs when $\pi_{ref} = 0.24$ (since $0.6 = \frac{1 + \sqrt{1 - 4(0.24)}}{2} = \frac{1 + 0.2}{2}$). For $\pi_{ref} < 0.24$, the optimal $\pi_\theta$ is below the clip boundary.

If the KL gradient magnitude is higher than the clip term gradient, it is better to reduce the probability than to increase the probability, even if the advantage is positive.

However, this rarely happens. The advantage has to be as small as 0.01 to allow the KL gradient to slightly overcome the clip gradient. Note that the standard deviation of advantage is normalized to one. This is the case even though the KL divergence value is gigantic (e.g., for $\pi_{ref} = 10^{-50}$ and $\pi_\theta = 0.6$, the KL divergence $\mathbb{D}_{KL} \approx 115$).

Moreover, $\pi_{\theta_{old}}$ is updated at each iteration. In the next iteration of training, $\pi_\theta$ can still increase arbitrarily close to one, regardless of how small $\pi_{ref}$ and $\hat{A}$ are.




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
