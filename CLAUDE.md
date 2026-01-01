# Blog instructions

## Polishing posts

When polishing a blog post:
1. Read other blog posts first to understand the writing style
2. Each sentence should be on its own line (markdown renders consecutive lines as a single paragraph). Multi-line footnotes should have subsequent lines indented with 4 spaces.
3. Verify content renders correctly:
   - Run `bundle exec jekyll build` to rebuild the site
   - Use Puppeteer to navigate to localhost:4000 and take screenshots
4. Display the localhost URL to the user so they can view the rendered post (e.g., http://localhost:4000/2026/01/01/predictions-for-2026.html)

## Citations

When adding citations or hyperlinks, strongly prefer official sources:
- Official documentation and blog posts (e.g., openai.com, github.com official repos)
- Primary sources over secondary reporting
- Avoid linking to aggregator sites when the original source is available

