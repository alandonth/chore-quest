# Dragon Radar
A no-build, offline-capable PWA for Riley’s small-step adventures.

## Upload to GitHub and Cloudflare Pages
1. Extract the ZIP. Upload the contents of `dragon-radar` into your repository root (index.html should be at the root).
2. In Cloudflare Pages connect that GitHub repository, select production branch `main`, Framework preset `None`, build command `exit 0`, build output directory `.`.
3. Ensure Cloudflare’s GitHub installation has access to this repository and automatic production deployments are enabled.
4. Deploy. On iPhone open the HTTPS address in Safari → Share → Add to Home Screen. On Android use the browser’s Install app/Add to Home Screen action.

No API keys, npm, database, or account setup is required. To preview locally, run `python3 -m http.server 8080` in this folder, then open http://localhost:8080. PWA installation/offline caching requires HTTPS or localhost, not opening an HTML file directly.

## Features
- Find a Lost Treasure: six flexible memory questions, editable answers, a personalized memory trail, and a found-it celebration. No timer or points.
- Battle a Chore Dragon: saved editable quests, secondary template/custom creation flow, four generic attack animations, adjustable small steps, completion animation, and a collectible Dragon Den.
- Dragon Quest and Princess Quest themes; explorer name, skin, hair, outfit, and crown customization.
- Progress and quests persist in localStorage on the current browser/device; unfinished battles can be resumed. No cross-device sync, multiple profiles, AR camera, or actual room scanning.
- Lucide icons are bundled locally so the UI also works offline.

## Customize
Theme colors are CSS variables at the top of style.css. Templates and dragon colors/names are near the top of app.js. Template steps must be adjusted to suit the child and household; grown-ups should assist with cleaning products.

## Updating
Commit changed files to the connected GitHub production branch. The service worker uses network-first requests to fetch fresh code while online. Increment CACHE in sw.js for each release that changes cached files. Close all app tabs/windows and reopen after deployment if an older service worker is still active. Browser storage is kept unless the user clears site data.

## Data
Everything stays in this browser’s localStorage; clearing site data deletes it. Export/backup and parent authentication are not included. The grown-up workshop is a helpful editing area, not a PIN-protected security boundary.

## Icon license
UI icons: Lucide v0.468.0, https://lucide.dev, ISC license. Original character/dragon illustrations are included as editable SVG markup in app.js. See LUCIDE-LICENSE.txt.

Deployment documentation: https://developers.cloudflare.com/pages/framework-guides/deploy-anything/
