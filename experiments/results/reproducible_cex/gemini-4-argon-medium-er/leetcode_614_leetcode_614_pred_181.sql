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
WITH A AS (SELECT DISTINCT * FROM FOLLOW WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW)) SELECT FOLLOWEE AS FOLLOWER, COUNT(DISTINCT FOLLOWER) AS NUM FROM A GROUP BY FOLLOWEE ORDER BY FOLLOWEE ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/