---
layout: post
title: "Tech Resume Advice"
---

I have been giving comments on technical resumes in Discord channels by the Tech Interview Handbook and cscareers.dev.

This is my general resume advice for anyone who asks for it.
If you want to read more, I have also written another post to describe [how](https://blog.huikang.dev/career/2022/11/13/resume-comment-template.html) I comment on resumes.




# Use Jake's Resume Overleaf template

The first impression of the resume is important. The reader gets the first impression without reading any text.

These are the common glaring formatting errors that would provide a bad first impression

- Inconsistent indentation
- Inconsistent alignment
- Inconsistent newline spacing
- Inconsistent date formats
- Inconsistent use of separators (e.g. between company and job title)
- Inconsistent chronological order
- Inconsistent font
- Inconsistent font size
- Inconsistent use of emphasis (underline, bold, italics, allcaps)
- Excessive use of emphasis
- Wrong use of capitalization for technical terminologies
- Incorrect usage of whitespace within the text (e.g. space before full stop)
- Large empty space

You can easily check and fix these mistakes if you use a template.
I recommend using [Jake's Overleaf template](https://www.overleaf.com/latex/templates/jakes-resume/syzfjbzwjncs).
The top part of the resume is shown below.
You need to be able to figure out how to use LaTeX, and even make edits to the template, which is expected of a tech professional.

![jake_resume_top](/assets/jake_resume_top.png)


These are some borderline formatting annoyances

- Having more than one page for your resume. You should make your resume just one full page, as recommended by [Y Combinator](https://www.ycombinator.com/library/FB-writing-a-great-resume).
- Make sure every bullet point of yours looks full. Your bullet points should not end with one word on the next line. Aim to have the last line of the bullet point occupy at least 60% of the line. You might need to summarize or elaborate on your bullet points to achieve this.
- Do not hyperlink entire sentences, especially with underline, bold and blue font. You might still want to make the hyperlink known it is a hyperlink. I recommended having [Github \| Demo] or [link] with no emphasis formatting at the end of the line to direct interested readers.
- Inconsistent spaces between words. I understand there is a tradeoff between aligning the end of line by justifying text, and having consistent space between words. I would choose the latter. You will be having many bullet points anyway, I do not think justifying text is going to make the resume neater.
- Use of italics and underlining. (This is my opinion, I understand that Jake's resume uses italics.) Italics and underlining emphasize the words by making them hard to read. I do not like text that is hard to read. I would only use bold for emphasis and allcaps for headers.

You can fix these formatting issues easily.




# Apply the Google XYZ formula

Where are you studying, where did you intern, are facts that cannot be changed. Formatting is just something you should not fault on.

What you can optimize is how you describe your experience and projects with bullet points.
Between candidates of similar backgrounds, the better-written set of bullet points will decide who will get the interview.

You should put in extra effort in the first bullet point in your first entry.
This bullet point is the first thing I would pay conscious attention to.
There is little reason to read further if the bullet point is hard to find, parse and understand.

The best advice on how to write your bullet point is Google's [XYZ formula](https://youtu.be/S_Macvy5CQE?t=83).

> Accomplished X, as measured by Y, by doing Z

This is my analysis on why I think this formula, when applied appropriately, is so powerful

- The bullet point directly answers the question "What did you achieve as a [role] at [place]?"
- The bullet point is unique to you. Not many people in the market can simply copy your accomplishments for their resume.
- The bullet point is self-contained and tells a complete story. The reader is able to understand each bullet point independently.
- The bullet point starts with a power verb, in this case, "accomplished". Bullet points should start with a power verb. Also, avoid having two power verbs that are the same in your resume. You can refer to a list of power verbs [here](https://www.faangtechleads.com/resume/general-guidelines).
- The bullet point is modular. You can just read the first part (i.e. accomplished X) or the first two parts (accomplished X, as measured by Y) and get something out of it. If you reverse the order, you will delay your actual accomplishments to the end, and the reader may not get your point.

The Google XYZ formula is a reference, and you should apply the formula whenever possible.
If you could not force the XYZ formula on your achievements, try to take some learnings from it, and make your bullet points as effective as something written with the formula.

These are comments I have given to some resumes to improve their bullet points with the formula.

> Instead of writing "Used Go (Z) to design and implement a system (X) which improved metrics (Y)", write "Designed and implemented a system (X) which improved metrics (Y) with Go (Z)"
> 
> Instead of writing "Worked with 5 people (Z) to build the app (X) that improved metrics (Y)", write "Built the app (X) that improved metrics (Y) with 5 people (Z)".



# Do not make the reader guess

If you need to be interviewed to get an idea what your work actually is, you are likely not to be interviewed.

The following is a feedback that I have received regarding resume reviews, which I strongly agree with.

> One thing you could consider adding, that's been a pain point for me lately as a resume reader, is making sure the resume conveys what the person's role actually is (and not just the title).
> Especially in the case when they're listing collaborative projects, it can be unclear whether they are (for example) the person building ML models, or building real-time systems, or building offline pipelines, or firefighting/maintaining pieces built by others.
> In the XYZ formula some people put too much into the X and are too vague on the Z.
> They might be vague on the Z because they want to give the impression they worked on more parts of the project or on different parts than they did, and after reading the whole resume I can't always figure out which type of role is the main thing they spend their time on.


These are examples of vague bullet points I read from Discord channels (and these are usually the first bullet of the first experience)

> Developed a novel summarization framework that increased summary production by 20x
> (What is the business use case of your summarization model?, What is meant by increasing summarization production?)
>
> "Essentially it took 1/20th the amount of time the old framework took to generate 100 summaries.
> It was used for Pharma companies to summarize research papers, the company I interned at basically created software for them to improve efficiency"

> Streamlined data collection by 40% by creating an analytics tool using Swift Package Manager for faster load times
> (How is the metric measured? What did you actually do?)
>
> "I measured how many data points were being sent up to the API that the company used for data collection and noticed that a lot of unnecessary calls were being made which slowed down the pipeline"

You can see that if the bullet point had been clearer, it would be been a good reason for the candidate to be interviewed.


Please go through this checklist to ensure that you are not making your reader guess.
In the quotes I have included some comments I gave to other resumes.

What exactly is the feature or system you worked on?
> What is “solve and remediate privacy problems”?
>
> You mentioned that you implemented a chatbot for [company]. What does the chatbot do?
>
> You mentioned that you “created a new web application with React”. Give some details by explaining the features you created, and what the websites were for.

Is the product or system known by a typical software engineer?
> You mentioned you worked on [product name]. It is not clear what [product name] is.

Is the exact contribution clear?
> You mentioned that you worked on the recommendation system for [use case]. Could you specify whether are you the person building ML models, or building real-time systems, or building offline pipelines, or firefighting/maintaining pieces built by others?
>
> You mentioned that you are a teaching assistant for [course]. Could you specify exactly what did you help?
> (e.g. Created the problem set? Consulted for project ideas?)
>
> You mentioned that you are a research assistant for [project]. Could you specify exactly what did you contribute?
> (e.g. Collected dataset? Wrote half the paper?)

Are you claiming to have done something that the company should already have done years ago? How is your work different?
> You mentioned you [created models to detect fraud]. I am sure [company] has such models already. Was yours actually the first, or how it is different from previous methods?




# Frequently asked questions


#### Should I use a one-column or a two-column template?

A popular two-column template is [Deedy's Resume](https://www.overleaf.com/latex/templates/deedy-cv/bjryvfsjdyxz).

I would advise not to use a two-column template for the following reasons
- It is extra work to get familiar with the template.
- Whenever you edit the text of the resume, there are more things to finetune (now you need to finetune vertical delimiters as well).
- The use of the space may not be optimal, it is common to see candidates filling up blank space with low-value content (for example rating their own skills).



#### Which resume template should I use?

As with many others in cscareers.dev Discord, I recommend Jake's Resume Overleaf template.

An alternative I suggest is to use Google docs, so that your friends can easily comment on your resume.
A Y Combinator [blogpost](https://www.ycombinator.com/library/FB-writing-a-great-resume) features such a [Google docs](https://docs.google.com/document/d/1WliF2pvgQBCR3h96L3eExQjrlfX4OkXe01f-2XQ8vEE/edit) resume template.
The issue with Google docs is that it is a WYSIWYG editor, so it may not be easy to keep track of formatting problems. You can see that there is some issue in the template with the last bullet point.



#### Should I use a template even if everyone else is using the same template?

Unless you are a designer, I recommend that you conform and use the standard template.
You can still make your resume stand out with the content.



#### Should I include a summary or an objective?

An organized and well-written resume should already be easily summarizable and should not need a summary.

The Tech Interview Handbook recommends writing [one](https://www.techinterviewhandbook.org/resume/#write-a-headline-for-your-resume-summary).

However, I only recommend writing a summary if you are from a non-traditional background.

Examples of non-traditional background include
- You are changing careers.
- You are applying for the position from a market where the company do not usually hire from.
- The major you are graduating with is not typical of software engineers (e.g. business).
- You had a noticeable disruption in your studies or career (e.g. conscription).

In these cases, a summary will help the reader better context before starting to understand your resume.
Please keep your summary short. Limit your summary to two lines.
Keep your summary factual as well. It is common to see people describe themselves as "motivated", it is better to see how motivated they are from the resume content.

Some resumes uses the "Objective" as the header.
Some resumes also state the things the candidate wants to learn.
My view is that resumes should present your value to the prospective employer, not the other way around.
Therefore, I suggest you keep your resume based on past and current factual accomplishments.



#### Should I include my teaching assistant or research assistant role under experience?

My advice is dependent on whether you already have industrial experience.

If you have already interned at least once, I suggest putting your teaching assistant or research assistant roles under "Teaching and Research".
For example, you had a fruitful internship, but because of the reverse chronological order of entries in the experience section, the reader might miss your internship entry entirely and land your resume in the reject pile.
Generally, I feel that teaching assistant or research assistant roles under experience is confusing, and confusions do not help the reader to understand the merits of your resume.

If you have absolutely zero industrial experience, I can understand the tendency to brand your teaching assistant or research assistant roles as experience.
However, I still prefer honesty.

Regardless of where are you including the role, please be reminded to elaborate on your exact contribution (e.g. created the problem set, wrote half the paper).



#### Are job descriptions good bullet points?

Consider a job description for a Google university graduate role

> - Build our platforms, systems, and networking infrastructure using experience with distributed systems, OS/kernel, network system design, and large-scale storage systems.
> - Build internal systems used by Googlers globally.
> - Mitigate reliability failures in a component or system.
> - Create and support a productive and innovative team, including working with peers, managers, and teams.

The job description lists your responsibilities, not your achievements.
An achievement would be more specific (exactly what internal systems did you build), and would have a measure of success if applicable.



#### Is the STAR format a good alternative to Google XYZ formula?

The STAR format consists for four parts - Situation, Task, Action, Results.
These [two](https://www.indeed.com/career-advice/resumes-cover-letters/star-method-resume) [resources](https://resumegenius.com/blog/resume-help/star-method-resume) describes the STAR format, however not in the tech resume context.

This is how a STAR format bullet point in a tech resume would look like

> Worked with three other engineers in the mobile team (situation) to fix slow loading issues (task). Optimized GraphQL request waterfalls (action) and reduced page loading time by 10% (result).

This could have been summarized in Google XYZ formula as

> Reduced mobile page loading time (X) by 10% (Y) from optimizing GraphQL request waterfalls (Z)

The advantage of Google XYZ formula is that you put your achievement in front, where it is most likely read.
The situation and task is not the most important information in the story (though you might want to postface your bullet point that you worked "with three other engineers").

However, in interviews, STAR format provide a structure for you to build your story.
It is also easier to insert additional detail into the story - for example how did you triage the cause of the slow loading times, the challenges that you have faced.

The recommendations here are different because the setting of the resume screen and the interview session is different.
In the resume screen, time is limited and hiring managers are trying to find a reason to accept or reject your resume, whereas in interviews you should have their full attention.



#### Should I bold text within bullet points, and how should I do it?

I would rather you emphasize your achievements early in the bullet point, which you will be doing in the Google XYZ formula anyway.
If you really want to apply boldface, you might want to use a consistent strategy.

There are a few strategies I suggest (choose only one of them)
- Apply boldface the technologies used.
- Apply boldface on the metrics.
- Apply boldface on the keywords found in the job description.



#### How should I include methodologies (Agile, Scrum) and tools used?

I would like you to consider this [article](https://blog.pragmaticengineer.com/project-management-at-big-tech/) on the absence of named methodologies in Big Tech.
Therefore, I suggest not mentioning these methodologies in the bullet points.

Similarly, documenting the tools you use does not help to show the impact you have made in the company, for example
- Participated in daily standups and iterated on the project with the Agile methodology.
- Used GitLab for version control and JIRA for task tracking.

Moreover, bullet points that focus on the methodologies are usually reusable by any resume, which makes the experience look mediocre.

My guess of the motivation behind these bullet points is to suggest some fit between the candidate and the company.
A good company should look beyond the tools when accessing skills and culture fit.
The company should also have an effective onboarding process to get the new hire familiar with the current tools.



#### How do I cook up some impact if my work has never been deployed to production?

It might be possible that none of your work made it into production and there is no business metric to speak of.
You might want to estimate the number of hours saved with that you "derisked".
You can also describe the features you "experimented" or "prototyped".
Some features can be paraphrased to look like metrics (Prototyped a feature where a user can schedule a meeting within 3 clicks).



#### What tense should I use for the verb for the current work experience?

For past work, you should already be using the simple past tense (e.g. "implemented").
Present continuous tense (e.g. "implementing") for ongoing work is fine.
However, I strongly recommend using simple past tense for ongoing work for consistency.
You should also consider that your resume is being read in the future.



#### How should I include my certifications?

If you are already in a relevant degree program, I suggest you put your certifications in the skills section.
