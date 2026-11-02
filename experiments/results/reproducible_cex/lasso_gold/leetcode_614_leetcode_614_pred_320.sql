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
SELECT B.FOLLOWEE AS FOLLOWER, NUM FROM (SELECT FOLLOWEE, COALESCE(COUNT(FOLLOWER), 0) AS NUM FROM FOLLOW GROUP BY FOLLOWEE HAVING COALESCE(COUNT(FOLLOWER), 0) >= 1) AS B JOIN (SELECT FOLLOWER FROM FOLLOW GROUP BY FOLLOWER HAVING COALESCE(COUNT(FOLLOWEE), 0) >= 1) AS A ON B.FOLLOWEE = A.FOLLOWER ORDER BY FOLLOWER, NUM NULLS LAST;

/*
Prediction Result:
('wish', 1)
*/