-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL Manufacturer in Products, tie-breaking in ORDER BY avg_price_, and NULLS LAST behavior on the secondary sort column (manufacturer).
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Alpha', 'WA', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Omega', 'OR', 'Charlie', 600.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 20, 'ItemA', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 10, 'ItemB', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, NULL, 'ItemC', 40.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, NULL, 'ItemD', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, manufacturer FROM (SELECT manufacturer, AVG(price) AS meanprice FROM products GROUP BY manufacturer) ORDER BY avg_price_, manufacturer NULLS LAST;

/*
Gold Result:
(50.0, 10)
(50.0, 20)
(50.0, None)
*/

-- Prediction Query
SELECT AVG(Price), Manufacturer FROM Products GROUP BY Manufacturer;

/*
Prediction Result:
(50.0, None)
(50.0, 10)
(50.0, 20)
*/