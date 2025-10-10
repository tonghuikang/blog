---
layout: post
title: Introduction to PyTorch
---
These are some quick revision notes on PyTorch


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


Chaining modules together

```python
# Using nn.Sequential
model = nn.Sequential(
    nn.Linear(input_size, hidden_size),
    nn.ReLU(),
    nn.Linear(hidden_size, output_size)
)
```


Model and optimizer

```python
from torch.optim import AdamW

model = SimpleNN()
optimizer = AdamW(model.parameters(), lr=learning_rate)
```

Data

```python
from torchvision import datasets, transforms

train_dataset = datasets.CIFAR10(root='./data', train=True, download=True,
                                  transform=transforms.ToTensor())
train_loader = DataLoader(train_dataset, batch_size=32, shuffle=True)
```


Training loop

```python
model.train()
for inputs, labels in train_loader:
    predictions = model(inputs)
    loss = cross_entropy(predictions, labels)
    loss.backward()
    optimizer.step()
    optimizer.zero_grad()
```


What to look out for in training

- Loss
- Grad norm `torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=max_norm)`
- Validation metrics


Tools to use in PyTorch


Profiler - https://github.com/tonghuikang/optimizer-memory-profiles

Metrics reporting - Weights and Biases, though I prefer reporting locally
