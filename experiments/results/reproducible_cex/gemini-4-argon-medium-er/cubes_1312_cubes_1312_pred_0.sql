-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "wine" ("Grape", "Name", "Score") VALUES ('Chardonnay', 'Wine B', 90);
INSERT INTO "wine" ("Grape", "Name", "Score") VALUES ('Chardonnay', 'Wine A', 85);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "score" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'White')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST, "score" NULLS LAST;

/*
Gold Result:
('Wine A', 85)
('Wine B', 90)
*/

-- Prediction Query
SELECT T2.Name, T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'White';

/*
Prediction Result:
('Wine B', 90)
('Wine A', 85)
*/