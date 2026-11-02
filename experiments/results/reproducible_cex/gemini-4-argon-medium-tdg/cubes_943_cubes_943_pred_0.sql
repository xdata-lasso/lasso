-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Alpha Corp', 'NY', 'Alice', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Beta Inc', 'CA', 'Bob', 2000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 10, 'Widget', 25.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 20, 'Widget', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 10, 'Gadget', 15.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 20, 'Widget', 25.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Gadget', 15.0)
('Widget', 10.0)
('Widget', 25.5)
('Widget', 25.5)
*/

-- Prediction Query
SELECT name, price FROM products;

/*
Prediction Result:
('Widget', 10.0)
('Gadget', 15.0)
('Widget', 25.5)
('Widget', 25.5)
*/