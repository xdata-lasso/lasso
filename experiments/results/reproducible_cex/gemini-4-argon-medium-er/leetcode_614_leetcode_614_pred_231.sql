-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('a', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('b', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('a', 1)
*/

-- Prediction Query
WITH CTE AS (SELECT FOLLOWEE, COUNT(FOLLOWER) AS NUM FROM FOLLOW GROUP BY 1) SELECT FOLLOWEE AS FOLLOWER, NUM FROM CTE WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW) ORDER BY 1, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('a', 0)
*/