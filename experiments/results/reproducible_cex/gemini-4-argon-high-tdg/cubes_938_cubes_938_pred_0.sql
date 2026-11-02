-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Acme Corp', 'New York', 'Wile E.', 5000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Globex', 'Springfield', 'Hank S.', 9000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (30, 'Unused Mfg', 'Nowhere', 'Nobody', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 10, 'Zebra', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 20, 'Zebra', 80.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 20, 'Alpha', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 10, 'Alpha', 120.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, NULL, 'Middle', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (6, 10, 'Middle', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(1, 'Zebra', 50.0)
(2, 'Alpha', 100.0)
(3, 'Middle', 10.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(2, 'Alpha', 100.0)
(3, 'Middle', 10.0)
(1, 'Zebra', 50.0)
*/