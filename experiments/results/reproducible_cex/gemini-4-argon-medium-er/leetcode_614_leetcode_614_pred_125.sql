-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('B', 'A');
INSERT INTO "follow" ("followee", "follower") VALUES ('A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 1)
*/

-- Prediction Query
SELECT F.FOLLOWER, (COUNT(DISTINCT F2.FOLLOWER)) AS NUM FROM FOLLOW AS F JOIN FOLLOW AS F2 ON F.FOLLOWER = F2.FOLLOWEE GROUP BY 1;

/*
Prediction Result:
('A', 0)
*/