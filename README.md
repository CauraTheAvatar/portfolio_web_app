# C'AURA TECHNOLOGY — Portfolio

Rebuilt with **Astro 5** + **Decap CMS**, deployed on **Netlify**.

## Stack
- Astro 5 (static output, zero client JS by default)
- Decap CMS (git-based editing → commits straight to the repo)
- Content collections for projects (typed frontmatter)

## Dev
```bash
npm install
npm run dev        # http://localhost:4321
npm run build      # static site → dist/
npm run preview    # serve the build locally
```

## CMS
Visit `/admin` on the deployed site. With `local_backend: true` you can run the
Decap local backend for offline editing:
```bash
npx decap-server
```
On Netlify, `git-gateway` is enabled automatically when Netlify Identity is
activated for the site (no client/secret needed).

## Content
- Projects: `src/content/projects/*.md` (typed via `src/content.config.ts`)
- About/Skills/Collaborations: editable in `src/pages/index.astro`
- Scriptures: `src/components/ScriptureRotator.astro` (5 verses, 6s rotation)

## Deploy
Netlify build settings: build command `npm run build`, publish dir `dist`.
