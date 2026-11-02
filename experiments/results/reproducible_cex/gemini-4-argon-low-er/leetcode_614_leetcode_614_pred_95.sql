-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('U1', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('U2', 'U1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('U1', 1)
*/

-- Prediction Query
SELECT A.FOLLOWER AS FOLLOWER, COUNT(DISTINCT (B.FOLLOWER)) AS NUM FROM FOLLOW AS A LEFT JOIN FOLLOW AS B ON A.FOLLOWER = B.FOLLOWEE WHERE NOT B.FOLLOWER IS NULL GROUP BY A.FOLLOWER;

/*
Prediction Result:
*/