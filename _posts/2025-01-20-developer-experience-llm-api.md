---
layout: post
title: Developer Experience of Calling LLM APIs
---
I wrote a [page](https://tonghuikang.github.io/llm-pricing/) to compile the LLM prices. Here are my comments on the developer experience.

As of writing, OpenAI and Gemini models are great at classification tasks. Classification tasks are much easier to evaluate - either it is correct or it is incorrect. Gemini-Flash is much cheaper than 4o-mini. However, the developer experience using Gemini models is bad.

Anthropic models are better at writing. Writing tasks are difficult to evaluate. Writing a classifier to evaluate better writing is more difficult than prompting better writing.

Automatic prompt caching. OpenAI offers automatic prompt caching. Gemini and Anthropic models, you need to opt-in to prompt caching, and if you are not careful you might end up paying more money. Overall, you expect to get more savings from OpenAI prompt caching compared to Gemini and Anthropic prompt caching, unless you are spending more than your total compensation on LLM inference.

Ease of specifying prompt caching. Anthropic requires you to specify the prefix to be cached, whereas Gemini also requires you to also specify how long you intend the prefix to be cached. I have not implemented prompt caching yet, but it seems that I do not want to think about how long my prompts are going to live, and I don't want to call an LLM significantly different from how I usually call an LLM.

API responses should also specify the cost of the request, in dollars. Cost tracking is important to me because I need to understand the cost of my use case. Currently the response only contains information on the number of input tokens and the number of output tokens, and I need to look up API prices and write code to do the math. Additional logic is needed if prompt caching is involved. We know that LLMs uses the attention mechanism and parts of the compute scale quadratically with prefix length. Gemini models have a double cost per token beyond 100k tokens. Having the cost in the output will make my life easier.

There are four ways to call Gemini API
- [AI Studio](https://ai.google.dev/gemini-api/docs)
- [AI Studio with OpenAI API](https://ai.google.dev/gemini-api/docs/openai)
- [Vertex AI](https://cloud.google.com/vertex-ai/generative-ai/docs/start/quickstarts/quickstart-multimodal)
- [Vertex with OpenAI API](https://cloud.google.com/vertex-ai/generative-ai/docs/multimodal/call-vertex-using-openai-library) which is actually not because the "API key" only lives for one hour

Some methods are easier than the others. See this thread for [the rant](https://x.com/levelsio/status/1853774638473437451). For OpenAI and Anthropic API, most developers are only exposed to one way of calling them, even though Anthropic models are also served on [AWS](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-claude.html) and OpenAI models are also served on [Azure](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models).

I really wonder whether the Google engineers working on the feature has tested their API products. Have the engineers used their own API for their pet projects? Have they tried other APIs and compared the experience? Have they actually thought about developer experience?

As a developer working on features, I do not want to learn GCP or AWS or Azure. I want to get my job done. I know how easy things are to call with an OpenAI API. If using your LLM requires me to do things more complicated than this, it is not worth it.

Tutorial prompts could probably not require an API key. This makes it much easier to validate that the API actually works, and I just need the API key. If the developer wants to try something out other than what is exactly in the tutorial prompt, they can receive an error message requesting for an API key.
