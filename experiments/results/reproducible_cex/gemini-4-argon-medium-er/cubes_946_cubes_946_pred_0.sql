-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme', 'USA', 'John', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
('Acme',)
*/