-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('a', 'b');
INSERT INTO "follow" ("followee", "follower") VALUES ('b', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('b', 1)
*/

-- Prediction Query
WITH FOLLOWER_CTE AS (SELECT FOLLOWER FROM FOLLOW GROUP BY 1 HAVING COUNT(*) >= 1) SELECT B.FOLLOWER, COUNT(A.FOLLOWER) AS NUM FROM FOLLOWER_CTE AS B INNER JOIN FOLLOW AS A ON B.FOLLOWER = A.FOLLOWEE GROUP BY 1 HAVING COUNT(A.FOLLOWER) >= 1 ORDER BY 1, B.FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
*/