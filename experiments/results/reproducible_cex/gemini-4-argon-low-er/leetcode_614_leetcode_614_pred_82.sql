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
WITH T1 AS (SELECT DISTINCT FOLLOWEE, FOLLOWER FROM FOLLOW), T2 AS (SELECT DISTINCT FOLLOWER FROM FOLLOW) SELECT T1.FOLLOWEE AS FOLLOWER, COUNT(T1.FOLLOWER) AS NUM FROM T1 INNER JOIN T2 ON T1.FOLLOWEE = T2.FOLLOWER GROUP BY FOLLOWEE ORDER BY FOLLOWEE, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/