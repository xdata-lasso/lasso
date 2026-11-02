-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('a', NULL);
INSERT INTO follow (followee, follower) VALUES ('a', NULL);
INSERT INTO follow (followee, follower) VALUES ('b', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('a', 2)
*/

-- Prediction Query
SELECT F1.FOLLOWER, COUNT(F2.FOLLOWEE) AS NUM FROM (SELECT DISTINCT FOLLOWER FROM FOLLOW) AS F1 JOIN (SELECT DISTINCT * FROM FOLLOW) AS F2 ON F1.FOLLOWER = F2.FOLLOWEE GROUP BY F1.FOLLOWER ORDER BY F1.FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('a', 1)
*/