# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal Danish-language blog built with Jekyll and hosted on GitHub Pages. The blog covers software development, mathematics, and data science topics.

## Development Commands

### Local Development

**Recommended: Docker-based development**
```bash
./jekyll.sh
```
This script runs Jekyll in Docker, automatically installs dependencies, serves the site on http://localhost:4000, and includes drafts.

**Alternative: Local Ruby/Bundler**
```bash
bundle install                    # First time only
bundle exec jekyll serve --drafts # Serve with live reload
```

### Refactoring and larger changes to web site

Always create a Git branch for larger changes. Ask if you are in doubt.

### Deployment

Changes pushed to the `master` branch automatically deploy via GitHub Actions. Monitor deployment in the repository's Actions tab.

## Blog Post Workflow

### Creating Standard Posts

1. Create file in `_posts/` with format: `YYYY-MM-DD-title.markdown`
2. Use this frontmatter:
   ```yaml
   ---
   layout: post
   title: "Post Title"
   date: YYYY-MM-DD HH:MM:SS
   ---
   ```

### Creating R Markdown Posts

For posts with R code and plots:

1. Create `.Rmd` file in `_knitr/` directory
2. Render to Markdown:
   ```bash
   cd _knitr
   Rscript render_post.R your-file.Rmd
   ```
3. This generates the post in `_posts/` and saves figures to `images/[post-name]/`

### Mathematical Notation

Posts automatically include MathJax 3. Use:
- Inline math: `$equation$`
- Display math: `$$equation$$`

### Drafts

Store draft posts in `_drafts/` directory. They are visible locally when using `--drafts` flag (included in jekyll.sh) but not in production.

## Architecture

### Template Hierarchy

- `_layouts/default.html`: Base template with site header, navigation, and main content wrapper
- `_layouts/post.html`: Extends default, adds MathJax script and discussions footer
- `_layouts/page.html`: Extends default for static pages

### Important Includes

- `_includes/discussions.html`: Post footer with GitHub edit link and Creative Commons license

### Configuration

- Site uses `github-pages` gem to ensure local environment matches GitHub Pages production
- Timezone: `Europe/Copenhagen`
- Permalinks: `/:year/:month/:day/:title.html`
- Markdown: Kramdown with Rouge syntax highlighting

### Content Language

All blog posts are written in Danish. Maintain Danish language for post content, titles, and navigation elements.
