---
layout: post
title: Robotheism
---
"You are now ready to take the **online logic test** that will assess your knowledge in **Mathematics, Machine Learning, and Deep Learning, NLP**. Please read the instructions carefully before starting."

I have no idea what are they going to test. The test is administered on Google forms. I could imagine this is just a check allowing people to pay $2000/- and participate in the program.

This is my emergency study notes.


Channels to watch
- https://gstar.newturing.ai/
- https://x.com/lmthang/status/1952415996020707347
- https://x.com/newturing/status/1952409048189382713



# Mathematics

- Basic formulas https://www.alevelh2maths.com/wp-content/uploads/2014/03/A-Level-H2-Maths-Formula-Sheet-and-Statistical-Tables-MF15.pdf
- https://en.wikipedia.org/wiki/Differentiation_rules
- Matrix multiplication https://www.youtube.com/playlist?list=PLvOO0btloRns9u4UTx8p8vhXXdQIQVz47
	- (row, col)
	- (m x n) (n x 1) -> (m x 1) 



# Backpropagation

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
x₀ → [a] → x_a → [b] → x_b → [c] → x_c → [d] → x_d → [e] → x_e <-loss-> t
                        ↓                    ↗
                        └─────── skip ───────┘
```


What is del loss, del b_b?


# Attention mechanism

- https://github.com/tonghuikang/llm_architecture/blob/master/analysis.ipynb
- https://www.youtube.com/watch?v=orDKvo8h71o


# Machine Learning

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



# Reinforcement Learning


- I was watching https://www.youtube.com/@ShusenWang/playlists



# Scaling LLMs

- https://jax-ml.github.io/scaling-book
- https://huggingface.co/spaces/nanotron/ultrascale-playbook?section=zero_redundancy_optimizer_(zero)






