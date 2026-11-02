-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha Corp', 'New York', 'Alice', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta Inc', 'London', 'Bob', 2000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma LLC', 'Tokyo', 'Charlie', 1500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Delta Ltd', 'Berlin', 'David', 500.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Item A1', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Item A2', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 1, 'Item A3', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 3, 'Item G1', 8.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, 2, 'Item B1', 1.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (106, 2, 'Item B2', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, manufacturer FROM (SELECT manufacturer, AVG(price) AS meanprice FROM products GROUP BY manufacturer) ORDER BY avg_price_, manufacturer NULLS LAST;

/*
Gold Result:
(1.5, 2)
(8.0, 3)
(15.0, 1)
*/

-- Prediction Query
SELECT AVG(Price), Manufacturer FROM Products GROUP BY Manufacturer;

/*
Prediction Result:
(15.0, 1)
(1.5, 2)
(8.0, 3)
*/