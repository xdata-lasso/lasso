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
SELECT TFOLLOWER.FOLLOWER, COUNT(DISTINCT T2NDDEGREEFOLLOWER.FOLLOWER) AS NUM FROM FOLLOW AS TFOLLOWER LEFT JOIN FOLLOW AS T2NDDEGREEFOLLOWER ON TFOLLOWER.FOLLOWER = T2NDDEGREEFOLLOWER.FOLLOWEE GROUP BY TFOLLOWER.FOLLOWER HAVING COUNT(DISTINCT T2NDDEGREEFOLLOWER.FOLLOWER) > 0;

/*
Prediction Result:
*/