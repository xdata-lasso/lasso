-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1125, 'no', 'space', 'Florida', 'career', 'receive');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1132, 'woman', 'notice', 'Wisconsin', 'show', 'road');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1126, 'may', 'White');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1133, 'deep', 'White');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('no', 'may', 1127, 'sell', 'Maryland', 'Joseph Obrien', 1128, 1129, 1130, 1131, 'development');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('woman', 'deep', 1128, 'your', 'Oklahoma', 'Barbara Walker', 1129, 1130, 1131, 1132, 'we');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "score" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'White')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST, "score" NULLS LAST;

/*
Gold Result:
('Barbara Walker', 1131)
('Joseph Obrien', 1130)
*/

-- Prediction Query
SELECT T2.Name, T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'White';

/*
Prediction Result:
('Joseph Obrien', 1130)
('Barbara Walker', 1131)
*/