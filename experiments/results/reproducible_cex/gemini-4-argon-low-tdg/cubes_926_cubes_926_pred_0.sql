-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 1000000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Globex', 'Cypress Creek', 'Hank Scorpio', 5000000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'Monitor', 199.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 2, 'Monitor', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 1, 'Keyboard', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (40, NULL, 'Adapter', 15.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 2, 'Keyboard', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (50, 1, 'Mouse', NULL);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (60, 2, 'Desk', 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Adapter',)
('Keyboard',)
('Keyboard',)
('Monitor',)
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('Keyboard',)
('Monitor',)
('Keyboard',)
('Monitor',)
('Adapter',)
*/