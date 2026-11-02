-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', 'B');
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
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
SELECT G.F2F AS FOLLOWER, COUNT(DISTINCT G.F2WER) AS NUM FROM (SELECT F1.FOLLOWEE AS F1F, F1.FOLLOWER AS F1WER, F2.FOLLOWEE AS F2F, F2.FOLLOWER AS F2WER FROM FOLLOW AS F1 JOIN FOLLOW AS F2 ON F1.FOLLOWER = F2.FOLLOWEE) AS G GROUP BY G.F2F HAVING COUNT(DISTINCT G.F2WER) >= 1;

/*
Prediction Result:
('A', 1)
('B', 1)
*/