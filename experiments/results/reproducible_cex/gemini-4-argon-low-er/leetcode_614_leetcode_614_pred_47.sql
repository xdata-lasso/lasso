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
SELECT FF.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT FF.FOLLOWER) AS NUM FROM (SELECT FOLLOWEE, FOLLOWER FROM FOLLOW WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW)) AS FF GROUP BY FF.FOLLOWEE ORDER BY FF.FOLLOWEE ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/