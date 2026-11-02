-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Mfg_Alpha', 'Tokyo', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Mfg_Beta', 'Austin', 'Bob', 1500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (30, 'Mfg_Gamma', 'Seoul', 'Carol', 2500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (40, 'Mfg_Delta', 'Berlin', 'David', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 30, 'Monitor', 190.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 10, 'Adapter', 250.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 40, 'ZipDrive', 90.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 20, 'Keyboard', 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Adapter',)
('Keyboard',)
('Monitor',)
('ZipDrive',)
*/

-- Prediction Query
SELECT Name FROM Products;

/*
Prediction Result:
('Monitor',)
('Adapter',)
('ZipDrive',)
('Keyboard',)
*/