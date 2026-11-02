-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'BudgetGoods', 'Dallas', 'Charlie', 80.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'CheapItem1', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 1, 'CheapItem2', 179.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 1, 'UnpricedItem', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM products WHERE (price >= 180.0) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM products WHERE price >= 180;

/*
Prediction Result:
(0,)
*/