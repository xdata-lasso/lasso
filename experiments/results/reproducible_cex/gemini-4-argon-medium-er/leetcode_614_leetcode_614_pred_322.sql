-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('a', 'a');
INSERT INTO "follow" ("followee", "follower") VALUES ('a', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('a', 2)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW WHERE FOLLOWEE IN (SELECT FOLLOWEE FROM FOLLOW) AND FOLLOWEE IN (SELECT FOLLOWER FROM FOLLOW) GROUP BY FOLLOWEE ORDER BY FOLLOWEE ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('a', 1)
*/