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
WITH USERS_WITH_FOLLOWERS AS (SELECT FOLLOWEE AS USER, COUNT(DISTINCT FOLLOWER) AS FOLLOWER_COUNT FROM FOLLOW GROUP BY 1), USER_AS_FOLLOWERS AS (SELECT FOLLOWER AS USER, COUNT(DISTINCT FOLLOWEE) AS FOLLOWEE_COUNT FROM FOLLOW GROUP BY 1) SELECT A.USER AS FOLLOWER, A.FOLLOWER_COUNT AS NUM FROM USERS_WITH_FOLLOWERS AS A JOIN USER_AS_FOLLOWERS AS B ON A.USER = B.USER WHERE A.FOLLOWER_COUNT >= 1 AND B.FOLLOWEE_COUNT >= 1 GROUP BY 1;

/*
Prediction Result:
('wish', 1)
*/