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
SELECT B.FOLLOWEE AS FOLLOWER, B.FOLLOWER AS NUM FROM (SELECT FOLLOWER, COUNT(FOLLOWEE) AS FOLLOWEE FROM FOLLOW GROUP BY FOLLOWER) AS A INNER JOIN (SELECT FOLLOWEE, COUNT(FOLLOWER) AS FOLLOWER FROM FOLLOW GROUP BY FOLLOWEE) AS B ON A.FOLLOWER = B.FOLLOWEE ORDER BY FOLLOWER ASC, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/