-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, GROUP BY on (Code, Name), and primary ORDER BY (avg_t1_price_ ASC).
-- Also includes a manufacturer with no products to kill LEFT JOIN mutants,
-- and a product with NULL Manufacturer to kill RIGHT/FULL JOIN mutants.
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'NY', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta', 'CA', 'Bob', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma', 'TX', 'Charlie', 500.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Prod1', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Prod2', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 2, 'Prod3', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, NULL, 'OrphanProd', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(50.0, 'Beta')
(200.0, 'Alpha')
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(200.0, 'Alpha')
(50.0, 'Beta')
*/