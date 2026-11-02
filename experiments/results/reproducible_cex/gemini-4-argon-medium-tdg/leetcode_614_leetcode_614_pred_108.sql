-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO follow (followee, follower) VALUES ('A', 'A');
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('C', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
SELECT D.FOLLOWEE AS FOLLOWER, COUNT(*) AS NUM FROM (SELECT (C.FOLLOWEE), (C.FOLLOWER) FROM (SELECT DISTINCT (A.FOLLOWEE), (A.FOLLOWER) FROM FOLLOW AS A INNER JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER AND A.FOLLOWEE <> A.FOLLOWER) AS C GROUP BY C.FOLLOWEE, C.FOLLOWER) AS D GROUP BY D.FOLLOWEE ORDER BY D.FOLLOWEE, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
*/