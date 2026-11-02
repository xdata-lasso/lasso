-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard MIN(price) per product name, ties for minimum price, and distinct minimum prices that collide across different product names.
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme', 'NY', 'Wile', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Globex', 'CA', 'Hank', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 1, 'Widget', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 2, 'Widget', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 1, 'Gadget', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (15, 2, 'Gadget', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (25, 1, 'Gadget', 30.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'Thingamajig', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(5, 'Gadget', 10.0)
(15, 'Gadget', 10.0)
(20, 'Widget', 25.0)
(30, 'Thingamajig', 25.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(5, 'Gadget', 10.0)
(30, 'Thingamajig', 25.0)
(20, 'Widget', 25.0)
*/