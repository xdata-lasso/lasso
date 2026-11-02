-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(DISTINCT F1.FOLLOWER) AS NUM FROM FOLLOW AS F1 JOIN (SELECT DISTINCT FOLLOWER FROM FOLLOW) AS F2 ON (F1.FOLLOWEE = F2.FOLLOWER) GROUP BY 1;

/*
Prediction Result:
('A', 0)
*/