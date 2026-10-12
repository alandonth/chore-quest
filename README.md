# The Dragon’s Den — competition update

A GitHub / Cloudflare Workers + D1 PWA. Your existing Worker and repository can keep the name `chore-quest`. The app itself is now The Dragon’s Den, in sky blue, orange, and bright green.

## Upgrade your existing app
1. Back up your existing repository or rely on its Git history. Upload the contents of this project's folder to the SAME repository, keeping `public/` and `migrations/` intact. Replace `worker.js`, `package.json`, `package-lock.json`, and matching browser files; add `game-worker.js` and `public/game.js`.
2. KEEP YOUR EXISTING `wrangler.jsonc`, including its real database ID. This ZIP deliberately includes only `wrangler.example.jsonc` so your database configuration is not overwritten. Your existing config from the account update already uses `worker.js`, assets in `public/`, binding `DB`, and `run_worker_first` for `/api/*`. If needed compare it with the example, retaining your actual database ID.
3. In Cloudflare → D1 → your EXISTING `chore-quest-db` → Console, execute the contents of `migrations/0002_dragons_den.sql`. This adds `game_players`, `friend_groups`, and `friend_members`; it does not replace users, sessions, saves, or existing progress. The SQL uses IF NOT EXISTS and may be rerun.
4. In the existing Worker's build settings use `npm run check` as build command and `npx wrangler deploy` as deploy command. Production branch: main. Root directory: blank. Keep preview builds off unless you configure a separate preview D1 database.
5. Commit to main / retry the build. Open your existing app URL, refresh, and close/reopen any installed app to pick up the new service worker. No new database, Worker name, account, secret or deployment provider is required.
6. A grown-up signs in and sets the account’s six-digit approval PIN in Grown-ups. Existing account password verifies first-time setup. Keep the PIN private. Approve each checklist’s size and time allowance before its first scored battle.

For a new installation only, copy `wrangler.example.jsonc` to `wrangler.jsonc`, enter a real D1 database ID, and execute both SQL migrations. Local development: npm ci; npx wrangler d1 migrations apply chore-quest-db --local; npm run dev. Terminal upgrades can use npx wrangler d1 migrations apply chore-quest-db --remote instead of the dashboard console. Applying the earlier IF NOT EXISTS migration to an existing database is safe.

## Battle loop
Choose a saved chore → adult approves its small steps, size, and time allowance → choose your explorer or a collected companion → complete one challenge → choose an attack → enemy counterattacks after the allotted time → finish checklist → show the adult → PIN-approved victory → rewards.

Dirty dragons are fierce in battle and become friendly tidy dragons after approval. Each battle randomizes dragon colors, horns, markings and names. The count includes each collected dragon, rather than distinct species. Collected companions perform a lunge alongside the player's attack; all companions have equal strength in this first version.

A counterattack removes shield health, never completed steps. Armor reduces damage. Pause freezes the current clock. Regroup restores health and reduces the resilience bonus; no chore progress is lost. Counterattacks are calculated from server time even when the browser is backgrounded. A zero shield requires regrouping before the next hit. Step splitting needs the adult PIN.

## Coins, points, armor, and eggs
- Every PIN-approved chore earns 100 / 200 / 300 base leaderboard points for small / medium / epic difficulty, selected by the adult.
- Speed bonus: up to 30 points based on active time versus the planned checklist time. Resilience bonus: up to 20 points based on enemy counterattacks and regrouping. The maximum bonus is 50 points regardless of step count.
- Coins: one quarter of base points plus speed bonus. Coins are spendable; lifetime leaderboard points never decrease when shopping.
- Leaf / Ember / Sky armor reduces counterattacks by 2 / 4 / 6 shield points. A crown and cape are cosmetic accessories. Armor appears on the avatar.
- Every three approved chores awards an egg. Extra eggs cost 100 coins. An egg hatches after three subsequent approved chores. Each hatched dragon joins the collection and can become a companion.
- Parent approval is the completion check: instant checklist tapping cannot award points, coins, or dragons without the PIN. Time bonuses remain intentionally small because real-world tasks vary and an app cannot independently prove how much work occurred. Pause time is excluded; adults should set realistic plans and assess completion.

## Private friends leaderboard
Grown-ups create or join a group using a 12-character invitation code and PIN. Only members see usernames, lifetime points, approved chore counts and collection counts. This version has no public global leaderboard. Sharing an invitation code lets another PIN-approved account join. Group limit: 100 members. Rankings use server-maintained rewards; altering local storage or ordinary account saves cannot change leaderboard points or balances.

## Photo proof
Optional camera/file input previews an image using a temporary browser object URL. The image is never included in API requests, account saves, browser storage, or service-worker caches. It is removed on approval, navigation away, explicit removal, logout or refresh. The adult can approve without a photo. A device's own camera app may separately save a picture to the photo library; the PWA cannot control that OS behavior.

## Accounts and existing progress
Existing usernames/passwords, explorer customization, saved chore templates, and lost-treasure memories continue to work. Earlier dragons are shown in the collection; a grown-up can approve importing them as companions / collection counts without awarding coins or chore points. Existing unfinished battles from the earlier app are not counted as scored victories; begin a new approved plan for competition.

Each account has its own PIN, not a separate linked parent account. First-time PIN setup uses the account password, so a grown-up should complete setup before handing over the app. Changing it requires the current PIN. This version has no password/PIN recovery or parent administrator panel.

Lost-treasure memories retain device/offline saves from the previous version. Scored battles, purchases, PIN checks and leaderboard updates require an internet connection so rewards remain server-controlled. Previously cached account data is not shared through a global offline cache. Sign out before changing users.

## Validation and source
See TESTING.md. Core account data remains in saves; the competition state is in game_players. Fresh leaderboard scores begin at zero because previous unverified chore completions cannot be treated as parent-approved rewards.

UI icons: bundled Lucide v0.468.0, ISC license; the app icon uses Lucide Castle. Character/dragon art is editable SVG in the client source. Theme colors and motion are in public/style.css. Reduced-motion settings suppress animations. No AI, actual room scanning, AR, analytics or photo uploads.
