-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Mfg A', 'NY', 'Alice', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Mfg B', 'LA', 'Bob', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Mfg C', 'SF', 'Charlie', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Prod 1', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Prod 2', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 1, 'Prod 3', 40.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 2, 'Prod 4', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, NULL, 'Prod 5', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, manufacturer FROM (SELECT manufacturer, AVG(price) AS meanprice FROM products GROUP BY manufacturer) ORDER BY avg_price_, manufacturer NULLS LAST;

/*
Gold Result:
(20.0, 1)
(20.0, 2)
(20.0, None)
*/

-- Prediction Query
SELECT AVG(Price), Manufacturer FROM Products GROUP BY Manufacturer;

/*
Prediction Result:
(20.0, None)
(20.0, 1)
(20.0, 2)
*/