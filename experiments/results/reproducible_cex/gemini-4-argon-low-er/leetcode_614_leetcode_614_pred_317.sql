-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('A', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('B', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT FOLLOWEE, COUNT(FOLLOWER) AS FOLLOWER_COUNTS FROM FOLLOW GROUP BY 1), CTE2 AS (SELECT FOLLOWER, COUNT(FOLLOWEE) AS FOLLOWEE_COUNTS FROM FOLLOW GROUP BY 1) SELECT FOLLOWEE AS FOLLOWER, FOLLOWER_COUNTS AS NUM FROM CTE1 WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM CTE2) ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/