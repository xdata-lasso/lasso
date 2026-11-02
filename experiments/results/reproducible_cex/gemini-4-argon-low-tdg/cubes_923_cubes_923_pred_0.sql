-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Manufacturer A', 'HQ A', 'Founder A', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'Item A', 179.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 1, 'Item B', 180.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 1, 'Item C', 180.01);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 1, 'Item D', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 1, 'Item E', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products WHERE (price >= 180.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Item B', 180.0)
('Item C', 180.01)
*/

-- Prediction Query
SELECT name, price FROM products WHERE price >= 180 ORDER BY price DESC, name ASC, products.code NULLS LAST;

/*
Prediction Result:
('Item C', 180.01)
('Item B', 180.0)
*/