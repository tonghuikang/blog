---
layout: post
title: "Machine Learning Interview questions"
---


I would expect a machine learning interview to start with asking about a machine learning project that you have done.

The interviewer will probe your project with the following questions. Make sure you have a machine learning project you are proud to showcase, and you need to know your project well.

- What problem does it try to solve?
- Evaluate the performance of your solution
- Compare your solution to the state of the art
- Justify the decisions that you have made
- Explain the machine concepts that you have used in the project


If there is time after explaining your machine learning project, or the interviewer wants to test the breadth of your knowledge, the following questions are what I think are reasonable and interesting questions to ask.

For every question, answer your question concisely with four lines, so that this invites the interviewer to probe what they are interested in. This means that you need to consolidate your knowledge on the topic, even if you are an expert in the topic.


The following is the table of contents.

* auto-gen TOC:
{:toc}




# Useful Resources


- Patrick Halina's ML Systems Design Interview [Guide](http://patrickhalina.com/posts/ml-systems-design-interview-guide/)
- Shusen Wang's [English](https://www.youtube.com/channel/UCvGjdt8iWN5P9I6LYeIHN8A) and [Chinese](https://www.youtube.com/c/ShusenWang) Youtube channel
- Chip Huyen's Designing Machine Learning Systems [book](https://www.amazon.com/Designing-Machine-Learning-Systems-Production-Ready/dp/1098107969)
- Chip Huyen's Machine Learning Interviews [Book](https://huyenchip.com/ml-interviews-book/contents/part-ii.-questions.html)
- Google Machine Learning [courses](https://developers.google.com/machine-learning)
- Directory of [industrial applications](https://applyingml.com/papers/) of ML
- Martin Zinkevich's [Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml)
- Matthieu de Mari's [course notes](https://github.com/matthieudemari/SUTD_DL_50_039) on selected ML topics




# Machine Learning Fundamentals


Why do we split the data into a training set, a validation set and a test set?

- TBC



Why do we do cross-validation?

- We want to use all the data to train our model, while maintaining train-test split.



Explain the bias-variance tradeoff

- TBC



What is precision and recall?

- Precision is the fraction of relevant instances among the retrieved instances.
- Recall is the fraction of relevant instances that were retrieved.
- Increasing the threshold always decreases recall, but may increase precision.



How do you define the loss for a regression task and a classification task?

- TBC



Describe how a linear regression or logistic regression model is trained.

- TBC



What is the difference between supervised and unsupervised learning?

- TBC (might feel too basic)



What is meant by finetuning and pretraining a model?

- TBC



# Tree-based Models


How is a decision tree trained?

- A decision tree is a tree of if-else statements, that ends up in a leaf where the classification or the regression value is made. The partition is chosen such that information gain or is maximized.
- However, decision trees are prone to overfitting. Measures to reduce overfitting include imposing a max depth, a minimum number of samples required in a node, or a minimum impurity decrease.



What are Gradient Boosted Decision Trees (GBDT)?

- In Gradient Boosted Decision Trees (GBDT), each decision tree attempts to minimize the errors of the previous tree. The learning rate suggests how fast should the model learn, and in statistical learning, models that learn slower perform better. We can choose the number of trees to use in GBDT, and too many trees will cause overfitting.
- Reference: [0](https://blog.csdn.net/shine19930820/article/details/65633436) [1](https://towardsdatascience.com/decision-tree-and-random-forest-explained-8d20ddabc9dd) [2](https://towardsdatascience.com/gradient-boosted-decision-trees-explained-9259bd8205af) [3](https://datascience.stackexchange.com/questions/39193/adaboost-vs-gradient-boosting)



What is the difference between a random forest and GBDT?

- A random forest combines many decision trees in parallel. Each decision tree trains on a random subset of samples and features, and this method is known as bagging. Excessive trees will not cause overfitting, although it results in unnecessary computation at inference.
- GBDT combines decision trees in series. Each trees minimize the errors of the previous tree. Too many trees will cause overfitting.



What is the difference between XGBoost, LightGBM and CatBoost?

- XGBoost was published in 2016, LightGBM and CatBoost in 2017.
- LightGBM and CatBoost allow categorical variables, whereas XGBoost does not. CatBoost finds the best possible feature combinations and considers them as a single feature.
- XGboost uses histogram approximations to do exact searches for optimal splits, while LightGBM uses gradient-based one-side sampling and exclusive feature bundling to make training faster.
- Reference: [0](https://towardsdatascience.com/catboost-vs-light-gbm-vs-xgboost-5f93620723db) [1](https://datascience.stackexchange.com/questions/49567/lightgbm-vs-xgboost-vs-catboost) [2](https://medium.com/riskified-technology/xgboost-lightgbm-or-catboost-which-boosting-algorithm-should-i-use-e7fda7bb36bc) [3](https://towardsdatascience.com/what-makes-lightgbm-lightning-fast-a27cf0d9785e) [4](https://hanishrohit.medium.com/whats-so-special-about-catboost-335d64d754ae)



How is feature importance calculated in a tree-based model?

- Gain and split options




# Neural Network Fundamentals


Describe the components of a simple neural network

- Neurons, weights, bias, activation function



Describe how backpropagation works

- Compute the gradient of last layer w.r.t. to the loss, compute the gradient of the next last later w.r.t. last layer, and so on.



What is batch normalization and what problem does it solve?

- Each minibatch is processed in parallel in the model. The output of each layer is normalized.
- In testing, the output is normalized to a running average in the training set.
- Improves gradient flow.



What is regularization and what problem does it solve?

- Reduce overfitting



What are residual connections and what problem does it solve?

- Residual connections allow gradients to flow through a network directly, without passing through non-linear activation functions.
- Addresses the vanishing gradient problem.



What is dropout and what problem does it solve?

- Residual connections
- LSTM



What is the difference between RNN, LSTM, and GRU?

- RNN has no memory cell
- LSTM addresses the vanishing gradient problem
- GRU is another implementation of LSTM (with different gate names) 



What is the vanishing gradient problem and how it is resolved?

- Residual connections
- LSTM



Describe the various hyperparameters in neural networks and the tradeoffs involved

- Learning rate - how fast the gradient updates (refer to optimizers)
- Batch size - how many data point to compute at once, and the gradient is updated afterwards
- Training iterations - how long to train, usually stop when the best validation loss does not improve after a while



Describe the various optimizers and their differences

- Stochastic gradient descent - update weights proportional to the gradient
- Momentum - gradient updates include an exponential weighted average of past gradient updates
- RMSProp - gradient updates are large when the exponential weighted average of the past gradient is small
- Adam - RMSPro with momentum, element-wise computations (and scaling to fix moving average)



What are some ways to analyze the feature importance in a neural network?

- TBC



How do you fool a neural network?

- See [course notes](https://github.com/matthieudemari/SUTD_DL_50_039/tree/main/W8S1-2-3%20-%20Attacks%20and%20Defense%20on%20Neural%20Networks)




# Natural Langauge Processing (NLP) Fundamentals


Describe the preprocessing methods for processing text input

- Tokenization



What are some traditional ways to generate word embeddings?

- SkipGram, Continuous Bag-of-Words, Word2Vec, GloVe
- See [course notes](https://github.com/matthieudemari/SUTD_DL_50_039/blob/main/W9S1-2-3%20-%20The%20Embedding%20Problem%2C%20Attention%20and%20Transformers/2.%20W9S2%20final/W9S2.pdf)



What are some ways to perform named entity recognition for text?

- Conditional Random Field




# Attention Mechanism and Transformers


What is the attention mechanism?

- TBC



What are transformers?

- TBC



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




# Computer Vision (CV)


What is the difference between the various historically significant computer vision models?

- VGG - multiple blocks, each block has multiple layers of CNN and max pool to downsample
- ResNet - Residual connections and batch normalisation



What is a Variational Autoencoder (VAE)?


- Convolution, bottleneck layer, deconvolution
- Probability latent representation in the bottleneck layer



How do you set up and train a model to perform the following downstream image tasks

- Image segmentation



What are the main innovations behind these recent advances in image models?

- Visual Transformers
- CLIP




# Image Generation Methods


How is a Generative Adversarial Network trained, what are the challenges of training one?

- Critic and generator, interleaved training
- Nash equilibrium where either the generator or critic is interested to change its own strategy.
- See [course notes](https://github.com/matthieudemari/SUTD_DL_50_039/tree/main/W11S1-2-3%20-%20Generative%20Deep%20Learning)



What are the main innovations behind these recent advances in image generation models?

- OpenAI DALLE
- Google Imagen
- Stable Diffusion




# Reinforcement Learning (RL)

(Other more basic reinforcement learning questions)

What are the main innovations behind these recent advances in reinforcement learning?

- AlphaGo
- AlphaStar
- AlphaTensor




# Graph Neural Networks (GNN)

What is a Graph Neural Network does, and how is it trained?

- See [course notes](https://github.com/matthieudemari/SUTD_DL_50_039/tree/main/W10S1-2-3%20-%20GCNs)



What are some applications of Graph Neural Networks?

- Traffic prediction in [Google Maps](https://deepmind.com/blog/article/traffic-prediction-with-advanced-graph-neural-networks)




# Recommendation Systems

From a Github [pull request](https://github.com/chiphuyen/ml-interviews-book/pull/37/files). I actually work in recommendation systems.


1. Overall
    1. [E] How do large-scale recommendation systems work?
    2. [E] What are some product requirements you want to clarify before building a recommendation system?
    3. [E] How do you decide whether to recommend items in real-time, or in batches?
    4. [H] Design a recommendation system for my startup that is starting to get user traction.
    5. [H] Describe one improvement you want to make on an existing large-scale recommendation system, and how would you test the improvement.

2. Ranking
    1. [E] What are some features that can be used for ranking in recommendation systems?
    2. [E] What models should you use for ranking in recommendation systems?
    3. [M] What are some factors deciding whether calibration is important for a ranking model?
    4. [M] What are some ways to calibrate a model?
    5. [E] How do you evaluate whether your recommendation system ranking model is stale?
    6. [M] How do you decide how often should you retrain your recommendation system ranking models?
    7. [H] What are some recent advances in the ranking algorithms for recommendation systems?

3. Candidate retrieval
    1. [E] What are some ways to retrieve candidates in a recommendation system?
    2. [E] How do you generate embeddings with matrix factorization?
    3. [M] How do you generate embeddings with neural networks? What are some advantages of this method over matrix factorization?
    4. [H] What are some recent advances in candidate retrieval in recommendation systems?

4. Filtering and Constraints
    1. [E] Why is filtering done after candidate retrieval, and before ranking?
    2. [E] What is a bloom filter and how does it work?
    3. [M] What are some issues with recommending items with the highest probability of positive actions? How do we resolve these issues?

5. A/B Testing
    1. [M] How do you run an A/B test to determine the effect of a recommendation system algorithm change on content consumers?
    2. [H] How do you run an A/B test to determine the effect of a recommendation system algorithm change on content creators?

6. Cold start problem
    1. [E] What is the user cold start problem in recommendation systems, and what can be done to address it?
    2. [M] What is the content cold start problem in recommendation systems, and what can be done to address it?




# Unclassified


What are the main innovations behind these recent machine learning advances?

- AlphaFold
- AlphaCode


Should be included, still trying to find a way to categorize it

- Information retrieval concepts
- MLOps


Todo

- Think of a way to organize the questions so that it makes sense
- Cite original arXiv papers
- Explain how these questions are chosen and organized
- Highlight questions that are more likely to be asked
