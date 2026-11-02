-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES (NULL, 'A');
INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWER) AS NUM FROM FOLLOW WHERE FOLLOWEE IN (SELECT FOLLOWER FROM FOLLOW GROUP BY 1 HAVING COUNT(FOLLOWEE) >= 1) GROUP BY 1 HAVING COUNT(FOLLOWER) >= 1 ORDER BY 1, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
*/