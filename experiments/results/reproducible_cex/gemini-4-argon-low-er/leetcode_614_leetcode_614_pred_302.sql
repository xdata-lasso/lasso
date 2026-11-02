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
WITH USER_LIST AS (SELECT FOLLOWEE AS USER FROM FOLLOW UNION SELECT FOLLOWER AS USER FROM FOLLOW), CTE2 AS (SELECT FOLLOWER AS USER FROM FOLLOW GROUP BY 1 HAVING COUNT(FOLLOWEE) >= 1), CTE3 AS (SELECT FOLLOWEE AS USER, COUNT(FOLLOWER) AS NUM FROM FOLLOW GROUP BY 1 HAVING COUNT(FOLLOWER) >= 1) SELECT U.USER AS FOLLOWER, CTE3.NUM FROM USER_LIST AS U JOIN CTE3 ON U.USER = CTE3.USER WHERE U.USER IN (SELECT USER FROM CTE2) ORDER BY 1 ASC, FOLLOWER NULLS LAST, CTE3.NUM NULLS LAST;

/*
Prediction Result:
*/