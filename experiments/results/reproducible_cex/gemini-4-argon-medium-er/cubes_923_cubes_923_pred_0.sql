-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'M1', 'HQ1', 'F1', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'A', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 1, 'B', 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products WHERE (price >= 180.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('A', 200.0)
('B', 300.0)
*/

-- Prediction Query
SELECT name, price FROM products WHERE price >= 180 ORDER BY price DESC, name ASC, products.code NULLS LAST;

/*
Prediction Result:
('B', 300.0)
('A', 200.0)
*/