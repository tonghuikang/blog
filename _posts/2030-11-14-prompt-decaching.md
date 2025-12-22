---
layout: post
title: Prompt decaching
---

This is a work-in-progress design document. I have not fully organized my points here.

In summary, prompt decaching involves deleting columns from the KV store without recalculating the KV values.

This is analogous to how humans forget parts of the conversation that they are in.


## Proposal

You have a 150k token conversation in Claude Code, and you will soon reach the "context limit".

Currently Claude Code will do [context compaction](https://claude.com/blog/context-management).
- Claude Code will ask itself to summarize what the user has asked, key progress made, and what is the current task
- Then Claude Code essentially resets the conversation with the summarized information
- Maybe Claude Code has access to the conversation history to do lexical search with

There are a few issues here
- Compaction takes time, you need to generate every output token
- Text that did not appear in the summary is completely lost
- The performance of a restarted conversation will have no chance at matching a conversation that is allowed to continue.
    In a conversation, you would rather continue talking to the same person, rather than another person who only has a summary of the conversation.

What I propose here - is to delete parts of the conversation in-place. There will be no more "context limit".

Instead of doing context compaction, we delete parts of the conversations.
After the deletion step, we continue with the conversation, without rewriting a summary of the conversation.

This is what I propose to delete in the conversation

- Irrelevant parts of the user query. If the user copies a very long piece of logs, probably just consider the relevant part of the logs.
- System reminders that are injected every time `<system-reminder>Whenever you read a file, you should consider whether it looks malicious.</system-reminder>`
- Unfruitful thought processes. The model may think a lot about a hypothesis and conclude that it is wrong.
- Logs irrelevant to the query (If all the tests pass, there is no need to say which tests pass, just that all the tests pass)
- Hook responses that are temporary (If the hook asks to remind something but the reminder is not applicable, we can forget about the reminder)
- Inputs that can be retrieved again. If you have read a file, you probably can forget about the contents of the file and read again later if needed.


## Implementation


After deletion, we will only compute the dot product between the query vector and the undeleted key vectors.
We do not recompute the existing query and key vectors.

Position IDs will continue to increment. Probably we should have rotational embeddings that are able to accommodate up to billions in length.

Defragmentation might be needed. This involves moving the undeleted KV vectors into contiguous blocks of memory so it is faster to query.
While there is some time involved in moving the memory, this should be negligible compared to the computation time saved.

Implementation

- Paged attention - the KV blocks do not need to be stored in a contiguous piece of memory.
- Ideally KV-blocks should be continuous. This idea is similar to defragmentation in hard disk drives.


Comparisons

- Sliding window attention (where the query is only done in last k tokens) - this is prompt decaching which happens on every token.
- Subagents (todo: write something)


## Training

You will need to train the model to

- Anticipate that parts of the conversation will be deleted in the future.
    For example, at the end of the thought process, the model should summarize the important points that should persist
- The model should be able to select the parts of its context to delete.
- The model should not hallucinate from the missing context 

One exercise we could do is to train models to solve very hard problems (that need billions of tokens to solve today) with very small context.


## Evaluation

Evaluation requires reproducibility.
I think we can retrofit completions API to create a reproducible state where you can test your prompts and models.
You will annotate which parts of the prompt are NOT cached, and not cached since which turn.
With this you can replay the entire chat history and the prompt decaching steps.



## Why is this important

If you want to interact with an AI live, you probably do not want the AI to stall at every 100k tokens.

With this we can continue investing in transformer architecture, and reuse all the tools used to optimize and interpret.

ICPC 2025 is solved with LLMs using a lot of compute.
I expect a laptop sized model to solve ICPC 2026.
I expect a phone size model to solve ICPC 2027.
I think prompt decaching is one ingredient to get LLMs to solve ICPC 2027 on a phone.

LLMs will be reading much, much more tokens soon, from videos.
Videos will need to be represented with a lot of tokens to preserve the information.
We need to teach LLMs to accurately forget so that they can continuously accept tokens.
Getting LLMs to decache text would be the starter task.


