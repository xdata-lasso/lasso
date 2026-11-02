-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Sony', 'Tokyo', 'Masaru Ibuka', 8000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Asus', 'Taipei', 'Ted Hsu', 5000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'Zip drive', 150.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 1, 'Monitor', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 2, 'Monitor', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 2, 'Monitor', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 2, 'Hard drive', 240.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Hard drive', 240.0)
('Monitor', 300.0)
('Monitor', 100.0)
('Monitor', 100.0)
('Zip drive', 150.0)
*/

-- Prediction Query
SELECT name, price FROM products;

/*
Prediction Result:
('Zip drive', 150.0)
('Monitor', 300.0)
('Monitor', 100.0)
('Monitor', 100.0)
('Hard drive', 240.0)
*/