-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'M1', 'HQ1', 'F1', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'Item A', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('Item A',)
*/