-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests JOIN mutants (INNER JOIN, NATURAL JOIN). Includes players with 0 tryouts (kills unexpected INNER JOIN) and players with >1 tryouts (kills un-deduplicated JOINs). Also tests HS boundaries.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Zack', 'yes', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Yash', 'yes', 0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Xavier', 'no', 2000);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'MIT', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Stanford', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM "player" WHERE ("ycard" = 'yes') ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Yash',)
('Zack',)
*/

-- Prediction Query
SELECT pName FROM Player WHERE yCard = 'yes' ORDER BY HS DESC, Player.pid NULLS LAST;

/*
Prediction Result:
('Zack',)
('Yash',)
*/