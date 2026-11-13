# Screen: FAQ

`_layouts/faq.html`, pages `pages/faq.md` (FR, `/faq/`) / `-en.md` (EN, `/en/faq/`), `ref: faq`.

## Goal

Answer the most frequent practical questions about preparing a diving trip (choosing a dive shop, certifications, gear, budget...), independently of any specific destination.

## Content and structure

- Page banner (`sea: faq`, see `style-guide.md`).
- Single Bootstrap accordion (`#faqAccordion`), one entry per item of `page.qa` (front matter, see `data-model.md`): icon, question, Markdown answer.

## Interactions

- **Click on a question**: opens/closes the associated answer (standard Bootstrap accordion, see `style-guide.md`). Unlike the "Practical information" accordion of the destination pages, **all questions are closed by default**, none is open when the page loads.
- No direct link (anchor) to a specific question: the accordion does not change the URL.

## States (loading, error, empty)

No particular state: the 8 questions are fixed in the front matter (see `data-model.md`).

## Responsive

No custom media query: standard Bootstrap accordion, full width regardless of screen size.
