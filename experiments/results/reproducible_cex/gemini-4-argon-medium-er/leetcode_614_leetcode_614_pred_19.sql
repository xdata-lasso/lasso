-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('u1', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('u2', 'u1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('u1', 1)
*/

-- Prediction Query
SELECT A.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT A.FOLLOWER) AS NUM FROM FOLLOW AS A JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER GROUP BY A.FOLLOWEE ORDER BY 1, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('u1', 0)
*/