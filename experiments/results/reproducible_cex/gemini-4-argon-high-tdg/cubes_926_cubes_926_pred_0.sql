-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta Tech', 'Boston', 'Bob', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (301, 1, 'Zebra Scanner', 150.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Alpha Mouse', 199.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (205, 2, 'Gamma Keyboard', 199.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 2, 'Delta Monitor', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 1, 'Epsilon Desk', 200.01);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 2, 'Beta Webcam', 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Alpha Mouse',)
('Gamma Keyboard',)
('Zebra Scanner',)
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('Delta Monitor',)
('Alpha Mouse',)
('Gamma Keyboard',)
('Zebra Scanner',)
*/