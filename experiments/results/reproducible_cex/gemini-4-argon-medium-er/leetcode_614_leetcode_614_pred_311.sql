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
WITH F1 AS (SELECT FOLLOWEE AS NAME, COUNT(DISTINCT FOLLOWER) AS FOLLOWER_NUM FROM FOLLOW GROUP BY FOLLOWEE), F2 AS (SELECT FOLLOWER, COUNT(DISTINCT FOLLOWEE) AS FOLLOWEE_NUM FROM FOLLOW GROUP BY FOLLOWER), COMBINE_TABLE AS (SELECT * FROM F1 UNION ALL SELECT * FROM F2) SELECT NAME AS FOLLOWER, FOLLOWER_NUM AS NUM FROM F1 WHERE NAME IN (SELECT NAME FROM COMBINE_TABLE GROUP BY NAME HAVING COUNT(NAME) >= 2);

/*
Prediction Result:
('A', 0)
*/