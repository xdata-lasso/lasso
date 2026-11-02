-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'A', 'HQ1', 'F1', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'B', 'HQ2', 'F2', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('A', 'HQ1', 100.0)
('B', 'HQ2', 200.0)
*/

-- Prediction Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('B', 'HQ2', 200.0)
('A', 'HQ1', 100.0)
*/