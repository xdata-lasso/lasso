-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta LLC', 'London', 'John Doe', 2000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (30, 1, 'Item Below Range', 59.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (20, 2, 'Item Exact Lower Bound', 60.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (50, 1, 'Item Just Above Lower', 60.01);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 2, 'Item Mid Range', 90.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (60, 1, 'Item Just Below Upper', 119.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (40, 2, 'Item Exact Upper Bound', 120.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (70, 1, 'Item Above Range', 120.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price, manufacturer FROM products WHERE (price > 60.0 AND price <= 120.0) ORDER BY code;

/*
Gold Result:
(10, 'Item Mid Range', 90.0, 2)
(40, 'Item Exact Upper Bound', 120.0, 2)
(50, 'Item Just Above Lower', 60.01, 1)
(60, 'Item Just Below Upper', 119.99, 1)
*/

-- Prediction Query
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

/*
Prediction Result:
(10, 2, 'Item Mid Range', 90.0)
(20, 2, 'Item Exact Lower Bound', 60.0)
(40, 2, 'Item Exact Upper Bound', 120.0)
(50, 1, 'Item Just Above Lower', 60.01)
(60, 1, 'Item Just Below Upper', 119.99)
*/