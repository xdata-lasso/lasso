-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('A', 'B');
INSERT INTO follow (followee, follower) VALUES ('B', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('B', 1)
*/

-- Prediction Query
WITH FF AS (SELECT F1.FOLLOWER, F2.FOLLOWER AS FOLLOWER2 FROM FOLLOW AS F1 INNER JOIN FOLLOW AS F2 ON F1.FOLLOWER = F2.FOLLOWEE) SELECT FOLLOWER, COUNT(DISTINCT FOLLOWER2) AS NUM FROM FF WHERE NOT FOLLOWER2 IS NULL GROUP BY FOLLOWER ORDER BY FOLLOWER ASC, NUM NULLS LAST;

/*
Prediction Result:
*/