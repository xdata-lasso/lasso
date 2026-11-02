-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follow" ("followee", "follower") VALUES ('expect', 'wish');
INSERT INTO "follow" ("followee", "follower") VALUES ('wish', 'push');
INSERT INTO "follow" ("followee", "follower") VALUES ('discuss', 'onto');
INSERT INTO "follow" ("followee", "follower") VALUES ('reveal', 'followee');
INSERT INTO "follow" ("followee", "follower") VALUES ('followee', NULL);
INSERT INTO "follow" ("followee", "follower") VALUES ('special', 'threat');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('followee', 1)
('wish', 1)
*/

-- Prediction Query
WITH TMP AS (SELECT T1.FOLLOWEE AS ID, T1.FOLLOWER, T2.FOLLOWER AS FOLLOWER_FOLLOWER FROM FOLLOW AS T1 LEFT JOIN FOLLOW AS T2 ON T2.FOLLOWEE = T1.FOLLOWER ORDER BY T1.FOLLOWEE, T1.follower NULLS LAST, T2.followee NULLS LAST, T2.follower NULLS LAST) SELECT FOLLOWER, COUNT(DISTINCT FOLLOWER_FOLLOWER) AS NUM FROM TMP WHERE NOT FOLLOWER_FOLLOWER IS NULL GROUP BY 1;

/*
Prediction Result:
('wish', 1)
*/