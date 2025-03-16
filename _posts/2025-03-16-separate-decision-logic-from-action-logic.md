---
layout: post
title: Decision logic should be separated from action logic
---
In this post, I specify what I mean by decision code and action code, and argue why they should be separated.

# Decision logic

Decision logic does not change the state on its own.

Examples of decision logic:
- Deciding whether to use tools in function calling
- Deciding whether to filter a piece of content
- Deciding whether to send a notification

Decision logic could be just one if-else statement, or it could involve multiple LLM calls.

Decision logic should be evaluated. For deterministic logic, this should have unit tests. For non-deterministic logic such as methods involving an LLM, the LLM call could be mocked.

I should be able to sample and illustrate in a table, for a sample of 100 inputs with their relevant features, what the decision output is.

# Action logic

Action logic is code that changes the state of the product.

Examples of action logic:
- Use tools in function calling
- Filtering a piece of content
- Sending a notification

I should be able to execute the action. When the action logic is invoked, it should already be assumed that all the decisions are already made. There should be no decision logic in the action.


# Why they should be separate

Consider the following call stack:

```
cron_to_send_notifications()
	content = retrieve_content()
	filter_content_and_send(content)
		if filter_content(content): return
		send_content_to_users(content)
			users = retrieve_users(content)
			maybe_send_content(content, user)
				send_notification(content, users)
					users = filter_users(content, users)
					actually_send_notification(content, users)
```

Let's say I want to figure out why a certain user is not getting a notification for a piece of content. I could not just call `maybe_send_content` to check the result because it is executing an action that will have a product impact.

If I want to test the function for actual content and a specific user, I need to mock `send_notification` before I can try testing `filter_users`. Looking at the output is hard as well, because I need to read what the mocked `actually_send_notification` is receiving.

We should separate decision logic from action logic. This is how we can flatten all the steps.

```
cron_to_send_notifications()
	retrieve_content()
	content = filter_content(content)
	users = retrieve_users(content)
	users = filter_users(content, users)
	send_notification(content, users)
```

Now it is very clear where I can test `filter_users`. The function `filter_users` will have no impact on production, and I can call this function without mocking anything. The inputs and outputs of the function are clear.

This is another way I could structure the notification logic.

```
cron_to_send_notifications()
	content, users = prepare_notifications()
		content = prepare_content()
			retrieve_content()
			filter_content(content)
		users = prepare_users(content)
			users = retrieve_users(content)
			users = filter_users(users)
	send_notification(content, users)
```

It makes answering questions like "What content is retrieved?" easier to answer because I don't need to figure out that I need to combine two functions to get the result.

One important principle here is that I do not mix decision logic with action logic. In the decision logic, there is no action logic. In the action logic, there is no decision logic.