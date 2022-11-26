---
layout: post
title: "Tech Resume Advice"
categories: career
---

I have been giving comments on technical resumes in Discord channels by the Tech Interview Handbook and cscareers.dev.

This is my general resume advice for anyone who asks for it.


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

- Having more than one page for your resume. You should make your resume just one full page, as recommended by [Y Combinator](https://www.ycombinator.com/library/FB-writing-a-great-resume). I suggest that you conform to the current standards so that it is easier for the reader to process your resume cognitively.
- Make sure every bullet point of yours looks full. Your bullet points should not end with one word on the next line. Aim to have the last line of the bullet point occupy at least 60% of the line. You might need to summarize or elaborate on your bullet points to achieve this.
- Do not hyperlink entire sentences, especially with underline, bold and blue font. You might still want to make the hyperlink known it is a hyperlink. I recommended having [Github \| Demo] or [link] at the end of the line to direct interested readers.
- Inconsistent spaces between words. I understand there is a tradeoff between aligning the end of line by justifying text, and having consistent space between words. I would choose the latter. The latter is also not that visible if you are using a one-column resume template.
- Use of italics and underlining. (This is my opinion, I understand that Jake's resume uses italics.) Italics and underlining emphasize the words by making them hard to read. I do not like text that is hard to read. I would only use bold for emphasis and allcaps for headers.

You can fix these formatting issues easily.


# Use Google XYZ formula

Where are you studying, where did you intern, are facts that cannot be changed. Formatting is just something you should not fault on.

What you can optimize is how you describe your projects and experience with bullet points.
Between candidates of similar backgrounds, a better-written set of bullet points will decide who will get the interview.

The best advice on how to write your bullet point is Google's [XYZ formula](https://youtu.be/S_Macvy5CQE?t=83).

> Accomplished X, as measured by Y, by doing Z

I would like to elaborate on this advice further

- The statement directly answers the question "What did you achieve as a <role> at <place>?"
- The statement is self-contained and tells a complete story. The reader is able to understand each bullet point independently.
- The statement starts with a power verb, in this case, "accomplished". Bullet points should start with a power verb. Also, avoid having two power verbs that are the same in your resume. You can refer to a list of power verbs [here](https://www.faangtechleads.com/resume/general-guidelines).
- The statement is modular. You can just read the first part (i.e. accomplished X) or the first two parts (accomplished X, as measured by Y) and get something out of it. If you reverse the order, you will delay your actual accomplishments to the end, and the reader may not get your point.
- I notice that "measured by Y" is placed before "by doing Z". It reflects that the results and their measurements are more important than whatever fancy methods you used to achieve your accomplishments.
- Metrics are important in tech companies. Startups secure funding with their metrics. Established tech companies make decisions on products and promotions with their metrics. You should try to shape your work so that it has an impact and it is measurable.



# Frequently asked questions


#### Should I use a one-column or a two-column template?

A popular two-column template is [Deedy's Resume](https://www.overleaf.com/latex/templates/deedy-cv/bjryvfsjdyxz).

I would advice not to use a two-column template for the following reasons
- It is extra work to get familiar with the template.
- Whenever after you edit the text of the resume, there are more things to finetune (now you need to finetune vertical delimiters as well).
- The use of the space may not be optimal, it is common to see candidates filling up blank space with low value content (for example rating their own skills).



#### Which resume template should I use?

As with many others in cscareers.dev Discord, I recommend Jake's Resume Overleaf template.

An alternative I suggest is to use Google docs, so that your friends can easily comment on your resume.
A Y Combinator [blogpost](https://www.ycombinator.com/library/FB-writing-a-great-resume) feature such a [Google docs](https://docs.google.com/document/d/1WliF2pvgQBCR3h96L3eExQjrlfX4OkXe01f-2XQ8vEE/edit) resume template.
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
That said, your resume should still be well-organized regardless.



### Is the STAR format a good alternative to Google XYZ formula?

The STAR format consists for four parts - Situation, Task, Action, Results.
These [two](https://www.indeed.com/career-advice/resumes-cover-letters/star-method-resume) [resources](https://resumegenius.com/blog/resume-help/star-method-resume) describes the STAR format, however not in the tech resume context.

This is how a STAR format bullet point in a tech resume would look like

- "Worked with three other engineers in the mobile team (situation) to fix slow loading issues (task). Optimized GraphQL request waterfalls (action) and reduced page loading time by 10% (result)."

This could have been summarized in Google XYZ formula as

- "Reduced mobile page loading time (X) by 10% (Y) from optimizing GraphQL request waterfalls (Z)"

The advantage of Google XYZ formula is that you put your achievement in front, where it is most likely read.
The situation and task is not the most important information in the story (though you might want to postface your bullet point that you worked "with three other engineers").

However, in interviews, STAR format provide a structure for you to build your story.
It is also easier to insert additional detail into the story - for example how did you triage the cause of the slow loading times.

The setting of the resume screen and the interview session is different.
In resume screen time is limited and hiring managers are trying to find a reason to accept or reject your resume, whereas in interviews you should have their full attention.



#### Should I bold text within bullet points, and how should I do it?

I would rather you emphasize your achievements early in the bullet point, which you will be doing in the Google XYZ formula anyway.
If you really want to apply boldface, you might want to use a consistent strategy.

There are a few stragies I suggest (choose only one of them)
- Apply boldface the technologies used.
- Apply boldface on the metrics.
- Apply boldface on the keywords to found in the job description.



#### How should I include Agile or Scrum methodologies used?

I would like you to consider this [article](https://blog.pragmaticengineer.com/project-management-at-big-tech/) on the absence of named methodologies in Big Tech.
Therefore, I suggest not mentioning these methodologies in the bullet points.



#### How do I cook up some metrics if my work has never been deployed to production?

It might be possible that none of your work made it into production and there is no business metric to speak of.
You might want to estimate the number of hours saved with that you "derisked".
You can also describe the features you "experimented" or "prototyped".
Some features can be paraphrased to look like metrics (Prototyped a feature where a user can schedule a meeting within 3 clicks).



#### What tense should I use for the verb for the current work experience?

For past work, you should be using the simple past tense (e.g. "implemented").
Present continuous tense (e.g. "implementing") is fine for ongoing work.
However, I suggest using simple past tense for ongoing work for consistency. You should also consider your resume will be read in the future.



#### How should I include my certifications?

If you are already in a relevant degree program, I suggest you put your certifications in the skills section.
