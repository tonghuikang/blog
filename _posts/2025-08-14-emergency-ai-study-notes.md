---
layout: post
title: Emergency AI Study Notes
---
Within 1 day of notice I need to prepare for an online test [^1]

> You are now ready to take the **online logic test** that will assess your knowledge in **Mathematics, Machine Learning, and Deep Learning, NLP**. Please read the instructions carefully before starting.
> 
> **Prohibited:** The use of ChatGPT, AI tools, or any third-party assistance. All answers must be your own.


The test is administered on Google forms. I could imagine this is just a check allowing people to pay $2000/- and participate in the program.

This is my emergency study notes.

[^1]: Relevant information is available here
	- https://gstar.newturing.ai/
	- https://x.com/lmthang/status/1952415996020707347
	- https://x.com/newturing/status/1952409048189382713
	- https://www.facebook.com/newturing



## Mathematics


- Differentiation https://en.wikipedia.org/wiki/Differentiation_rules
- Matrix multiplication notation https://www.youtube.com/playlist?list=PLvOO0btloRns9u4UTx8p8vhXXdQIQVz47
	- (row, col)
	- (m x n) (n x 1) -> (m x 1) 



## Backpropagation

Postmortem note: I should have revised this

#### Linear and softmax

L = 1 / (1+exp(w0 x0 + w1 x1 + w2))

Get the partial derivate w.r.t. to each variable.

Firstly denote u = w0 x0 + w1 x1 + w2

L = 1 / (1 + exp(u))
dL / du = -exp(u) / (1 + exp(u)) ^ 2 [^2]

[^2]: If h(x) = 1/f(x)
	dh/dx = d(1/f)/dx = -1/f^2 df/dx
  
dL / dw0 = dL / du  du / dw0 = (-exp(u) / (1 + exp(u)) ^ 2) x0

dL / dx0 = dL / du  du / dx0 = (-exp(u) / (1 + exp(u)) ^ 2) w0

dL / dw2 = dL / du  du / dx0 = (-exp(u) / (1 + exp(u)) ^ 2)


#### Skip connections

**Input Layer:**
* Input: `x0`
**Hidden Layers (Sequential Processing):**
* **Node a:** `x_a = w_a × x_0 + b_a`
* **Node b:** `x_b = w_b × x_a + b_b`
* **Node c:** `x_c = w_c × x_b + b_c`
* **Node d:** `x_d = w_d × x_c + b_d + w_d2 × x_b + b_d2`
* **Node e:** `x_e = w_e × x_d + b_e`
**Loss Function:**
* `loss = (x_e - t)²`

```
x0 → [a] → x_a → [b] → x_b → [c] → x_c → [d] → x_d → [e] → x_e <-loss-> t
                        ↓                    ↗
                        └─────── skip ───────┘
```

dL / dx_b
= (dL / dx_e) (dx_e / dx_b)
= (dL / dx_e) (dx_e / dx_d) (dx_d / dx_b)
= (dL / dx_e) (dx_e / dx_d) (d / dx_b (x_c + x_b))
= (dL / dx_e) (dx_e / dx_d) (d / dx_b (x_c) + d / dx_b (x_b))
= (dL / dx_e) (dx_e / dx_d) (dx_c / dx_b + dx_b / dx_b)
= (dL / dx_e) (dx_e / dx_d) (dx_c / dx_b + 1)

dL / db_b
= dL / dx_b + dx_b / db_b
= (dL / dx_e) (dx_e / dx_d) (dx_c / dx_b + 1)

dL / dw_b
= dL / dx_b + dx_b / dw_b
= (dL / dx_e) (dx_e / dx_d) (dx_c / dx_b + 1) x_a


## Attention mechanism

- https://github.com/tonghuikang/llm_architecture/blob/master/analysis.ipynb
- https://www.youtube.com/watch?v=orDKvo8h71o



## Machine Learning

- https://tonghuikang.github.io/notes/sutd-statistical-machine-learning/
- https://tonghuikang.github.io/notes/sutd-deep-learning/

```
optimizer.zero_grad()  # PyTorch accumulates gradients by default
prediction = model(data)
loss = criterion(prediction, target)
loss.backward()  # Compute gradients
optimizer.step()  # Update parameters
```

Crossentropy formula - sum of log p_i log q_i



## Reinforcement Learning


- I was watching https://www.youtube.com/@ShusenWang/playlists
- Probably I should make a cheatsheet



## Scaling LLMs

- https://jax-ml.github.io/scaling-book
- https://huggingface.co/spaces/nanotron/ultrascale-playbook?section=zero_redundancy_optimizer_(zero)






