-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
INSERT INTO follow (followee, follower) VALUES (NULL, 'B');
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
('B', 1)
*/

-- Prediction Query
SELECT A.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT A.FOLLOWER) AS NUM FROM FOLLOW AS A LEFT JOIN FOLLOW AS B ON A.FOLLOWEE = B.FOLLOWER WHERE NOT B.FOLLOWER IS NULL GROUP BY A.FOLLOWEE HAVING COUNT(DISTINCT A.FOLLOWER) >= 1 ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
('B', 1)
*/