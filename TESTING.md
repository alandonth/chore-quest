# Validation

Passed:
- JavaScript syntax for client, service worker, and Worker.
- Worker API exercised with real SQLite tables through a D1-compatible adapter: signup, duplicate username, wrong-password login, valid session, user-specific saves, persistence after re-login, revision conflicts, invalid state rejection, origin protection and logout.
- Client state tests with mocked DOM/network: rapid sequential saves, offline pending saves and retry, fierce/friendly dragon faces, attack progression, victory collection, and save-conflict controls.
- Actual Wrangler local D1 migration applied successfully.
- Actual Wrangler deployment dry run compiled the Worker and found the DB and ASSETS bindings and all nine public assets.

Not verified here:
- Full browser visual/device testing. Browser executable was unavailable; Wrangler live preview also stopped on a network-interface environment error.
- Actual Cloudflare account deployment and remote D1 migration. These require your database ID/setup.

After deployment check:
1. Create user A, customize explorer, save a quest, complete a battle, and wait for Saved to your account.
2. Sign out; create user B and confirm A’s data is absent.
3. Sign in as A on another browser and confirm settings, quests and dragons are present.
4. Complete repeated quests: observe varied dragons, fierce battle expressions, distinct attack effects, and friendly collected dragons.
5. Edit on two devices before syncing: confirm conflict choices appear and that neither save is silently overwritten.
6. Install to home screen; reopen online, then test offline after first successful login. Reconnect and verify queued changes save.
7. Enable the phone’s reduced motion setting and confirm attack animations stop.
