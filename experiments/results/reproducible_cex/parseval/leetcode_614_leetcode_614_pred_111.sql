-- Schema DDL
CREATE TABLE "follow" ("followee" TEXT(255), "follower" TEXT(255), PRIMARY KEY ("followee", "follower"), CHECK ("followee" <> 'Follow.follower'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: follow --
INSERT INTO "follow" ("followee", "follower") VALUES ('@', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('!', '@');

INSERT INTO "follow" ("followee", "follower") VALUES ('A', '@');

INSERT INTO "follow" ("followee", "follower") VALUES ('a_s_fb0bb8', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('a_s_fb0bb8', 'a_s_fb0bb8');

INSERT INTO "follow" ("followee", "follower") VALUES ('a_s_fb0bb8', 'a_s_bf69ad');

INSERT INTO "follow" ("followee", "follower") VALUES ('A', 'fol_bfa58e');

INSERT INTO "follow" ("followee", "follower") VALUES ('!', 'A');

INSERT INTO "follow" ("followee", "follower") VALUES ('@', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT followee AS follower, COUNT(followee) AS num FROM follow WHERE followee IN (SELECT follower FROM follow) GROUP BY 1 ORDER BY 1, follower NULLS LAST, num NULLS LAST;

/*
Gold Result:
('@', 2)
('A', 2)
('a_s_fb0bb8', 3)
*/

-- Prediction Query
SELECT DISTINCT A.FOLLOWER AS FOLLOWER, NUM FROM FOLLOW AS A INNER JOIN (SELECT FOLLOWEE, COUNT(DISTINCT FOLLOWER) AS NUM FROM FOLLOW GROUP BY FOLLOWEE) AS B ON A.FOLLOWER = B.FOLLOWEE WHERE A.FOLLOWEE <> A.FOLLOWER ORDER BY A.FOLLOWER, FOLLOWER NULLS LAST, NUM NULLS LAST;

/*
Prediction Result:
('@', 2)
('A', 2)
*/