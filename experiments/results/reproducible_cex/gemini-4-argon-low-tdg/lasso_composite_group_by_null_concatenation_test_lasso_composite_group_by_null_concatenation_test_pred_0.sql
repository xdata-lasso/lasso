-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in GROUP BY and HAVING COUNT(*) vs COUNT(column) mutations.
INSERT INTO events (event_id, user_id, action_id) VALUES (1, 20, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (2, 20, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (3, NULL, 200);
INSERT INTO events (event_id, user_id, action_id) VALUES (4, NULL, 200);
INSERT INTO events (event_id, user_id, action_id) VALUES (5, NULL, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (6, NULL, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (7, 21, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (8, NULL, 201);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
(None, None)
(None, 200)
(20, None)
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(20, None)
*/