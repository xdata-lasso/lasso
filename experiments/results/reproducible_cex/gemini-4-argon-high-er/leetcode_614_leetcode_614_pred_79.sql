-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
WITH FOLLOWER_COUNT AS (SELECT FF.FOLLOWEE, COUNT(DISTINCT FF.FOLLOWER) AS FOLLOWER_COUNT FROM (SELECT FOLLOWEE, FOLLOWER FROM FOLLOW ORDER BY FOLLOWEE, FOLLOW.follower NULLS LAST) AS FF GROUP BY FF.FOLLOWEE ORDER BY FF.FOLLOWEE, FOLLOWER_COUNT NULLS LAST) SELECT DISTINCT F.FOLLOWER, FC.FOLLOWER_COUNT AS NUM FROM FOLLOW AS F LEFT JOIN FOLLOWER_COUNT AS FC ON F.FOLLOWER = FC.FOLLOWEE WHERE (FC.FOLLOWER_COUNT IS NULL) = FALSE ORDER BY F.FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/