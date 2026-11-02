-- Schema DDL
CREATE TABLE events (event_id INTEGER PRIMARY KEY, user_id INTEGER, action_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO events (event_id, user_id, action_id) VALUES (1, 2, 3), (2, 1, NULL), (0, 2, 0), (3, 1, 3), (4, NULL, 1), (5, NULL, 3), (6, NULL, 1), (7, 1, 3), (8, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, action_id FROM events GROUP BY user_id, action_id HAVING COUNT(*) >= 2;

/*
Gold Result:
(None, 1)
(1, 3)
*/

-- Prediction Query
SELECT user_id, action_id FROM events GROUP BY user_id || '-' || action_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1, None)
(1, 3)
*/