-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('a', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('a', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('b', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('a', 2)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWEE) AS NUM FROM (SELECT DISTINCT * FROM FOLLOW) AS F WHERE F.FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW) GROUP BY FOLLOWEE ORDER BY FOLLOWEE, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('a', 1)
*/