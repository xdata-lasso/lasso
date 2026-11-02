-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('u1', 'u2');
INSERT INTO "follow" ("followee", "follower") VALUES ('u2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('u2', 1)
*/

-- Prediction Query
SELECT AA.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT (AA.FOLLOWER)) AS NUM FROM (SELECT A.FOLLOWER AS FOLLOWEE, B.FOLLOWER AS FOLLOWER FROM FOLLOW AS A JOIN FOLLOW AS B ON A.FOLLOWER = B.FOLLOWEE) AS AA GROUP BY AA.FOLLOWEE ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('u2', 0)
*/