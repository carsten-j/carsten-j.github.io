# carsten-j.github.io

Personal blog built with Jekyll and hosted on GitHub Pages.

Visit: [carsten-j.github.io](https://carsten-j.github.io/)

## Local Development

### Prerequisites

- Docker installed on your system
- Git

### Running Locally with Docker

1. Clone the repository:
   ```bash
   git clone https://github.com/carsten-j/carsten-j.github.io.git
   cd carsten-j.github.io
   ```

2. Make the Jekyll script executable (first time only):
   ```bash
   chmod +x jekyll.sh
   ```

3. Run the development server:
   ```bash
   ./jekyll.sh
   ```

4. Open your browser and navigate to `http://localhost:4000`

The site will automatically rebuild when you make changes to files. The script includes `--drafts` flag so draft posts in `_drafts/` will be visible locally.

### Alternative: Local Ruby/Bundler Setup

If you prefer not to use Docker:

1. Install Ruby 3.1 or higher and Bundler:
   ```bash
   gem install bundler
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Serve the site:
   ```bash
   bundle exec jekyll serve --drafts
   ```

## Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `master` branch.

### Deployment Process

1. Make your changes locally and test them
2. Commit and push to the `master` branch:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin master
   ```

3. GitHub Actions will automatically:
   - Build the site using the `github-pages` gem
   - Deploy to GitHub Pages
   - Your changes will be live at https://carsten-j.github.io/

### Monitoring Deployment

- Check the Actions tab in the GitHub repository to see the deployment status
- Build logs are available if there are any errors

## Project Structure

- `_posts/` - Blog posts in Markdown format
- `_drafts/` - Draft posts (not published)
- `_layouts/` - HTML templates for pages and posts
- `_includes/` - Reusable HTML components
- `_sass/` - SASS stylesheets
- `css/` - Compiled CSS
- `images/` - Static images

## Writing Posts

Create a new file in `_posts/` with the format: `YYYY-MM-DD-title.markdown`

Example frontmatter:
```yaml
---
layout: post
title: "Your Post Title"
date: 2026-01-17 10:00:00 +0100
categories: [category1, category2]
---
```

Posts support:
- Markdown formatting
- Code syntax highlighting
- MathJax for mathematical equations (use `$...$` for inline, `$$...$$` for blocks)

## Technologies

- **Jekyll 3.9.x** - Static site generator (via github-pages gem)
- **Kramdown** - Markdown processor
- **Rouge** - Syntax highlighting
- **MathJax 3** - Mathematical notation
- **Font Awesome 6** - Icons
- **GitHub Actions** - CI/CD pipeline
