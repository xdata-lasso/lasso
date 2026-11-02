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
SELECT A.FOLLOWER, B.N_BEENFOLLOWED AS NUM FROM (SELECT FOLLOWER, COUNT(FOLLOWEE) AS N_FOLLOW FROM FOLLOW GROUP BY FOLLOWER) AS A LEFT JOIN (SELECT FOLLOWEE, COUNT(FOLLOWER) AS N_BEENFOLLOWED FROM FOLLOW GROUP BY FOLLOWEE) AS B ON A.FOLLOWER = B.FOLLOWEE WHERE A.N_FOLLOW >= 1 AND B.N_BEENFOLLOWED >= 1 ORDER BY A.FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
*/