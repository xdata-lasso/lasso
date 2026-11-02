-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: follow --
INSERT INTO "follow" ("followee", "follower") VALUES ('fol_4917cc', 'fol_b06291');

INSERT INTO "follow" ("followee", "follower") VALUES ('fol_b06291', 'fol_bfa58e');

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
('fol_b06291', 1)
('fol_bfa58e', 1)
*/

-- Prediction Query
SELECT FOLLOWEE AS FOLLOWER, COUNT(FOLLOWER) AS NUM FROM (SELECT DISTINCT FOLLOWEE, FOLLOWER FROM FOLLOW WHERE FOLLOWEE IN (SELECT FOLLOWER FROM FOLLOW) AND FOLLOWEE <> FOLLOWER) AS X1 GROUP BY FOLLOWEE ORDER BY FOLLOWEE, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('A', 1)
('fol_b06291', 1)
*/