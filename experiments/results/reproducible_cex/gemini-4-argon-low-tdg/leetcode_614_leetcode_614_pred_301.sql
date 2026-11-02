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
WITH FOLLOWEE AS (SELECT FOLLOWEE AS ID FROM FOLLOW AS F GROUP BY 1 HAVING COUNT(*) >= 1), FOLLOWER AS (SELECT FOLLOWER AS ID FROM FOLLOW AS F GROUP BY 1 HAVING COUNT(*) >= 1), CTE AS (SELECT A.ID FROM FOLLOWEE AS A JOIN FOLLOWER AS B ON A.ID = B.ID) SELECT ID AS FOLLOWER, COUNT(FOLLOWER) AS NUM FROM CTE JOIN FOLLOW AS C ON CTE.ID = C.FOLLOWEE GROUP BY 1 ORDER BY 1, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
('B', 1)
*/