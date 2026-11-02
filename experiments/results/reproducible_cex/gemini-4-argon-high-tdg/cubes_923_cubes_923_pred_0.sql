-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (100, 'NullTest Inc', 'Austin', 'Jane', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (50, 100, NULL, 210.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 100, NULL, 600.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 100, NULL, 150.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 100, 'Keyboard', 180.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (40, 100, 'Mouse', 195.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products WHERE (price >= 180.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
(None, 600.0)
(None, 210.0)
('Keyboard', 180.0)
('Mouse', 195.5)
*/

-- Prediction Query
SELECT name, price FROM products WHERE price >= 180 ORDER BY price DESC, name ASC, products.code NULLS LAST;

/*
Prediction Result:
(None, 600.0)
(None, 210.0)
('Mouse', 195.5)
('Keyboard', 180.0)
*/