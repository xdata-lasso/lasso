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
SELECT B.FOLLOWER AS FOLLOWER, A.FOLLOWER_NUM AS NUM FROM (SELECT FOLLOWEE, COUNT(FOLLOWER) AS FOLLOWER_NUM FROM FOLLOW GROUP BY FOLLOWEE HAVING COUNT(FOLLOWER) >= 1) AS A INNER JOIN (SELECT FOLLOWER, COUNT(FOLLOWEE) AS FOLLOWEE_NUM FROM FOLLOW GROUP BY FOLLOWER HAVING COUNT(FOLLOWEE) >= 1) AS B ON A.FOLLOWEE = B.FOLLOWER ORDER BY B.FOLLOWER ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
*/