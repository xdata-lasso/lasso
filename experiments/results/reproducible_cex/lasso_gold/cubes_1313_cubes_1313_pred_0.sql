-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1114, 'per', 'discussion', 'Alabama', 'avoid', 'second');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1126, 'material', 'surface', 'Nebraska', 'customer', 'between');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1132, 'economy', NULL, NULL, NULL, NULL);
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1115, 'program', 'Red');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1127, 'bill', 'Red');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('per', 'program', 1116, 'artist', 'Iowa', 'Andre Rivera', 1117, 51, 1118, 1119, 'my');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('economy', 'program', 1122, 'cause', 'Washington', 'Laura Kennedy', 1123, 51, 1124, 1125, 'still');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('material', 'bill', 1128, 'reason', 'Nevada', 'Jason Shields', 1129, 51, 1130, 1131, 'arm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."grape" AS "grape", "LHS"."color" AS "color", "RHS"."no" AS "no", "RHS"."winery" AS "winery", "RHS"."appelation" AS "appelation", "RHS"."state" AS "state", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "grapes" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."grape" = "RHS"."grape")) WHERE ("color" = 'Red' AND price > 50) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Andre Rivera',)
('Jason Shields',)
('Laura Kennedy',)
*/

-- Prediction Query
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red' AND T2.price > 50;

/*
Prediction Result:
('Andre Rivera',)
('Laura Kennedy',)
('Jason Shields',)
*/