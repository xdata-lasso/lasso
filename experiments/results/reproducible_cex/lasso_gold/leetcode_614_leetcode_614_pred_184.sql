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
WITH CTE AS (SELECT F.FOLLOWEE, COUNT(DISTINCT F.FOLLOWER) AS FOLLOWERCOUNT FROM FOLLOW AS F GROUP BY 1), CTE2 AS (SELECT F.FOLLOWER FROM FOLLOW AS F GROUP BY 1) SELECT CTE2.FOLLOWER, CTE.FOLLOWERCOUNT AS NUM FROM CTE2 LEFT JOIN CTE ON CTE2.FOLLOWER = CTE.FOLLOWEE WHERE NOT FOLLOWERCOUNT IS NULL ORDER BY 1 ASC, CTE2.FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('followee', 0)
('wish', 1)
*/