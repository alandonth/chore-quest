# Chore Quest — accounts + dragon battles

## Update your existing GitHub / Cloudflare Worker
This is the complete replacement project. It keeps your Worker name `chore-quest` and puts browser files in `public/` so only app assets are publicly served.

1. Extract this ZIP. Upload the CONTENTS of the `chore-quest` folder into your existing GitHub repository root. Keep the included `public` and `migrations` folders intact. Replace the old `wrangler.jsonc` with this one. The old app files at the repository root may be deleted; the new Worker serves only `public/`.
2. In Cloudflare open Storage & databases → D1 → Create database. Name it `chore-quest-db`. Copy its Database ID.
3. Edit `wrangler.jsonc` in GitHub. Replace `REPLACE_WITH_YOUR_D1_DATABASE_ID` with the real Database ID, preserving the quotes. Commit to `main`.
4. Open the D1 database’s Console. Paste the contents of `migrations/0001_accounts.sql` and execute it. All five tables must exist before accounts will work. The script uses IF NOT EXISTS and is safe to rerun.
5. In your EXISTING Worker → Settings → Build settings, keep the GitHub repository and production branch `main`. Use build command `npm run check`, deploy command `npx wrangler deploy`, and root directory blank. Environment variables/secrets: none. Disable preview builds for this first setup so previews cannot modify your production database.
6. Trigger a new build (or commit to main after setting these). The Wrangler config creates the `DB` binding to your D1 database. Check Worker → Bindings: `DB` must point to `chore-quest-db`.
7. Open your existing workers.dev address and refresh. Close/reopen any installed home-screen app. Create an account and wait for “Saved to your account” after changes. On another browser sign in with the same username/password and verify progress.

If deploying by terminal instead, run `npm ci`, then `npx wrangler login`, `npx wrangler d1 migrations apply chore-quest-db --remote`, and `npm run deploy` after entering the real database ID. Local development: `npm ci`, `npx wrangler d1 migrations apply chore-quest-db --local`, `npm run dev`.

## Existing progress
The original version stored progress under `dragon-radar-v1`. On the SAME browser/origin, create an account and choose “Import my previous device progress” in the save bar. This appears only when the account has no cloud save. It copies the original data into that account; it does not delete the original copy. Existing four dragons remain collectible. New battles use randomized dragons.

## Accounts and saving
- Usernames are unique, case-insensitive, 3–24 letters/numbers/underscore/hyphen. Passwords are 8–128 characters, salted and hashed with PBKDF2-SHA256 (100,000 iterations).
- Sessions use Secure, HttpOnly, SameSite cookies and expire after 30 days. API data is never put into the service-worker cache. Origin checks and an IP-based auth attempt limit protect the endpoints.
- Saves are account-specific. Avatar settings, quests, active battle, memories, and Dragon Den sync to D1. Saves queue sequentially, with visible errors and retry. Unsynced device copies survive refresh.
- Previously signed-in users can continue offline on that device; sign-in/signup needs a connection. Wait for “Saved to your account” before switching devices.
- If two devices change progress at once, choose whether to load the cloud save or keep the current device’s changes. Confirm before replacing either.
- This version does not include email recovery, password reset, multiple children under one parent account, or a PIN-protected parent area. Use a nickname and keep credentials with a grown-up.
- Device backups are stored in browser storage; signing out ends the server session, but does not wipe local backups. Clearing site data removes device backups. Cloud saves remain in D1.

## Dragons and attacks
Each quest start generates a new dragon ID and appearance: varied palette, horns, crown, markings and fantasy name. Dragon IDs already collected are avoided. Dragons scowl and show fangs in battle, then smile as companions after victory. All moves deal equal checklist damage; Sword Slash, Lightning Strike, Ice Blast, and Power Punch each use different full-scene effects and particles. Reduced-motion device settings suppress animation.

## PWA / customization
Install the HTTPS site from Safari Share → Add to Home Screen or Android’s Install action. Theme variables are in `public/style.css`. Avatar art, dragon generation, and editable quest templates are in `public/app.js`. Icons use bundled Lucide; see LUCIDE-LICENSE.txt. Increment the service worker cache version when changing cached assets. No AI, AR, real scanning or camera access.

## Verification
JavaScript syntax, account API behavior and save isolation were checked. See TESTING.md for precise validation and remaining device checks.

Cloudflare docs:
https://developers.cloudflare.com/workers/static-assets/
https://developers.cloudflare.com/d1/get-started/
