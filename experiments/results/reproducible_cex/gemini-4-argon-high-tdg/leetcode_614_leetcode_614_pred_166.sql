-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO follow (followee, follower) VALUES ('A', 'A');
INSERT INTO follow (followee, follower) VALUES ('B', 'B');
INSERT INTO follow (followee, follower) VALUES ('B', 'C');
INSERT INTO follow (followee, follower) VALUES ('D', 'E');
INSERT INTO follow (followee, follower) VALUES ('D', 'F');
INSERT INTO follow (followee, follower) VALUES ('E', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
('B', 2)
('E', 1)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW WHERE FOLLOWEE IN (SELECT DISTINCT FOLLOWER FROM FOLLOW) AND FOLLOWEE <> FOLLOWER GROUP BY 1 HAVING COUNT(*) > 0 ORDER BY 1, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('B', 1)
*/