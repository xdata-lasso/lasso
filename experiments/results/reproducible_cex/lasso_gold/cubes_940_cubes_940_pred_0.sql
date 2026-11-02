-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1009, 'Cristian Santos', 'offer', 'kind', 1010.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1011, 'Kevin Pacheco', 'according', 'song', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, name FROM (SELECT name, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY name) ORDER BY sum_revenue_, name NULLS LAST;

/*
Gold Result:
(None, 'Kevin Pacheco')
(1010.5, 'Cristian Santos')
*/

-- Prediction Query
SELECT SUM(revenue), name FROM manufacturers GROUP BY name;

/*
Prediction Result:
(1010.5, 'Cristian Santos')
(None, 'Kevin Pacheco')
*/