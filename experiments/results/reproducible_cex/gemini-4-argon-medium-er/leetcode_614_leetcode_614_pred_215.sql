-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('B', 'A');
INSERT INTO "follow" ("followee", "follower") VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT FOLLOWEE, COUNT(FOLLOWER) AS NUM FROM FOLLOW GROUP BY FOLLOWEE), CTE2 AS (SELECT DISTINCT CTE1.FOLLOWEE AS FOLLOWER, CTE1.NUM FROM CTE1 JOIN FOLLOW ON CTE1.FOLLOWEE = FOLLOW.FOLLOWER ORDER BY CTE1.FOLLOWEE, FOLLOWER NULLS LAST, CTE1.NUM NULLS LAST) SELECT * FROM CTE2;

/*
Prediction Result:
('A', 0)
*/