# Validation for competition update

Passed:
- JavaScript syntax checks for Worker, game-worker, client and service worker.
- Backend integration tests with real SQLite and a D1-compatible adapter: signup, incorrect PIN rejection, plan approval, parent-only rewards, duplicate approval prevention, per-account data isolation, armor ownership/equipping, companion selection, pause gating, counterattack timing/idempotence, private group membership, egg award thresholds and incubation.
- Headless Chromium at 390px phone viewport against the actual Worker API module with a SQLite-backed HTTP adapter: signup, PIN setup, custom checklist save, adult plan approval, two animated attacks, temporary image preview, final PIN approval, reward screen, armor purchase/equip, group creation and rankings. No client JavaScript errors or horizontal overflow.
- Visual inspection of mobile home and battle screenshots.
- Cloudflare Wrangler applied both migrations to its real local D1 emulator and completed a deployment dry run with DB and ASSETS bindings.

Limits:
- Wrangler live preview hit an environment network-interface error; the browser test therefore used the Node Web Crypto / SQLite HTTP adapter, not the Workers live runtime.
- No remote deployment, production D1 changes, or signed-in account changes were made.
- Physical iOS/Android home-screen installation, camera capture, browser backgrounding and offline-to-online recovery require device checks after deployment.

Post-deployment checks:
1. Sign in to an existing account; verify saved checklists and memories.
2. Set the grown-up PIN privately; approve a small checklist and a realistic interval.
3. Wait beyond one interval: dragon strikes and shield drops. Pause and verify no further damage, resume, then finish.
4. Confirm an incorrect PIN gives no rewards; approve with the correct PIN. Refresh: the reward is present exactly once.
5. Collect a dragon, choose it on the next battle, and observe the companion lunge.
6. Buy/equip armor; verify the avatar changes and counterattacks weaken.
7. Complete three approved chores to earn an egg, then three more to hatch. Buying an egg should remove coins but not leaderboard points.
8. Create/join a private friend group on two accounts. Verify points, chores and dragons; an unrelated account sees no group.
9. Use optional photo proof and leave the approval screen. Confirm the photo disappears. Network requests should contain only JSON gameplay/PIN data, never image bytes.
