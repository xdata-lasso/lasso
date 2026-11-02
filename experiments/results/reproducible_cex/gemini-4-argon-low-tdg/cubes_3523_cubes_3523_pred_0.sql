-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta LLC', 'London', 'John Doe', 2000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Zebra', 10.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 2, 'Apple', 10.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 1, 'Apple', 10.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 1, 'Banana', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, 2, 'Mango', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (106, 1, 'NullPriceProd', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT LHS.price AS price, RHS.code AS code, RHS.name AS name, RHS.manufacturer AS manufacturer FROM (SELECT MIN(price) AS price FROM products) AS LHS LEFT JOIN products AS RHS ON (LHS.price = RHS.price)) ORDER BY name, price NULLS LAST;

/*
Gold Result:
('Apple', 10.5)
('Apple', 10.5)
('Zebra', 10.5)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('NullPriceProd', None)
*/