-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('9', '10');
INSERT INTO "follow" ("followee", "follower") VALUES ('10', '9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('10', 1)
('9', 1)
*/

-- Prediction Query
WITH T AS (SELECT FOLLOWEE FROM FOLLOW WHERE FOLLOWEE IN (SELECT FOLLOWER FROM FOLLOW)) SELECT DISTINCT (FOLLOWEE) AS FOLLOWER, COUNT(FOLLOWEE) OVER (PARTITION BY FOLLOWEE) AS NUM FROM T ORDER BY FOLLOWEE ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('10', 1)
('9', 1)
*/