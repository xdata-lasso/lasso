-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('A', 'Z');
INSERT INTO follow (followee, follower) VALUES ('Z', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
('Z', 1)
*/

-- Prediction Query
SELECT FWE.FOLLOWER, COUNT(DISTINCT FWER.FOLLOWER) AS NUM FROM FOLLOW AS FWE JOIN FOLLOW AS FWER ON FWE.FOLLOWER = FWER.FOLLOWEE GROUP BY FWE.FOLLOWER;

/*
Prediction Result:
('A', 1)
('Z', 1)
*/