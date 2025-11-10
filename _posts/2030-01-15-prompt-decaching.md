---
layout: post
title: Prompt decaching
---

This is a work-in-progress design document.
Feel free to reach out to me if you want to understand more what I mean or want me to accelerate the completion of this document.

In summary, prompt decaching involves delete block entries from the KV store.

Comparisons

- Sliding window attention is a form of prompt decaching.
- Context compaction
- Subagents

We need to train AI models to be able to identify their context by tokens

- (probably this could include a numbering system for AI to refer to)
- Position IDs that can go a very large number

Scaffold

- We should still have the whole conversation history available for grep.

Implementation

- Paged attention
- Ideally KV-blocks should be continuous. This idea is similar to defragmentation in hard disk drives.

What should be decached

- System reminders that are temporary
- Hook responses that are temporary
- Logs irrelevant to the query




