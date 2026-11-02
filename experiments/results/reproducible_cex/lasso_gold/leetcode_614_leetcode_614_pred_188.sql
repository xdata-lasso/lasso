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
WITH LEF AS (SELECT DISTINCT FOLLOWER FROM FOLLOW WHERE FOLLOWER IN (SELECT DISTINCT FOLLOWEE FROM FOLLOW)), ANS AS (SELECT A.FOLLOWER, B.FOLLOWER AS CC FROM LEF AS A INNER JOIN FOLLOW AS B ON A.FOLLOWER = B.FOLLOWEE) SELECT FOLLOWER, COUNT(DISTINCT CC) AS NUM FROM ANS GROUP BY FOLLOWER ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('followee', 0)
('wish', 1)
*/