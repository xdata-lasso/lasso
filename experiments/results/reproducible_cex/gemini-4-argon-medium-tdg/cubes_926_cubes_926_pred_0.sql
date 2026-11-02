-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 1, 'ItemExact200', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 1, 'ItemJustBelow', 199.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'ItemJustAbove', 200.01);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (40, 1, 'ItemZero', 0.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (50, 1, 'ItemNullPrice', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('ItemJustBelow',)
('ItemZero',)
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('ItemExact200',)
('ItemJustBelow',)
('ItemZero',)
*/