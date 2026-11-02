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
WITH FOLLOWERS AS (SELECT FOLLOWEE AS USER, COUNT(FOLLOWER) AS FOLLOWERS FROM FOLLOW GROUP BY FOLLOWEE), FOLLOWING AS (SELECT FOLLOWER AS USER, COUNT(FOLLOWEE) AS FOLLOWING FROM FOLLOW GROUP BY FOLLOWER) SELECT A.USER AS FOLLOWER, FOLLOWERS AS NUM FROM FOLLOWERS AS A INNER JOIN FOLLOWING AS B ON A.USER = B.USER ORDER BY A.USER ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 0)
*/