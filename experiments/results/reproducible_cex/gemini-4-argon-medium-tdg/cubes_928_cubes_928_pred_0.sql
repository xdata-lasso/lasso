-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Both 'Tokyo' and 'Beijing' present with duplicates, plus other cities and NULLs.
-- Kills mutants missing DISTINCT, missing WHERE clause, or using incorrect COUNT column.
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Sony', 'Tokyo', 'Ibuka', 80.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Hitachi', 'Tokyo', 'Odaira', 85.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Lenovo', 'Beijing', 'Liu', 60.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Xiaomi', 'Beijing', 'Lei', 45.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Samsung', 'Seoul', 'Lee', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'Apple', 'Cupertino', 'Jobs', 365.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'UnknownCorp', NULL, NULL, 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'PlayStation', 499.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Bravia', 999.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 5, 'Galaxy', 799.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "headquarter") AS "n_distinct" FROM (SELECT * FROM "manufacturers" WHERE ("headquarter" = 'Tokyo' OR "headquarter" = 'Beijing'))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM manufacturers WHERE headquarter = 'Tokyo' OR headquarter = 'Beijing';

/*
Prediction Result:
(4,)
*/