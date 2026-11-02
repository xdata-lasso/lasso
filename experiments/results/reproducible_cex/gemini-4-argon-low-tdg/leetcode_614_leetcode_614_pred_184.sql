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
WITH CTE AS (SELECT F.FOLLOWEE, COUNT(DISTINCT F.FOLLOWER) AS FOLLOWERCOUNT FROM FOLLOW AS F GROUP BY 1), CTE2 AS (SELECT F.FOLLOWER FROM FOLLOW AS F GROUP BY 1) SELECT CTE2.FOLLOWER, CTE.FOLLOWERCOUNT AS NUM FROM CTE2 LEFT JOIN CTE ON CTE2.FOLLOWER = CTE.FOLLOWEE WHERE NOT FOLLOWERCOUNT IS NULL ORDER BY 1 ASC, CTE2.FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
('B', 1)
*/