-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'A');
INSERT INTO "follow" ("followee", "follower") VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
*/

-- Prediction Query
WITH CTE1 AS (SELECT FOLLOWER, COUNT(FOLLOWEE) AS FOLLOWEE_CNT FROM FOLLOW GROUP BY FOLLOWER), CTE2 AS (SELECT FOLLOWEE, COUNT(FOLLOWER) AS FOLLOWER_CNT FROM FOLLOW GROUP BY FOLLOWEE) SELECT A.FOLLOWER, FOLLOWER_CNT AS NUM FROM CTE1 AS A JOIN CTE2 AS B ON A.FOLLOWER = B.FOLLOWEE ORDER BY A.FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/