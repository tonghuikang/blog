---
layout: post
title: Trying to understand the Model Context Protocol
---

This is my attempt at trying to understand the Model Context Protocol (MCP).

I will focus on the example of booking an AirBnb via an AI interface.


### What is wrong with the status quo (early 2025)?

You cannot book an AirBnb stay via ChatGPT / Claude.


### What are the parties involved?

- The users, who should not be expected to understand how technology works.
- The model provider (e.g. OpenAI, Anthropic)
- The AI interface provider (e.g. ChatGPT, Claude, Poe, Siri)
- The tools provider (weather service, AirBnb)


### What are the benefits for the parties involved with MCP?

- Users get to use more capable AI (book AirBnb via ChatGPT)
- The model provider gets more API revenue from their models
- The AI interface provider gets more usage and subscription / advertisement revenue
- The tools provider gets usage (AirBnb gets more bookings)



### Why can't we just get AI to browse like any human would?

AirBnb would prefer that bots do not pretend to be human when visiting their website.
This can cause undue load to the website.
AirBnb would prefer that you call their API than to impersonate a human.

Browsing the web is slower than directly accessing the tools.
Users would prefer to get their results quickly.

Tool use could also unblock processes that would be time consuming on a web browser - for example viewing and comparing 50 candidates and reading all the reviews in parallel.



### Why can't we just use function calling?

It is possible to provide the tools for the LLM to decide what tools to use and use them.

However, I now understand maintaining function calling templates will soon be cumbersome and will not be sustainable.

Consider the following function calling templates from OpenAI and Anthropic SDKs

Anthropic Messages API

```json
[{
    "type": "function_call",
    "id": "fc_12345xyz",
    "call_id": "call_12345xyz",
    "name": "get_weather",
    "arguments": "{\"location\":\"Paris, France\"}"
}]
```

```
import anthropic
client = anthropic.Anthropic()

response = client.messages.create(
    model="claude-3-7-sonnet-20250219",
    max_tokens=1024,
    tools=[
        {
            "name": "get_weather",
            "description": "Get the current weather in a given location",
            "input_schema": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA"
                    },
                    "unit": {
                        "type": "string",
                        "enum": ["celsius", "fahrenheit"],
                        "description": "The unit of temperature, either \"celsius\" or \"fahrenheit\""
                    }
                },
                "required": ["location"]
            }
        }
    ],
    messages=[{"role": "user", "content": "What is the weather like in San Francisco?"}]
)

print(response)
```

```output
{
  "id": "msg_01Aq9w938a90dw8q",
  "model": "claude-3-7-sonnet-20250219",
  "stop_reason": "tool_use",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "<thinking>I need to call the get_weather function, and the user wants SF, which is likely San Francisco, CA.</thinking>"
    },
    {
      "type": "tool_use",
      "id": "toolu_01A09q90qw90lq917835lq9",
      "name": "get_weather",
      "input": {"location": "San Francisco, CA", "unit": "celsius"}
    }
  ]
}
```

OpenAI Responses API

```python
from openai import OpenAI

client = OpenAI()

tools = [{
    "type": "function",
    "name": "get_weather",
    "description": "Get current temperature for a given location.",
    "parameters": {
        "type": "object",
        "properties": {
            "location": {
                "type": "string",
                "description": "City and country e.g. Bogotá, Colombia"
            }
        },
        "required": [
            "location"
        ],
        "additionalProperties": False
    }
}]

response = client.responses.create(
    model="gpt-4.1",
    input=[{"role": "user", "content": "What is the weather like in Paris today?"}],
    tools=tools
)

print(response.output)
```

Note that even OpenAI currently has three ways of getting LLMs to use tools
- Chat Completions API (widely-used)
- Responses API ([recommended](https://community.openai.com/t/introducing-the-responses-api/1140929))
- Assistant API (will be deprecated)

As models evolve, we expect even more ways to get AI to use tools.

This does not scale.

If a tool provider (e.g. AirBnb) wants to enable models to make bookings on the user's behalf, AirBnb needs to publish the recommended prompts for all three versions of OpenAI API.

In my current understanding, MCP is meant to be the standard for function calling.

With this standard, AirBnb will only need to maintain one publication on how to use their tools.



### Who is responsible for what?

We want to enable booking AirBnb stay via ChatGPT.

Users
- Users should require no more digital literacy than what is required to make a booking at airbnb.com
- There should be some digital literacy though - for example not sharing your credit card number to suspicious websites.
- No knowledge of MCP is required, similar to how they do not need to understand HTTP when using the web.


Model providers
- They need to train models that are able to use tools reliably and safely.


AI interface providers
- They need to provide a trustworthy interface, by making it clear to the user
    - The information shared to the tool
    - When billing action happens
- Maintain the MCP client so that it can interact with the MCP server


Tool provider
- The tools have good uptime.
- The results from the tools are correct.
- How to use the tools is well-documented. The documentation serves as instructions (i.e. prompts) on how to use the tools.
- Maintain the MCP server so that MCP clients can interact with it



### Why MCP servers? Can't the client call the remote service directly?

First we should understand what is meant by MCP servers, and where are they.

The [introduction](https://modelcontextprotocol.io/introduction) presents the following architecture.

![MCP architecture](/assets/mcp-architecture.png)

> MCP Hosts: Programs like Claude Desktop, IDEs, or AI tools that want to access data through MCP
> 
> MCP Clients: Protocol clients that maintain 1:1 connections with servers
> 
> MCP Servers: Lightweight programs that each expose specific capabilities through the standardized Model Context Protocol
>
> Local Data Sources: Your computer’s files, databases, and services that MCP servers can securely access
>
> Remote Services: External systems available over the internet (e.g., through APIs) that MCP servers can connect to

In the starter [example](https://modelcontextprotocol.io/quickstart/server) of calling a weather service, the following describes what happens.

> When you ask a question:
>
> 1. The client sends your question to Claude
> 2. Claude analyzes the available tools and decides which one(s) to use
> 3. The client executes the chosen tool(s) through the MCP server
> 4. The results are sent back to Claude
> 5. Claude formulates a natural language response
> 6. The response is displayed to you!

What is standardized is the "MCP Protocol" - the communication between the MCP client (maintained by AI interface providers) and MCP servers (maintained by tool providers).

If you are configuring your client to "call the remote service directly", you are going back to "just using function callling".
I have presented how this would not scale, because of how LLM SDKs are not standardized, and how Web APIs are not standardized.
The proposed standardization is the "MCP Protocol".

Instead of the function calling where it is the duty of the AI interface developer to figure out how to use the tool, the duty is passed to the tool provider.
The tool provider maintains a "MCP Server". [^1]

[^1]: There are now [remote MCP servers](https://support.anthropic.com/en/articles/11175166-about-custom-integrations-using-remote-mcp).
    The MCP servers no longer need to be on the user's computer.
    The user or the AI interface only needs to [copy a URL](https://x.com/alexalbert__/status/1918047745790914772) provided by the tool provider.



### When do we still use function calling?

If you want to query the weather, the quickstart with function calling is faster than the quickstart with MCP.

MCP is meant for developers participating in a marketplace of AI interfaces, models, and tools. 

In other words, if you are the tool provider and the AI interface, you should just use function calling directly. [^2]

[^2]: I made an internal tool to iteratively query offline tables.
    I wrote the tools (read code, query table).
    I built the interface (interactive Python).
    I don't need to use MCP here, I could just call the function directly.
    However, if multiple people want to use my tools, I should have some standard, MCP or otherwise.



### References

These are the resources that I have based my research on

- [modelcontextprotocol.io/faqs](https://modelcontextprotocol.io/faqs)
- [modelcontextprotocol.io/quickstart/server](https://modelcontextprotocol.io/quickstart/server)


### Footnotes
