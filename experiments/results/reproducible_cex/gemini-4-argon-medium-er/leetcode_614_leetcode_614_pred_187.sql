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
WITH FAFEE AS (SELECT DISTINCT FOLLOWEE FROM FOLLOW WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW)) SELECT F2.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT F.FOLLOWER) AS NUM FROM FAFEE AS F2 LEFT JOIN FOLLOW AS F ON F2.FOLLOWEE = F.FOLLOWEE GROUP BY F2.FOLLOWEE ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/