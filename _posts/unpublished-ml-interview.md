---
layout: post
title: "Machine Learning Interview questions"
---


I am not involved in the machine learning interview process, but I think this is what you can reasonably to prepare for.


# Know your ML project very well

I would expect a machine learning interview to start with asking about a machine learning project that you have done.

- What business problem does it try to solve? How did you formulate your business problem into a machine learning problem?
- Why is your solution good? Based on what metrics? Why do you choose these metrics? What are the tradeoffs?
- What are the technical decisions that you have made (e.g. model architecture)? How do you justify the decisions? Are you aware of all the decisions made (e.g. whether model training uses batch normalization)?
- Do you understand the technical concepts involved in your solution?



# Questions that you should prepare for

These are some questions that you should be prepared to answer regardless of whether you have worked on them. This should be a short list.


What is an interesting machine learning paper that you have read recently?

- This question will show whether you are keeping up to date in the machine learning field.
- There is no model answer for this, you need to actually read and understand the paper.
- Usually, each paper have one key concept, and the purpose of the paper is to defend the novelty and usefulness of the idea with prior literature and new result. Focus on getting the key concept across.



What are Gradient Boosted Decision Trees (GBDT)?

- (GBDTs are the default model to use in tabular machine learning because of its great performance out-of-the-box. It is important to understand how it works.)
- A decision tree is a tree of if-else statements, that ends up in a leaf where the classification or the regression value is made. The partition is chosen such that information gain is maximized.
- However, decision trees are prone to overfitting. Measures to reduce overfitting include imposing a max depth, a minimum number of samples required in a node, or a minimum impurity decrease.
- In Gradient Boosted Decision Trees (GBDT), each decision tree attempts to minimize the errors of the previous tree. The learning rate suggests how fast should the model learn, and in statistical learning, models that learn slower perform better. We can choose the number of trees to use in GBDT, and too many trees will cause overfitting.
- Reference: [0](https://blog.csdn.net/shine19930820/article/details/65633436) [1](https://towardsdatascience.com/decision-tree-and-random-forest-explained-8d20ddabc9dd) [2](https://towardsdatascience.com/gradient-boosted-decision-trees-explained-9259bd8205af) [3](https://datascience.stackexchange.com/questions/39193/adaboost-vs-gradient-boosting)



Describe the transformer architecture.

- Previously, a sequence to sequence task (like machine translation) uses an RNN (could also be LSTM, GRU) - one RNN for an encoder, and another RNN for a decoder.
- The attention mechanism was first used to improve a sequence to sequence task. Instead of only depending on the previous state for context, we take a weighted average of all previous states of the encoder for context. The weights are learned (see Scaled Dot-Product Attention). The downside of using attention is that it increases the time complexity is O(mn). [Paper](https://arxiv.org/pdf/1409.0473.pdf)
- Self-attention applies the attention mechanism on non sequence to sequence tasks. [Paper](https://arxiv.org/abs/1601.06733) The difference is that both the inputs to the self-attention layer are the same.
- The [paper](https://arxiv.org/pdf/1706.03762.pdf) "Attention is all you need" removes the RNN part and uses attention only, and shows that it works for a sequence to sequence task. This introduces the transformer architecture.
The transformer architecture
    - Scaled Dot-Product Attention
        - $C = Attn(X, X')$
        - Query: $q_j = W_Q x_j'$
        - Key: $k_i = W_K x_i$
        - Value: $v_i = W_V x_i$
        - Output: $c_j = V \cdot \hat{\alpha} = V \cdot \text{Softmax}(K^T q_j)$
        - Each input is mapped to query, key and value vectors.
        - We compute the $\alpha$ weights with a product of query and key value vectors, and take a softmax.
        - The context vector is a weighted average of value vectors.
    - Multi-head attention. Instead of one attention mechanism, we have multiple duplicate mechanisms that does not share weights. The output vector is concatenated.
    - Stacked attention layers. After each self-attention layer, we apply a dense layer and add a residual connection. This forms one block. The encoder network is made up of six blocks.
    - Decoder block. Each decoder block is made of one masked multi-head attention layer, and one multi-head attention. The decoder network is made up of six blocks.
- BERT is a way to pretrain a transformers' encoder. [Paper](https://arxiv.org/pdf/1810.04805.pdf)
    - Predicting a missing word
        - Mask a token in the sentence.
        - The [MASK] sat on the mat.
        - Pass the sentence through the encoder network.
        - Apply a softmax classifier on the context vector of the [MASK] token and predict. 
        - Train with crossentropy loss.
    - Predicting the whether two sentence are consecutive
        - [CLS] First sentence. [SEP] Second sentence.
        - Pass the sentences through the encoder network.
        - Apply a binary classifier on the context vector of [CLS] token.
        - Train with crossentropy loss.
    - Train with both methods
        - There are three tasks in each sample - predict whether the sentences are consecutive, one missing word from each sentence.
        - No manually labelled data is needed.



What are the main innovations behind some recent large language models?

- BERT / RoBERTa (MLM)
- GPT-2 / GPT-3 (CLM)
- XLNet (permutation technique)
- LaMDA

- A Masked Language Modeling (MLM) predicts a masked word based on other words in a sentence.
- A Causal Language Modeling (CLM) predicts the next word in a sentence with only words on its left.
- MLM loss is preferred when the goal is to learn a good representation of the input document, whereas, Causal Language Modeling (CLM) is mostly preferred when we wish to learn a system that generates fluent text.
- XLNet uses a permutation technique to make use of the best of both worlds.
- [Reference](https://towardsdatascience.com/understanding-masked-language-models-mlm-and-causal-language-models-clm-in-nlp-194c15f56a5)




# Useful Resources


- Patrick Halina's ML Systems Design Interview [Guide](http://patrickhalina.com/posts/ml-systems-design-interview-guide/)
- Shusen Wang's [English](https://www.youtube.com/channel/UCvGjdt8iWN5P9I6LYeIHN8A) and [Chinese](https://www.youtube.com/c/ShusenWang) Youtube channel
- Chip Huyen's Designing Machine Learning Systems [book](https://www.amazon.com/Designing-Machine-Learning-Systems-Production-Ready/dp/1098107969)
- Chip Huyen's Machine Learning Interviews [Book](https://huyenchip.com/ml-interviews-book/contents/part-ii.-questions.html)
- Google Machine Learning [courses](https://developers.google.com/machine-learning)
- Directory of [industrial applications](https://applyingml.com/papers/) of ML
- Martin Zinkevich's [Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml)
- Matthieu de Mari's [course notes](https://github.com/matthieudemari/SUTD_DL_50_039) on selected ML topics



