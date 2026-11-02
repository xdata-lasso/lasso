-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ascending order, duplicate names (testing DISTINCT vs ALL), and NULLS LAST on Code.
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Mfg A', 'NY', 'Alice', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'Zebra', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 1, 'Apple', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 1, 'Apple', 30.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (NULL, 1, 'Apple', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Apple',)
('Apple',)
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT Name FROM Products;

/*
Prediction Result:
('Apple',)
('Apple',)
('Zebra',)
('Apple',)
*/