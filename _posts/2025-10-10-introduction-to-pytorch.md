---
layout: post
title: Introduction to PyTorch
---
These is some quick revision notes on PyTorch


A simple PyTorch model could look like this

```python
from torch import nn

class SimpleNN(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(SimpleNN, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size)
        self.fc2 = nn.Linear(hidden_size, output_size)

    def forward(self, x):
        x = torch.relu(self.fc1(x))
        x = self.fc2(x)
        return x
```


The core initialization loop looks like this.

```python
from torch.optim import AdamW

model = SimpleNN()
optimizer = AdamW(model.parameters(), lr=learning_rate)
```


The core training loop looks like this.

```python 
predictions = model(inputs)
loss = cross_entropy(predictions, labels)
loss.backward()
optimizer.step()
optimizer.zero_grad()
```


Tools to use in PyTorch


Profiler - https://github.com/tonghuikang/optimizer-memory-profiles

Metrics reporting - Weights and Biases, though I prefer reporting locally
