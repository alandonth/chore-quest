CREATE TABLE IF NOT EXISTS device_profiles (
 device_hash TEXT NOT NULL,
 user_id TEXT NOT NULL REFERENCES users(id),
 session_hash TEXT NOT NULL REFERENCES sessions(token_hash),
 expires_at INTEGER NOT NULL,
 PRIMARY KEY(device_hash,user_id)
);
