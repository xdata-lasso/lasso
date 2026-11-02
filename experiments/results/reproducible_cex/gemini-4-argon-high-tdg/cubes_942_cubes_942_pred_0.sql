-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha Corp', 'New York', 'Alice', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta Tech', 'London', 'Bob', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma Inc', 'Tokyo', 'Charlie', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 2, 'Item A', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 1, 'Item B', 2.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 3, 'Item C', 1.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (40, 2, 'Item D', 1.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (50, 1, 'Item E', 5.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (60, 3, 'Item F', 2.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(price) OVER () AS avg_price_ FROM products WHERE (manufacturer = 2 OR price <= 2.0) ORDER BY avg_price_;

/*
Gold Result:
(3.5,)
*/

-- Prediction Query
SELECT AVG(price) FROM products WHERE Manufacturer = 2;

/*
Prediction Result:
(5.5,)
*/