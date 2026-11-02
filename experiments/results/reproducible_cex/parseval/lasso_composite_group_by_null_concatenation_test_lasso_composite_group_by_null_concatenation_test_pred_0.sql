-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: events --
INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483648, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483647, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483646, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (2, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (3, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483645, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483642, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483641, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483640, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483639, 1, NULL);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483638, 1, NULL);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483637, 1, NULL);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483636, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483635, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483634, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483633, NULL, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483632, NULL, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483631, NULL, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483630, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483629, 1, 1);

INSERT INTO "events" ("event_id", "user_id", "action_id") VALUES (-2147483628, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
(None, 1)
(1, None)
(1, 1)
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1, None)
(1, 1)
*/