-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('B', 'A');
INSERT INTO "follow" ("followee", "follower") VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
WITH FOLLOWING AS (SELECT FOLLOWER FROM FOLLOW GROUP BY FOLLOWER HAVING COUNT(DISTINCT FOLLOWEE) >= 1), FOLLOWED AS (SELECT FOLLOWEE, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW GROUP BY FOLLOWEE HAVING COUNT(DISTINCT FOLLOWER) >= 1) SELECT FOLLOWEE AS FOLLOWER, NUM FROM FOLLOWED WHERE FOLLOWEE IN (SELECT * FROM FOLLOWING) ORDER BY FOLLOWEE, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
*/