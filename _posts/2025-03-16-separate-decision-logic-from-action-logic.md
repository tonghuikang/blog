---
layout: post
title: Decision logic should be separated from action logic
---
In this post, I specify what I mean by decision logic and action logic, and argue why they should be separated.

# Decision logic

Decision logic does not change the state on its own.

Examples of decision logic:
- Deciding whether to use tools in function calling
- Deciding whether to filter a piece of content
- Deciding whether to send a notification

Decision logic can be as simple as one if-else statement, or as complex as involving multiple LLM calls.

Decision logic should be evaluated. For deterministic logic, this should have unit tests. For non-deterministic logic such as methods involving an LLM, the LLM call could be mocked.

I should be able to sample and illustrate in a table, for a sample of 100 inputs with their relevant features, what the decision output is.

# Action logic

Action logic is code that changes the state of the product.

Examples of action logic:
- Use tools in function calling
- Filtering a piece of content
- Sending a notification

I should be able to execute the action. When the action logic is invoked, it should be assumed that all decisions have already been made. There should be no decision logic in the action.


# Why they should be separate

Consider the following call stack:

```
cron_to_send_notifications()
	content = retrieve_content()
	filter_content_and_process(content)
		if filter_content(content): return
		send_content_to_users(content)
			users = retrieve_users(content)
			maybe_send_content(content, users)
				for user in users:
					if filter_content_for_user(content, user): continue
					actually_send_notification(content, user)					
```

Let's say I want to figure out why a certain user is not getting a notification for a piece of content. I cannot simply call `maybe_send_content` to check the result because it executes an action that will have a product impact.

If I want to test the function for specific content and a specific user, I need to mock `send_notification` before I can try testing `filter_users`. Looking at the output is difficult as well, because I need to read what the mocked `actually_send_notification` is receiving.

We should separate decision logic from action logic. This is how we can flatten all the steps.

```
cron_to_send_notifications()
	retrieve_content()
	content = filter_content(content)
	users = retrieve_users(content)
	users = filter_users(content, users)
	send_notification(content, users)
```

Now it is very clear where I can test `filter_users`. The function `filter_users` has no impact on production, and I can call it without mocking anything. The inputs and outputs of the function are clear.

This is another way I could structure the notification logic.

```
cron_to_send_notifications()
	content, users = prepare_notifications()
		content = prepare_content()
			content = retrieve_content()
			content = filter_content(content)
		users = prepare_users(content)
			users = retrieve_users(content)
			users = filter_users(content, users)
	send_notification(content, users)
```

It makes answering questions like "What content is retrieved?" easier because I don't need to combine multiple functions to get the result. I could just call `prepare_content` instead of needing to combine the outputs of `retrieve_content` and `filter_content`.

One important principle here is that I do not mix decision logic with action logic. In the decision logic, there is no action logic. In the action logic, there is no decision logic.