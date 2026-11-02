-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1036.5, 'Danielle Ford', 'yes', 1037.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1038.5, 'Danielle Ford', 'yes', 1039.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1037.5, 'Rodney Trujillo', 'yes', 1041.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM "player" WHERE ("ycard" = 'yes') ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Danielle Ford',)
('Danielle Ford',)
('Rodney Trujillo',)
*/

-- Prediction Query
SELECT pName FROM Player WHERE yCard = 'yes' ORDER BY HS DESC, Player.pid NULLS LAST;

/*
Prediction Result:
('Rodney Trujillo',)
('Danielle Ford',)
('Danielle Ford',)
*/