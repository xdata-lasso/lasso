-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (1046, NULL, 1049);
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (1047, NULL, 1049);
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (1050, NULL, 1053);
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (1051, NULL, 1053);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
(None, 1049)
(None, 1053)
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None, 1049)
*/