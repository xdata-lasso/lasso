-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
WITH T1 AS (SELECT * FROM FOLLOW AS A WHERE EXISTS(SELECT * FROM FOLLOW AS B WHERE A.FOLLOWEE = B.FOLLOWER)), T2 AS (SELECT * FROM T1 WHERE FOLLOWEE <> FOLLOWER), T3 AS (SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWEE) AS NUM FROM T2 GROUP BY FOLLOWEE) SELECT * FROM T3 ORDER BY FOLLOWER;

/*
Prediction Result:
*/