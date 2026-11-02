-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('a', NULL);
INSERT INTO follow (followee, follower) VALUES ('b', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('a', 1)
*/

-- Prediction Query
SELECT B.FOLLOWER, COUNT(DISTINCT A.FOLLOWER) AS NUM FROM FOLLOW AS A JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER GROUP BY B.FOLLOWER HAVING NUM > 0;

/*
Prediction Result:
*/