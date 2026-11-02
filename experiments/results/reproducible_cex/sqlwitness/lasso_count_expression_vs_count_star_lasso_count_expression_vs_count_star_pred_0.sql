-- Schema DDL
CREATE TABLE ACTORDIRECTOR (TIMESTAMP INTEGER PRIMARY KEY, ACTOR_ID INTEGER, DIRECTOR_ID INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 0, 2), (2, 2, 2), (3, NULL, NULL), (0, NULL, 2), (1, NULL, NULL), (5, 0, 3), (6, NULL, NULL), (7, 4, 2), (8, 0, NULL), (9, NULL, 4), (10, 0, 4), (11, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID + DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/