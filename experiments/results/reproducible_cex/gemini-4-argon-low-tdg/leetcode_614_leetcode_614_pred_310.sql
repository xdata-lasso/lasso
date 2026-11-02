-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
INSERT INTO follow (followee, follower) VALUES (NULL, 'B');
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
('B', 1)
*/

-- Prediction Query
WITH FOLLOWEE AS (SELECT FOLLOWEE, COUNT(FOLLOWER) AS NUM_FOLLOWEE FROM FOLLOW GROUP BY FOLLOWEE), FOLLOWER AS (SELECT FOLLOWER, COUNT(FOLLOWEE) AS NUM_FOLLOWER FROM FOLLOW GROUP BY FOLLOWER) SELECT FOLLOWEE AS FOLLOWER, NUM_FOLLOWEE AS NUM FROM FOLLOWEE INNER JOIN FOLLOWER ON FOLLOWEE = FOLLOWER WHERE NUM_FOLLOWEE >= 1 AND NUM_FOLLOWER >= 1 ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/