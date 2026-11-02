-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: follow --
INSERT INTO "follow" ("followee", "follower") VALUES ('fol_4917cc', 'fol_56c114');

INSERT INTO "follow" ("followee", "follower") VALUES ('fol_56c114', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('fol_bfa58e', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('@', 'A');

INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('A', 2)
('fol_56c114', 1)
('fol_bfa58e', 1)
*/

-- Prediction Query
WITH T1 AS (SELECT * FROM FOLLOW AS A WHERE EXISTS(SELECT * FROM FOLLOW AS B WHERE A.FOLLOWEE = B.FOLLOWER)), T2 AS (SELECT * FROM T1 WHERE FOLLOWEE <> FOLLOWER), T3 AS (SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWEE) AS NUM FROM T2 GROUP BY FOLLOWEE) SELECT * FROM T3 ORDER BY FOLLOWER;

/*
Prediction Result:
('A', 1)
('fol_56c114', 1)
*/