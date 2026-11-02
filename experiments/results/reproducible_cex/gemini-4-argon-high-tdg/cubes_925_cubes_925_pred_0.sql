-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Globex', 'Springfield', 'Hank Scorpio', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Boundary Low Exact', 60.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Boundary Low Just Inside', 60.01);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 1, 'Boundary Low Integer Inside', 61.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 2, 'Boundary High Integer Inside', 119.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, 2, 'Boundary High Just Inside', 119.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (106, 2, 'Boundary High Exact', 120.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (107, 2, 'Boundary High Just Outside', 120.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price, manufacturer FROM products WHERE (price > 60.0 AND price <= 120.0) ORDER BY code;

/*
Gold Result:
(102, 'Boundary Low Just Inside', 60.01, 1)
(103, 'Boundary Low Integer Inside', 61.0, 1)
(104, 'Boundary High Integer Inside', 119.0, 2)
(105, 'Boundary High Just Inside', 119.99, 2)
(106, 'Boundary High Exact', 120.0, 2)
*/

-- Prediction Query
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

/*
Prediction Result:
(101, 1, 'Boundary Low Exact', 60.0)
(102, 1, 'Boundary Low Just Inside', 60.01)
(103, 1, 'Boundary Low Integer Inside', 61.0)
(104, 2, 'Boundary High Integer Inside', 119.0)
(105, 2, 'Boundary High Just Inside', 119.99)
(106, 2, 'Boundary High Exact', 120.0)
*/