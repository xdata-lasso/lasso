-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (5, 6, 8);
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (4, 6, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/