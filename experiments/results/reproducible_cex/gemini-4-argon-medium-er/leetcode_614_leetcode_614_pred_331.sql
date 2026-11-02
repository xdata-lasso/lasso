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
SELECT A.FOLLOWEE AS FOLLOWER, A.NUM FROM (SELECT FOLLOWEE, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW AS A GROUP BY FOLLOWEE HAVING COUNT(DISTINCT FOLLOWER) >= 1) AS A LEFT JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER GROUP BY A.FOLLOWEE HAVING COUNT(B.FOLLOWEE) >= 1;

/*
Prediction Result:
*/