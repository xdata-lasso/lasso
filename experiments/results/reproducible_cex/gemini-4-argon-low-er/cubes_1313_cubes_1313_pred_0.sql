-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation) VALUES (1, 'Napa');
INSERT INTO wine (Appelation, Grape, No, Name, Price) VALUES ('Napa', 'Pinot Noir', 1, 'Zinfandel Reserve', 60);
INSERT INTO wine (Appelation, Grape, No, Name, Price) VALUES ('Napa', 'Pinot Noir', 2, 'Alpha Vintage', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."grape" AS "grape", "LHS"."color" AS "color", "RHS"."no" AS "no", "RHS"."winery" AS "winery", "RHS"."appelation" AS "appelation", "RHS"."state" AS "state", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "grapes" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."grape" = "RHS"."grape")) WHERE ("color" = 'Red' AND price > 50) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alpha Vintage',)
('Zinfandel Reserve',)
*/

-- Prediction Query
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red' AND T2.price > 50;

/*
Prediction Result:
('Zinfandel Reserve',)
('Alpha Vintage',)
*/