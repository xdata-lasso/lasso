-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'LowerJustOut', 'HQ1', 'F1', 99.99);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'LowerExact', 'HQ2', 'F2', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'LowerJustIn', 'HQ3', 'F3', 100.01);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'UpperJustIn', 'HQ4', 'F4', 149.99);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'UpperExact', 'HQ5', 'F5', 150.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'UpperJustOut', 'HQ6', 'F6', 150.01);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'NullRevenue', 'HQ7', 'F7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('LowerExact',)
('LowerJustIn',)
('UpperJustIn',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
('LowerExact',)
('LowerJustIn',)
('UpperJustIn',)
('UpperExact',)
*/