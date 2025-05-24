---
layout: post
title: Prompting Projects
---
I write a checklist for prompt engineering projects.


## What exactly is the input?


You might think the answer is obvious.

However, here are some examples where people could get it wrong
- You want to check whether something is factual. However, LLMs cannot check facts that happen after their knowledge cutoff. The input should include updated resources from the Internet.
- You want to classify whether a piece of content is plagiarized. The input should include similar texts found on the Internet.
- You want to penalize a user for spamming comments. The input to the classifier is not that single comment, but their comment history.
- You want to penalize bad advertisements. The input is not just the ad copy itself, but should also include the landing page.

Understanding what exactly is the input will ensure that the model has the sufficient resources to make a decision.



## How is the output used?

Maybe the LLM output is merely an input to another model. For example, the labels that the LLM infers is used as a feature to predict whether the user will interact with an advertisement. You could be satisfied when the LLM produces labels that are much better than random. Your focus is to investigate whether adding these features helps to improve the performance of the downstream model.

You need to consider if your output will be used for unplanned use cases. For example, I want to identify high quality content, and the work includes identifying whether the content is on-brand. I write a prompt with high recall to identify off-brand content. If my colleague wants to use the same prompt to identify and penalize low quality content, I should stop my colleague. If they want to penalize low quality content, they should use a different prompt with a high precision.

Understanding how the output is used will help to inform whether you should prioritize precision or recall, and also how much effort do you want to spend on the prompting and the dataset.



## How is the average user experience affected?


For example, I want to improve the topic labels so that we can distribute content to the users better. Part of my dataset should include content sampled with impressions.

I should not do an id sample here. Like most content marketplaces, most of the content created do not get much distribution. The impression sample (not the id sample) is closer to the average experience that the user gets.

This way, I can illustrate how the topic labels has changed for typical impressions, so that we can understand the impact on the average user experience.



## Have you tested your prompts on edge cases?


Google wants to show AI overviews on search result pages. There are two tasks here - what to show in an AI overview, and whether to even show the AI overview. Google does not want to show AI overviews for adult queries, for example.

A reasonable sample that Google engineers could tune their prompts on and measure performance with is the random sample of search queries that users have made. However, this sample would not have included [queries](https://www.bbc.com/news/articles/cd11gzejgz4o) like "how many rocks should you eat in a day" or "should you apply glue to your pizza". These edge cases have a disproportionate impact on the success of your feature. You need to think of these edge cases that your prompts should not fail on.



## What is the human-level performance?

Give the dataset to your colleague and explain the instructions. Can your colleague perform well at the classification task?

I argue that democracy is a horrible way to build a dataset for LLM evaluation. Let's say you want to build dataset to determine whether an advertisement is low quality. You get your team to label the content and treat the labels as immutable ground truth. But you notice the labels provided by your team often disagrees with each other.

If you pass this dataset to your colleague, your colleague is simply guessing what people are voting. Your colleague will likely not perform well. This is what you will be tuning your prompt to. It is meaningless to claim that your prompt has a better performance better than a human here.

There are two things I will change to this process.
- I should align with is the product owner, not democracy. I should change the ground truth label if I think I have previously labelled the sample wrongly.
- I will also exclude samples from the evaluation where I think we should be fine with either classification.

Now your colleague should be able to achieve near perfect performance on the dataset. I would expect that it is now possible to find a prompt that achieves a similar performance.



## How do you intend to present the performance?


You think your prompt is ready. You want to present the performance to the product owner for approval. The product owner needs to have a good idea on what exactly are they approving. How do you represent your work honestly?

Here are some suggestions
- Show some samples of the output. You want to display the content on the same page (not just a url to the content).
- You also want the information to be easily accessible. You should not require the reader to scroll to the bottom of your notebook. I recommend sharing an internal url to a html table. 
- Describe some metrics and explain their context well. For example
	- The content accounting for 1% of total impressions will no longer get distributed due to the new adult filter. Here is an impression sample.
	- Among 100 pieces of content that will be classified as adult, we only find one regrettable false positive. Here is the sample.
	- These are the regrettable mistakes the model is making on the testing set we iterated my prompts on. This includes 20 pieces of content we think that the LLM is likely to make regrettable mistakes. Here is the sample.
- You should not include bullshit metrics. For example, accuracy on an unbalanced sample is a bullshit metric.



## What is the acceptance criteria?

For classification outputs, there could be some metrics calculated with the test dataset. Maybe among 100 impression sampled inputs and 20 edge case inputs we only spot less then three mistakes, and the product owner is okay with this rate.

For generation outputs, it could be performance as measured by another classification prompt. Let's say I am generating follow up questions to an answer. I could write a classification prompt to measure whether the question is a good follow up question - I do not want to ask questions that are already answered in the source answer, for example. Maybe the acceptance criteria here is some measurement using the classification prompt. Maybe we don't have enough time to write the classification prompt and we can approve the generation prompt if we cannot spot a regrettable mistake among 100 impression sampled input and 20 edge case inputs.

You should negotiate on how the acceptance criteria would look like. This way you can evaluate whether the project is worth doing and budget an appropriate amount of time.



## Who is actually signing off the prompts and its results?


The product manager that you collaborate with may have been approving your progress on the prompts and the dataset. However, the leadership might have an opinion that you are fitting the prompt to a wrong objective. You will need to realign prompts. To avoid this, you want to get early alignment with leadership on this so that you do not repeat your work.



## What is the estimated budget?


You do not want to use an expensive LLM and find out that you will exceed your budget and you will have to realign the prompts. You want to make a good cost estimate before selecting which model to use.

You also need to think whether you need to backfill on all content. Is it necessary to send a piece of content for classification if users have not seen it in the past few years? Even if you want to send all historical content for backfill, do you know how to do it, and have you budgeted sufficient time for this?



## How do you intend to monitor issues after launching?


The input data distribution changes over time. You want to know if this affects the performance of your prompts. Do you have logging to store the response text and the labels from the LLM?

You want your system to be able to learn over time. Do you have a process where people can report mistakes in the prompt output so that it informs the next iteration of the prompts?

Do you have a response process to live mistakes? Let's say you run Google search and users have discovered that Google AI overviews performs badly on queries like "should you eat rocks". How should you respond? Should you stop showing AI overviews until the issue is fixed, or could you implement some stopgap measures until you have written and tested the next iterations of the prompt? How fast can you ship the response?



## What is the process to replace the model and the prompts?

Let's say there is a new model that is 10% of the price of the approved model and prompts, what is the process to replace the approved model?

Let's say you discovered a prompt that is able to fix the edge cases and still retain a similar performance. What is the process to replace the approved prompt?

If the initial approval required an A/B test, do you need another A/B test? Is there a way to ship both prompts at the same time and compare their performance live?
