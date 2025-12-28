---
layout: post
title: Papers that I kept in 2025
---
I am moving from one place to another. Over my stay in the United States, I have printed plenty of papers. These are the papers I have kept as I moved[^disclaimer], on large language models and recommendation systems.

[^disclaimer]: This just means that I previously printed the papers, and I did not discard the papers as I moved my residence within the Bay Area. There are very impactful papers in the field that I did not print. There are also papers in the list which I had not really read.


## Large Language Model papers


**Training guides**

- How to Scale Your Model [[link](https://jax-ml.github.io/scaling-book/)] Google DeepMind, 2025 - If you want a good [shot](https://twopug.com/interview-prep-ml-grind/) at training LLMs, you will need to do the included homework.


**GRPO and variants** - I write about my views on [GRPO](https://blog.huikang.dev/2025/10/28/group-relative-policy-optimization.html). It is only recently that I [found](https://www.interconnects.ai/p/the-dpo-debate) out about this [meme](https://x.com/tomgoldsteincs/status/1729910334318633116) which I agree from the left side.

- Group Sequence Policy Optimization [[link](https://arxiv.org/abs/2507.18071)] Qwen, 24 Jul 2025
- Understanding R1-Zero-Like Training: A Critical Perspective [[link](https://arxiv.org/abs/2503.20783)] Sea AI Lab, 26 Mar 2025 - This introduces "Dr.GRPO".
- Why RLHF (and Other RL-Like Methods) Don't Bring True RL to LLMs [[link](https://www.linkedin.com/pulse/why-rlhf-other-rl-like-methods-dont-bring-true-rl-llmsand-atlas-wang-s1efc/)] Atlas Wang, 2025
- DeepSeekMath: Pushing the Limits of Mathematical Reasoning in Open Language Models [[link](https://arxiv.org/abs/2402.03300)] DeepSeek, 5 Feb 2024 - This is the GRPO paper.
- KTO: Model Alignment as Prospect Theoretic Optimization [[link](https://arxiv.org/abs/2402.01306)] Cohere, 2 Feb 2024
- ORPO: Monolithic Preference Optimization without Reference Model [[link](https://arxiv.org/abs/2403.07691)] KAIST, 12 Mar 2024
- Direct Preference Optimization: Your Language Model is Secretly a Reward Model [[link](https://arxiv.org/abs/2305.18290)] Stanford, 29 May 2023 - This is the DPO paper.
- A General Theoretical Paradigm to Understand Learning from Human Preferences [[link](https://arxiv.org/abs/2310.12036)] DeepMind, 18 Oct 2023 - They call their algorithm IPO.


**Technical reports** - I will read this in the future to look back what models were optimizing for.

- Mixtral of Experts [[link](https://arxiv.org/abs/2401.04088)] Mistral AI, 8 Jan 2024
- Kimi k1.5: Scaling Reinforcement Learning with LLMs [[link](https://huggingface.co/papers/2501.12599)] Moonshot AI, 20 Jan 2025
- DeepSeek-R1: Incentivizing Reasoning Capability in LLMs via Reinforcement Learning [[link](https://arxiv.org/abs/2501.12948)] DeepSeek, 22 Jan 2025
- GLM-4.5: Agentic, Reasoning, and Coding (ARC) Foundation Models [[link](https://arxiv.org/abs/2508.06471)] Zhipu AI, 20 Jun 2025
- The Llama 3 Herd of Models [[link](https://arxiv.org/abs/2407.21783)] Meta, 31 Jul 2024
- LLaMA: Open and Efficient Foundation Language Models [[link](https://arxiv.org/abs/2302.13971)] Meta, 27 Feb 2023



**Efficiency efforts**

- LoRA: Low-Rank Adaptation of Large Language Models [[link](https://arxiv.org/abs/2106.09685)] Microsoft, 17 Jun 2021 - LoRA is now regaining popularity and Fireworks and Thinking Machines are supporting fine-tuning with LoRA.
- Hyena Hierarchy: Towards Larger Convolutional Language Models [[link](https://arxiv.org/abs/2302.10866)] Stanford, 21 Feb 2023 - Tri Dao contributed to this paper. I kept this because I want to understand how attention can be made theoretically faster with approximations.



**Prompting** - Now models are trained to effectively run long chains of thoughts without prompting.

- Let's Verify Step by Step [[link](https://arxiv.org/abs/2305.20050)] OpenAI, 31 May 2023
- Chain-of-Thought Prompting Elicits Reasoning in Large Language Models [[link](https://arxiv.org/abs/2201.11903)] Google, 28 Jan 2022
- In-Context Learning for Extreme Multi-Label Classification [[link](https://arxiv.org/abs/2401.12178)] Ghent University, 22 Jan 2024 - I printed this because I used this in my actual work.



**Early alignment efforts** - I kept this to read in the future to understand what people were thinking.

- Training Language Models to Follow Instructions with Human Feedback [[link](https://arxiv.org/abs/2203.02155)] OpenAI, 4 Mar 2022
- Reinforced Self-Training (ReST) for Language Modeling [[link](https://arxiv.org/abs/2308.08998)] DeepMind, 17 Aug 2023
- RLAIF: Scaling Reinforcement Learning from Human Feedback with AI Feedback [[link](https://arxiv.org/abs/2309.00267)] Google, 1 Sep 2023
- Constitutional AI: Harmlessness from AI Feedback [[link](https://arxiv.org/abs/2212.08073)] Anthropic, 15 Dec 2022



## Recommendation Systems papers


For an introduction to recommendation systems, I recommend
- This Chinese language [playlist](https://www.youtube.com/playlist?list=PLvOO0btloRntAi-VnV06M1Bu0X1xljUUP) by Shusen Wang.
- Recommendation systems viewed in [four stages](https://medium.com/nvidia-merlin/recommender-systems-not-just-recommender-models-485c161c755e), with online and offline processes.





**Value modeling** - Recommendation systems calculate P(action) for multiple actions, for each candidate. The candidates are ranked based on a utility function. The utility function takes the action probability as arguments. You need to design a good utility function for your recommendation system.

- What We Know About Using Non-Engagement Signals in Content Ranking [[link](https://arxiv.org/abs/2402.06831)] Integrity Institute, 9 Feb 2024 - This puts down in writing that engaging content is usually negatively correlated with "quality".
- Multi-Objective Recommendation via Multivariate Policy Learning [[link](https://arxiv.org/abs/2405.02141)] Spotify, 3 May 2024
- Feedback Shaping: A Modeling Approach to Nurture Content Creation [[link](https://arxiv.org/abs/2106.11312)] LinkedIn, 21 Jun 2021


**Training multi-task models** - We usually use one neural network model to predict multiple action probabilities. The alternative is to use a separate model to predict each action probability. However,  sometimes individual models are better at predicting action probabilities than the combined model, even controlling for total parameter count. Hence there is this line of research to bridge the performance gap.

- Modeling Task Relationships in Multi-task Learning with Multi-gate Mixture-of-Experts [[link](https://dl.acm.org/doi/10.1145/3219819.3220007)] Google, 13 Jun 2018
- Progressive Layered Extraction (PLE): A Novel Multi-Task Learning (MTL) Model for Personalized Recommendations [[link](https://dl.acm.org/doi/10.1145/3383313.3412236)] Tencent, 22 Sep 2020
- Recommending What Video to Watch Next: A Multitask Ranking System [[link](https://dl.acm.org/doi/10.1145/3298689.3346997)] Google, 10 Sep 2019


**Calibration** - When you ship a ranking model (the model that predicts P(action) for multiple actions), you also ship how miscalibrated it is. I think calibration is a very easily misunderstood topic. The concept of calibration should have been taught and tested in schools.

- On Calibration of Modern Neural Networks [[link](https://arxiv.org/abs/1706.04599)] Cornell University, 14 Jun 2017
- Why Model Calibration Matters and How to Achieve It [[link](https://www.unofficialgoogledatascience.com/2021/04/why-model-calibration-matters-and-how.html)] Google, Apr 2021
- Multi-task Learning and Calibration for Utility-based Home Feed Ranking [[link](https://medium.com/pinterest-engineering/multi-task-learning-and-calibration-for-utility-based-home-feed-ranking-64087a7bcbad)] Pinterest, 14 Sep 2020
- The Foundations of Cost-Sensitive Learning [[link](https://dl.acm.org/doi/10.5555/1642194.1642224)] UCSD, 4 Aug 2001
- Predicting Good Probabilities with Supervised Learning [[link](https://dl.acm.org/doi/10.1145/1102351.1102430)] Cornell, 7 Aug 2005


**Feature engineering** - Manually engineering features does not scale well. Whenever you add a new feature you will need to implement all the feature crosses. It would be great if this process is learnt by the model instead.

- DCN V2: Improved Deep & Cross Network and Practical Lessons for Web-scale Learning to Rank Systems [[link](https://arxiv.org/abs/2008.13535)] Google, 31 Aug 2020 - I wrote about this [here](https://recsys.quora.com/Deep-and-Cross-Network).


**Sequence feature modeling** - Your sparse features could be a sequence of IDs. You might believe that you can make better predictions on action probabilities by learning from this sequence.

- TransAct: Transformer-based Realtime User Action Model for Recommendation at Pinterest [[link](https://arxiv.org/abs/2306.00248)] Pinterest, 1 Jun 2023
- Behavior Sequence Transformer for E-commerce Recommendation in Alibaba [[link](https://arxiv.org/abs/1905.06874)] Alibaba, 16 May 2019
- Search-based User Interest Modeling with Lifelong Sequential Behavior Data for Click-Through Rate Prediction [[link](https://arxiv.org/abs/2006.05639)] Alibaba, 10 Jun 2020 -  Shusen Wang covered this [here](https://www.youtube.com/watch?v=_4J9aF5KR84).
- Deep Interest Network for Click-Through Rate Prediction [[link](https://arxiv.org/abs/1706.06978)] Alibaba, 21 Jun 2017 - This is known as DIN. Shusen Wang covered this [here](https://www.youtube.com/watch?v=_4J9aF5KR84).


**Trainable embeddings** - If your model uses sparse features (item IDs, action type is an example of a sparse feature, float values like age is an example of a dense feature), you will need to map each ID to an embedding and train the embeddings. The problem happens when you have too many IDs to train on. You cannot just fit all the sparse feature embeddings into one GPU.

- Monolith: Real Time Recommendation System With Collisionless Embedding Table [[link](https://arxiv.org/abs/2209.07663)] ByteDance, 16 Sep 2022
- Efficient Data Representation Learning in Google-scale Systems [[link](https://dl.acm.org/doi/10.1145/3604915.3608882)] Google, 14 Sep 2023



**Pretrained embeddings** - In your neural network model, you can also use embeddings that you do not intend to train. One such embedding is content embeddings, and you can introduce content embeddings to the neural network model, thinking that the model can better predict the action probabilities by knowing more about the content. You still need to prove that these embeddings are useful, and even if you fail to do so, you should be prepared to learn something.

- Cross-lingual Language Model Pretraining [[link](https://arxiv.org/abs/1901.07291)] Facebook AI, 22 Jan 2019 - This introduces XLM embeddings.
- Text Embeddings by Weakly-Supervised Contrastive Pre-training [[link](https://arxiv.org/abs/2212.03533)] Microsoft, 7 Dec 2022 - This introduces E5 embeddings.




**Two tower model** - Recommendation systems involve first retrieving thousands of candidates from millions of indexed content. Currently, you index with the item embedding, you retrieve with the user embedding, for items with the largest dot product. The two tower model produces the item and user embedding. You need to train the model.

- Self-supervised Learning for Large-scale Item Recommendations [[link](https://arxiv.org/abs/2007.12865)] Google, 25 Jul 2020
- Cross-Batch Negative Sampling for Training Two-Tower Recommenders [[link](https://arxiv.org/abs/2110.15154)] Huawei, 28 Oct 2021
- Mixed Negative Sampling for Learning Two-tower Neural Networks in Recommendations [[link](https://dl.acm.org/doi/10.1145/3366424.3386195)] Google, 20 Apr 2020
- Sampling-Bias-Corrected Neural Modeling for Large Corpus Item Recommendations [[link](https://dl.acm.org/doi/abs/10.1145/3298689.3346996)] Google, 10 Sep 2019
- Deep Neural Networks for YouTube Recommendations [[link](https://dl.acm.org/doi/10.1145/2959100.2959190)] Google, 15 Sep 2016



**User interest exploration** - A good recommendation system does not just recommend content similar to ones that you have liked. The recommendation system should also appropriately explore what other types of content that you might like.

- Values of User Exploration in Recommender Systems [[link](https://dl.acm.org/doi/10.1145/3460231.3474236)] Google, 13 Sep 2021



**Item exploration** - New content is important to any recommendation system. To determine successful new content, you will need to deliver the new content to people. When you make a change to a recommendation system, you need to prove that your change is good. However, if you have a variant that delivers more new content to people, the engagement that the variant gets suffers. You still need to prove that new content is good, and the traditional user-split A/B testing approach cannot prove this, even though we know that recommendation system needs at least some new content.

- Nonlinear Bandits Exploration for Recommendations [[link](https://dl.acm.org/doi/10.1145/3604915.3610245)] Google, 14 Sep 2023
- Online Matching: A Real-time Bandit System for Large-scale Recommendations [[link](https://arxiv.org/abs/2307.15893)] Google, 29 Jul 2023
- Long-Term Value of Exploration: Measurements, Findings and Algorithms [[link](https://arxiv.org/abs/2305.07764)] Google, 12 May 2023
- Fresh Content Needs More Attention: Multi-funnel Fresh Content Recommendation [[link](https://arxiv.org/abs/2306.01720)] Google, 2 Jun 2023



**Recommendation as sequence prediction** - Instead of predicting the P(action), there is a line of research where you predict the item directly, similar to how you predict words in a sentence. I think this line of work only starts contributing value when you have systems that are bilingual in semantic IDs and English. Eugene Yan has an open source [implementation](https://eugeneyan.com/writing/semantic-ids/).

- Actions Speak Louder than Words: Trillion-Parameter Sequential Transducers for Generative Recommendations [[link](https://arxiv.org/abs/2402.17152)] Meta, 26 Feb 2024 - I still do not understand this paper.
- Effective and Efficient Training for Sequential Recommendation using Recency Sampling [[link](https://arxiv.org/abs/2207.02643)] University of Glasgow, 6 Jul 2022
- BERT4Rec: Sequential Recommendation with Bidirectional Encoder Representations from Transformer [[link](https://arxiv.org/abs/1904.06690)] Alibaba, 15 Apr 2019
- Learning from Negative User Feedback and Measuring Responsiveness for Sequential Recommenders [[link](https://arxiv.org/abs/2308.12256)] Google, 23 Aug 2023



**Miscellaneous** - These are some papers that I do not manage to classify.

- Improving Training Stability for Multitask Ranking Models in Recommender Systems [[link](https://arxiv.org/abs/2302.09178)] Google, 18 Feb 2023
- Trustworthy Online Marketplace Experimentation with Budget-split Design [[link](https://arxiv.org/abs/2012.08724)] LinkedIn, 16 Dec 2020 - You cannot run a traditional A/B testing process for ads ranking because users in the variant can cannibalize the budget of the users in control. Even though the A/B test analysis reports that users in variant contributed more revenue to the users in control, the truth might be the opposite direction. Therefore you need an experiment design where the budget allocation is split.
- Why do tree-based models still outperform deep learning on tabular data? [[link](https://arxiv.org/abs/2207.08815)] 18 Jul 2022 - You cannot just migrate to a neural network from tree-based models and expect an improvement in metrics.
- Towards Understanding the Overfitting Phenomenon of Deep Click-Through Rate Prediction Models [[link](https://arxiv.org/abs/2209.06053)] Alibaba, 13 Sep 2022 - It seems that in recommendation systems if you train on more than one epoch you overfit.
- Fairness in Recommendation Ranking through Pairwise Comparisons [[link](https://arxiv.org/abs/1903.00780)] Google, 2 Mar 2019
- Practical Lessons from Predicting Clicks on Ads at Facebook [[link](https://dl.acm.org/doi/10.1145/2648584.2648589)] Facebook, 24 Aug 2014
- Efficient and robust approximate nearest neighbor search using Hierarchical Navigable Small World graphs [[link](https://arxiv.org/abs/1603.09320)] Russian Academy of Sciences, 30 Mar 2016 - This is the HNSW paper. I think it is a good idea to have some intuition on how approximate retrieval works so that you have some idea of what it can and cannot do.
- Deep Retrieval: Learning A Retrievable Structure for Large-Scale Recommendations [[link](https://arxiv.org/abs/2007.07203)] ByteDance, 14 Jul 2020 - I still do not really understand this. I recommend watching [this](https://www.youtube.com/watch?v=BYtzZ48hRFM).
- Full Index Deep Retrieval: End-to-End User and Item Structures for Cold-start and Long-tail Item Recommendation [[link](https://dl.acm.org/doi/10.1145/3604915.3608773)] ByteDance/SJTU, 14 Sep 2023 - This is a follow-up to the Deep Retrieval paper.



## Other ML resources

**Reinforcement learning** - I wrote about reinforcement learning [here](https://blog.huikang.dev/2025/08/23/reinforcement-learning-life-lessons.html).

- Reinforcement Learning: An Introduction [[link](http://incompleteideas.net/book/the-book-2nd.html)] Sutton & Barto, 2018


**Image models**

- High-Resolution Image Synthesis with Latent Diffusion Models [[link](https://arxiv.org/abs/2112.10752)] LMU Munich, 20 Dec 2021 - This is the stable diffusion paper.
- An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale [[link](https://arxiv.org/abs/2010.11929)] Google, 22 Oct 2020


**Attention mechanism** - I drew the attention mechanism [here](https://www.quora.com/profile/Tong-Hui-Kang-1/I-drew-an-image-of-the-attention-mechanism-of-of-Qwen2-5-0-5B-Instruct-Some-things-I-learnt-while-drawing-What-is-th).

- Attention Is All You Need [[link](https://arxiv.org/abs/1706.03762)] Google, 12 Jun 2017
- BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding [[link](https://arxiv.org/abs/1810.04805)] Google, 11 Oct 2018
- Long Short-Term Memory-Networks for Machine Reading [[link](https://arxiv.org/abs/1601.06733)] University of Edinburgh, 25 Jan 2016
- Neural Machine Translation by Jointly Learning to Align and Translate [[link](https://arxiv.org/abs/1409.0473)] Mila, 1 Sep 2014



## Footnotes

