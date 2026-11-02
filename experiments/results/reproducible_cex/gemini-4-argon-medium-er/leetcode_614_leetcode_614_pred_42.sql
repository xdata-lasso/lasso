-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO follow (followee, follower) VALUES ('B', 'A');
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
INSERT INTO follow (followee, follower) VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
*/

-- Prediction Query
SELECT F1.FOLLOWER, F2.NUM FROM FOLLOW AS F1 LEFT JOIN (SELECT *, COUNT(*) OVER (PARTITION BY FOLLOWEE) AS NUM FROM FOLLOW GROUP BY FOLLOWEE, FOLLOWER) AS F2 ON F1.FOLLOWER = F2.FOLLOWEE WHERE F2.NUM > 0 GROUP BY F1.FOLLOWER ORDER BY F1.FOLLOWER, F2.NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/