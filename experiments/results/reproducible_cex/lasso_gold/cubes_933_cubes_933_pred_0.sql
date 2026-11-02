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
SELECT sumrevenue AS sum_revenue_, founder FROM (SELECT founder, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY founder) ORDER BY sum_revenue_, founder NULLS LAST;

/*
Gold Result:
(None, 'song')
(1010.5, 'kind')
*/

-- Prediction Query
SELECT SUM(revenue), founder FROM manufacturers GROUP BY founder;

/*
Prediction Result:
(1010.5, 'kind')
(None, 'song')
*/