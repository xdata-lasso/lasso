-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO events (event_id, user_id, action_id) VALUES (1, NULL, 100);
INSERT INTO events (event_id, user_id, action_id) VALUES (2, NULL, 100);
INSERT INTO events (event_id, user_id, action_id) VALUES (3, 200, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (4, 200, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (5, NULL, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (6, NULL, NULL);
INSERT INTO events (event_id, user_id, action_id) VALUES (7, NULL, 101);
INSERT INTO events (event_id, user_id, action_id) VALUES (8, 201, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
(None, None)
(None, 100)
(200, None)
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None, 100)
*/