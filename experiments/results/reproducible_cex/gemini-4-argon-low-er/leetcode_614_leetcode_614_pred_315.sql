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
WITH CTE AS (SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWER) AS NUM FROM FOLLOW GROUP BY FOLLOWEE UNION ALL SELECT FOLLOWER, 0 AS NUM FROM FOLLOW) SELECT DISTINCT FOLLOWER, SUM(NUM) AS NUM FROM CTE WHERE FOLLOWER IN (SELECT FOLLOWEE FROM FOLLOW GROUP BY FOLLOWEE HAVING COUNT(FOLLOWER) >= 1) AND FOLLOWER IN (SELECT FOLLOWER FROM FOLLOW) GROUP BY FOLLOWER HAVING SUM(NUM) > 0 ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
*/