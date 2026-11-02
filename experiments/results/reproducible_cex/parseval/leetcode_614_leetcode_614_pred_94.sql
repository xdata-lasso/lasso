-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: follow --
INSERT INTO "follow" ("followee", "follower") VALUES ('fol_4917cc', 'fol_6ecb48');

INSERT INTO "follow" ("followee", "follower") VALUES ('fol_6ecb48', 'fol_bfa58e');

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
('fol_6ecb48', 1)
('fol_bfa58e', 1)
*/

-- Prediction Query
SELECT A.FOLLOWEE AS FOLLOWER, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW AS A WHERE A.FOLLOWEE IN (SELECT FOLLOWER FROM FOLLOW GROUP BY 1) AND A.FOLLOWEE <> A.FOLLOWER GROUP BY 1;

/*
Prediction Result:
('A', 1)
('fol_6ecb48', 1)
*/