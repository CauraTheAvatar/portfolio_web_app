# C'aura Technology — Website Guides

Two things you asked me to leave you with:

1. **How to link your UI design work to the "UI Design" card**
2. **How to link your graphic design portfolio to the "Graphic Design" card**
3. **Three free ways to showcase your designs online** (choose whichever fits)

---

## How card links work (read this first — it's the same for every card)

Every project card on the website is a link. The whole card is clickable. The link
lives in ONE place: the `cards` list at the top of `src/components/Projects.astro`.

Right now it looks like this (lines 5–42):

```astro
const cards = [
  { icon: "code",      title: "Software Development", subtitle: "Web · Mobile · GitHub",
    href: "https://github.com/CauraTheAvatar" },
  { icon: "globe",     title: "WordPress",           subtitle: "Websites & CMS builds",
    href: "https://conceicaolaurauuyuni.wordpress.com/" },
  { icon: "database",  title: "Data Engineering",    subtitle: "Pipelines & infrastructure",
    href: "https://github.com/CauraTheAvatar/Scalable-Data-Pipeline-..." },
  { icon: "analytics", title: "Data Analytics",      subtitle: "Analysis · Visualizations · Code",
    href: "https://github.com/CauraTheAvatar/data-analytics" },
  { icon: "pen-tool",  title: "UI Design",           subtitle: "Figma · Canva interfaces",
    href: "https://figma.com/@cauratech" },        // ← REPLACE THIS (tutorial 1)
  { icon: "brush",     title: "Graphic Design",     subtitle: "Posters · branding · print",
    href: "https://www.notion.so/DECOR-CONTENT-..." }, // ← REPLACE THIS (tutorial 2)
];
```

**The only thing you ever change is the `href: "..."` value.** Save the file and the
dev server refreshes instantly. No other code needs touching.

---

## Tutorial 1 — Link your UI design to the "UI Design" card

**What to do first: get a shareable link for your design.**

- **Figma:** open your design file → click **Share** (top-right) → make sure
  *"Anyone with the link can view"* → click **Copy link**. The link looks like:
  `https://www.figma.com/design/XXXXX/your-file-name`
- **Behance / Dribbble:** open your published project → copy the URL from the
  browser address bar.

**Then paste it into the card:**

1. Open `src/components/Projects.astro` with any text editor.
2. Find the `UI Design` line (line 34–35 above).
3. Replace the `href` value with your copied link:

```astro
  { icon: "pen-tool", title: "UI Design", subtitle: "Figma · Canva interfaces",
    href: "https://www.figma.com/design/XXXXX/your-file-name" },
```

4. Save. Done — the card now opens your design in a new tab.

> **Tip — multiple designs:** want the card to lead to a page that shows ALL your
> UI work instead of one file? Create a **Behance project** (or a Figma Community
> profile) and link to that one URL. Tutorial 3 explains the free options.

---

## Tutorial 2 — Link your graphic design portfolio to the "Graphic Design" card

Same mechanism, different target. "Portfolio" = one page that shows all your
posters, branding and print work (not just a single image).

1. Open `src/components/Projects.astro`.
2. Find the `Graphic Design` line (lines 39–40 above).
3. Replace the `href` with your portfolio URL:

```astro
  { icon: "brush", title: "Graphic Design", subtitle: "Posters · branding · print",
    href: "https://www.behance.net/yourusername" },
```

4. Save. Done.

---

## Tutorial 3 — Three cost-free ways to showcase your work

You said you're not tied to a specific way — here are three options that cost
**nothing**, ranked by how professional they look.

### Option A — Behance (best overall, free Adobe account) ⭐ recommended
Adobe's portfolio platform. Made exactly for UI/UX and graphic design. You can
post posters, brand identities, app screens, even process shots.
- **For UI work:** each project can hold multiple screenshots + a link to the live
  Figma file, so clients see the real interactive design.
- **For graphic work:** upload your posters/branding in a project grid.
- **Cost:** free (free Adobe account; no subscription needed for Behance).
- **Setup:** behance.net → sign up → *Create a Project* → upload → *Publish* →
  copy the project URL → paste into the card (Tutorials 1 & 2).
- One profile URL (`behance.net/yourname`) covers **both** cards if you want.

### Option B — GitHub Pages design gallery (best if you like keeping everything in GitHub)
A free static website hosted at `yourusername.github.io`. You already use GitHub,
so this fits your workflow, and the repo can hold the images + a simple gallery
page. Hosting is free forever.
- **For UI work:** embed Figma links per project card.
- **For graphic work:** an image grid page (no design skills needed — a simple
  HTML page with `<img>` tags).
- **Cost:** free (GitHub free plan).
- **Setup:** new repo → upload images → enable *Settings → Pages → Deploy from
  branch* → done. Ask me and I'll build the gallery page for you.

### Option C — Public Notion page / Google Drive folder (zero design work, fastest)
If you just want links TODAY with no setup: make one public page and drop
everything in it.
- **Notion:** create a page → add image blocks or embedded Figma embeds →
  *Share → Anyone with the link can view* → copy the URL. You already use Notion
  (your DECOR planner is linked to the Graphic Design card right now).
- **Google Drive:** upload images/PDFs to a folder → *Share → Anyone with the
  link can view* → copy the link.
- **Cost:** free.
- Downside: less "portfolio-like" — fine for a first version, upgrade to
  Option A or B later.

### Bonus for UI specifically — Figma Community
Publish a design file to the Figma Community (`Share → Publish to Community`).
Anyone can open and play with it in the browser — the closest thing to showing
a "living" UI. Free with your Figma account. Great to link from either a Behance
project or the card itself.

---

## How to edit a card's subtitle (optional)

Want to change what the card says? Just edit the `subtitle` value:

```astro
  { icon: "pen-tool", title: "UI Design", subtitle: "Figma · Canva · App screens" },
```

---

## Where everything lives

| What | File |
|------|------|
| Card links + titles + subtitles | `src/components/Projects.astro` |
| Footer scriptures (the 5 rotating verses) | `src/components/Footer.astro` |
| Site colours (pastel earthy + gold) | `src/styles/global.css` |
| Logo image | `public/images/caura-logo-gold.png` |

**After any edit:** if you're viewing the live preview, it updates on its own.
When you're happy, tell me and I'll build + push the site.
