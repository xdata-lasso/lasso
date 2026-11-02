-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'MfgA', 'NY', 'Alice', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'MfgB', 'LA', 'Bob', 2000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 1, 'Monitor', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 2, 'Monitor', 150.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 1, 'Keyboard', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (15, 2, 'Keyboard', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (25, 1, 'Keyboard', 80.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'Mouse', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(5, 'Keyboard', 50.0)
(15, 'Keyboard', 50.0)
(20, 'Monitor', 150.0)
(30, 'Mouse', 150.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(5, 'Keyboard', 50.0)
(20, 'Monitor', 150.0)
(30, 'Mouse', 150.0)
*/