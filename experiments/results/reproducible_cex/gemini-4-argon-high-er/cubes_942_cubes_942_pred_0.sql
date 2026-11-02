-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'M1', 'HQ1', 'F1', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'M2', 'HQ2', 'F2', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'P1', 1.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 2, 'P2', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(price) OVER () AS avg_price_ FROM products WHERE (manufacturer = 2 OR price <= 2.0) ORDER BY avg_price_;

/*
Gold Result:
(5.5,)
*/

-- Prediction Query
SELECT AVG(price) FROM products WHERE Manufacturer = 2;

/*
Prediction Result:
(10.0,)
*/