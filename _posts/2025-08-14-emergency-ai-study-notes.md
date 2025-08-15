---
layout: post
title: Emergency AI Study Notes
---

Within 1 day of notice I need to prepare for an online test.[^1]

> You are now ready to take the **online logic test** that will assess your knowledge in **Mathematics, Machine Learning, and Deep Learning, NLP**. Please read the instructions carefully before starting.
> 
> **Prohibited:** The use of ChatGPT, AI tools, or any third-party assistance. All answers must be your own.

The test is administered on Google forms. I could imagine this is just a check allowing people to pay $2000/- and participate in the program.

This is my emergency study notes.

---

## Mathematics

### Key Resources
- [Differentiation Rules](https://en.wikipedia.org/wiki/Differentiation_rules)
- [Matrix Multiplication Notation](https://www.youtube.com/playlist?list=PLvOO0btloRns9u4UTx8p8vhXXdQIQVz47)

### Matrix Dimensions
- Convention: (row, col)
- Matrix multiplication: $(m \times n) \cdot (n \times 1) \rightarrow (m \times 1)$

---

## Backpropagation

*Postmortem note: I should have revised this*

### Linear and Softmax

Consider the function:
$$L = \frac{1}{1+\exp(w_0 x_0 + w_1 x_1 + w_2)}$$

To find partial derivatives w.r.t. each variable:

Let $u = w_0 x_0 + w_1 x_1 + w_2$

Then:
$$L = \frac{1}{1 + \exp(u)}$$

Using the chain rule:[^2]
$$\frac{dL}{du} = \frac{-\exp(u)}{(1 + \exp(u))^2}$$

The partial derivatives are:
- $\frac{dL}{dw_0} = \frac{dL}{du} \cdot \frac{du}{dw_0} = \frac{-\exp(u)}{(1 + \exp(u))^2} \cdot x_0$
- $\frac{dL}{dx_0} = \frac{dL}{du} \cdot \frac{du}{dx_0} = \frac{-\exp(u)}{(1 + \exp(u))^2} \cdot w_0$
- $\frac{dL}{dw_2} = \frac{dL}{du} \cdot \frac{du}{dw_2} = \frac{-\exp(u)}{(1 + \exp(u))^2}$

### Skip Connections

**Network Architecture:**

```
x0 → [a] → x_a → [b] → x_b → [c] → x_c → [d] → x_d → [e] → x_e <-loss-> t
                        ↓                    ↗
                        └─────── skip ───────┘
```

**Layer Definitions:**
- Input: $x_0$
- Node a: $x_a = w_a \times x_0 + b_a$
- Node b: $x_b = w_b \times x_a + b_b$
- Node c: $x_c = w_c \times x_b + b_c$
- Node d: $x_d = w_d \times x_c + b_d + w_{d2} \times x_b + b_{d2}$ (with skip connection)
- Node e: $x_e = w_e \times x_d + b_e$
- Loss: $\text{loss} = (x_e - t)^2$

**Gradient Calculation for Skip Connection:**

$$\begin{align}
\frac{dL}{dx_b} &= \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_b} \\
&= \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_d} \cdot \frac{dx_d}{dx_b} \\
&= \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_d} \cdot \frac{d}{dx_b} (x_c + x_b) \\
&= \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_d} \cdot \left(\frac{dx_c}{dx_b} + 1\right)
\end{align}$$

$$\frac{dL}{db_b} = \frac{dL}{dx_b} \cdot \frac{dx_b}{db_b} = \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_d} \cdot \left(\frac{dx_c}{dx_b} + 1\right)$$

$$\frac{dL}{dw_b} = \frac{dL}{dx_b} \cdot \frac{dx_b}{dw_b} = \frac{dL}{dx_e} \cdot \frac{dx_e}{dx_d} \cdot \left(\frac{dx_c}{dx_b} + 1\right) \cdot x_a$$

---

## Attention Mechanism

### Resources
- [LLM Architecture Analysis](https://github.com/tonghuikang/llm_architecture/blob/master/analysis.ipynb)
- [Attention Mechanism Tutorial](https://www.youtube.com/watch?v=orDKvo8h71o)

---

## Machine Learning

### Course Notes
- [Statistical Machine Learning](https://tonghuikang.github.io/notes/sutd-statistical-machine-learning/)
- [Deep Learning](https://tonghuikang.github.io/notes/sutd-deep-learning/)

### PyTorch Training Loop

```python
optimizer.zero_grad()  # PyTorch accumulates gradients by default
prediction = model(data)
loss = criterion(prediction, target)
loss.backward()  # Compute gradients
optimizer.step()  # Update parameters
```

### Cross-Entropy Formula
Cross-entropy loss: $H(p, q) = -\sum_i p_i \log q_i$

---

## Reinforcement Learning

### Resources
- [Shusen Wang's Playlists](https://www.youtube.com/@ShusenWang/playlists)
- *TODO: Create a cheatsheet*

---

## Scaling LLMs

### Key References
- [JAX Scaling Book](https://jax-ml.github.io/scaling-book)
- [Ultrascale Playbook - ZeRO](https://huggingface.co/spaces/nanotron/ultrascale-playbook?section=zero_redundancy_optimizer_(zero))

---

[^1]: Relevant information is available here:
    - [G* Program](https://gstar.newturing.ai/)
    - [LM Thang's Announcement](https://x.com/lmthang/status/1952415996020707347)
    - [NewTuring Official](https://x.com/newturing/status/1952409048189382713)
    - [NewTuring Facebook](https://www.facebook.com/newturing)

[^2]: If $h(x) = \frac{1}{f(x)}$, then $\frac{dh}{dx} = \frac{d(1/f)}{dx} = -\frac{1}{f^2} \frac{df}{dx}$