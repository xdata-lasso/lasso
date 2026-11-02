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
WITH FOLLOWER_COUNT AS (SELECT FOLLOWER AS USER_NAME, COUNT(FOLLOWEE) AS FOLLOWERS FROM FOLLOW GROUP BY 1), FOLLOWING AS (SELECT FOLLOWEE AS USER_NAME, COUNT(FOLLOWER) AS FOLLOWING FROM FOLLOW GROUP BY 1) SELECT DISTINCT F1.USER_NAME AS FOLLOWER, F2.FOLLOWING AS NUM FROM FOLLOWER_COUNT AS F1 JOIN FOLLOWING AS F2 ON F1.USER_NAME = F2.USER_NAME ORDER BY F1.USER_NAME ASC, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('followee', 0)
('wish', 1)
*/