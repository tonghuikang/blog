---
name: align-style
description: Align a markdown blog post in `_posts/` with the blog's writing style and formatting conventions. Use when writing a new post, editing a draft, or fixing an existing post.
---

# What this skill does

Align a blog post in `/Users/htong/Desktop/blog/_posts/` with the blog's writing style and formatting conventions.

By default, this skill runs on the whole post currently being worked on, not only the lines that were just edited.
If multiple posts are in flight, ask the user which post to align - do not guess.

# Example queries

- "Polish this post"
- "Write a blog post on X"
- "Make this post match the style of the other ones"
- "Edit this draft to match my voice"
- "Format this post so each sentence is on its own line"

# Workflow

1. Read 2-3 existing posts in `_posts/` first to understand the style by example before editing.
2. Apply the formatting conventions below.
3. Run the sentence-per-line script (see "Sentences and paragraphs") to enforce one sentence per line.
4. Build and verify:
   - `bundle exec jekyll build`
   - Use Puppeteer to screenshot the rendered page
   - Print the localhost URL (e.g., `http://localhost:4000/2026/05/15/coding-interaction.html`) so the user can open it

# Frontmatter

```markdown
---
layout: post
title: All coding models will be interaction models
---
```

- `layout: post`
- `title` is sentence-case. First word capitalized, proper nouns capitalized, rest lowercase. No period.
- Filename pattern: `YYYY-MM-DD-short-slug.md`

# Headings

- No H1 in the body. The title comes from frontmatter.
- `## Section` for major sections.
- `### Subsection` for subsections within Implications and similar.
- `#### **Inline phase**` for tight in-list-style headers (used sparingly).
- No period at the end of a heading.
- Sentence-case, not title-case. "Think of how you interact", not "Think Of How You Interact".

# Sentences and paragraphs

- One sentence per line.
- Multiple consecutive lines (no blank line between them) render as one paragraph.
- Use a blank line to separate paragraphs.
- Sentences are short, declarative, plain.

## Sentence-splitting script

The script below splits multi-sentence lines while preserving footnotes, bullets, code blocks, headings, and frontmatter.
Save it as `/tmp/split_sentences.py` and run with `python3 /tmp/split_sentences.py _posts/<file>.md`.
Afterward, verify with `grep -nE "\. [A-Z]" <file>` that the only remaining matches are inside code blocks or frontmatter.

```python
import re
import sys

PATH = sys.argv[1]

with open(PATH, 'r') as f:
    lines = f.readlines()

def split_sentences(text):
    return re.split(r'(?<=[.!?]) (?=[A-Z])', text)

output = []
in_code_block = False
in_frontmatter = False
for line in lines:
    raw = line.rstrip('\n')

    if raw == '---':
        in_frontmatter = not in_frontmatter
        output.append(line); continue
    if in_frontmatter:
        output.append(line); continue

    if raw.startswith('```'):
        in_code_block = not in_code_block
        output.append(line); continue
    if in_code_block:
        output.append(line); continue

    if not raw.strip():
        output.append(line); continue
    if raw.startswith('#'):
        output.append(line); continue
    if re.match(r'^\*[^*]+\*$', raw):
        output.append(line); continue

    fn_match = re.match(r'^(\[\^[^\]]+\]:\s+)(.+)$', raw)
    if fn_match:
        prefix, content = fn_match.groups()
        sentences = split_sentences(content)
        output.append(f"{prefix}{sentences[0]}\n")
        for s in sentences[1:]:
            output.append(f"    {s}\n")
        continue

    bullet_match = re.match(r'^(\s*-\s+)(.+)$', raw)
    if bullet_match:
        prefix, content = bullet_match.groups()
        cont_indent = ' ' * len(prefix)
        sentences = split_sentences(content)
        output.append(f"{prefix}{sentences[0]}\n")
        for s in sentences[1:]:
            output.append(f"{cont_indent}{s}\n")
        continue

    indent_match = re.match(r'^(\s+)(.+)$', raw)
    if indent_match:
        leading, content = indent_match.groups()
        sentences = split_sentences(content)
        for s in sentences:
            output.append(f"{leading}{s}\n")
        continue

    sentences = split_sentences(raw)
    for s in sentences:
        output.append(f"{s}\n")

with open(PATH, 'w') as f:
    f.writelines(output)
```

# Emphasis

- Use `*single-asterisks*` for inline italic emphasis, especially for markers like `*What it is.*`.
- Use `**double-asterisks**` sparingly, usually as a lede for a bulleted point.
- Avoid bold/italic in headings - they already have weight.

# Hyphens, not em-dashes

- Use ` - ` (hyphen with spaces) inside sentences for parenthetical breaks.
- Do not use em-dashes (`—`).
- Example: "plan mode - and the agent does nothing else until the plan is done."

# Footnotes

- Reference inline as `text.[^name]`.
- Definition format: `[^name]: First sentence.`.
- Multi-sentence definitions: subsequent sentences indented with 4 spaces.
- Place footnote definitions OUTSIDE the two paragraphs of a section. Put them after both paragraphs, not between them.

```markdown
text with reference.[^foo]

[^foo]: First sentence.
    Second sentence (indented 4 spaces).
    Third sentence.
```

# Bullets

- `- item` for bullet items.
- Continuation sentences indented with 2 spaces (matching the bullet prefix width).
- Each sentence on its own line.

```markdown
- First sentence of bullet.
  Second sentence of the same bullet (indented 2 spaces).
```

# Links

- Prefer official sources: openai.com, anthropic.com, thinkingmachines.ai, github.com official repos, primary docs.
- Avoid aggregator sites and secondary reporting when the original is available.
- Internal links to other posts use Jekyll permalink form: `/YYYY/MM/DD/slug.html`.
- External links use full URLs.
- Verify a URL exists (curl it) before linking to it.

# Code

- Backticks for inline code: file paths, commands, identifiers (e.g., `_posts/`, `bundle exec`, `[^foo]`).
- Fenced code blocks for longer snippets.

# Voice

- First person ("I", "my") is fine, especially for predictions, observations, and frustrations.
- Use concrete examples drawn from real experience over abstract claims.
- Frame predictions explicitly as predictions, not facts.
- No marketing fluff, no hyperbole, no superlatives unless warranted.
- No emojis.
- No filler phrases like "It's worth noting that...", "Importantly,...", "In conclusion,...".
- No multi-paragraph summaries at the end - keep the closing tight (1-3 sentences).

# Section patterns

- Posts usually open with 1-3 sentences before the first `##` heading - just enough to state the argument or the task.
- Predictions or arguments are often grouped under an `## Implications` section, with each implication as a `###` subsection.
- "What it is" / "What it should be" phase walkthroughs use `#### **Phase**` headers with two italic markers (`*What it is.*` and `*What it should be.*`) and two paragraphs per phase.

# Closing the post

- End with `## Footnotes` as the anchor for footnote rendering.
- Blank trailing line.

# Checklist

- [ ] `grep -nE "\. [A-Z]" <file>` returns no matches outside code blocks or frontmatter
- [ ] Footnote definitions have continuation lines indented with 4 spaces, and they sit outside the two paragraphs of a "What it is / What it should be" section
- [ ] Bullet items have continuation lines indented to match the bullet prefix
- [ ] No em-dashes (`—`) anywhere in the post
- [ ] Title is sentence-case, no period
- [ ] Closing is 1-3 sentences, no summary recap
- [ ] `bundle exec jekyll build` succeeds and the rendered HTML matches expectations

# Pitfalls to avoid

- Do not write multi-paragraph closings or summaries. Keep the closing tight.
- Do not use em-dashes. Use hyphen with spaces instead.
- Do not put footnote definitions between the two paragraphs of a section in the "What it is" / "What it should be" format. They go after both paragraphs.
- Do not link to AI-summarized aggregators - find the primary source.
- Do not add an H1 inside the body - the title comes from frontmatter.
- Do not start writing without re-reading the existing post styles. Style drifts quickly without that calibration step.
- Do not introduce blank lines between sentences within a paragraph - that splits them into separate paragraphs in the rendered HTML.
- Do not run the sentence-splitting script on a file with unsaved editor changes - it overwrites in place.
