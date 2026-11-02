-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Zeta Corp', 'New York', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Beta Inc', 'London', 'Bob', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (30, 'Alpha LLC', 'Tokyo', 'Charlie', 900.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (40, 'Gamma Ltd', 'Berlin', 'David', 700.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (50, 'Omega Co', 'Paris', 'Eve', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 10, 'Item Z1', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 20, 'Item B1', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 20, 'Item B2', 75.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 30, 'Item A1', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, 30, 'Item A2', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (106, 40, 'Item G1', 15.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (107, 40, 'Item G2', 35.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (108, 40, 'Item G3', 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT manufacturer, name, COUNT(*) AS n FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY manufacturer, name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Zeta Corp')
(2, 'Alpha LLC')
(2, 'Beta Inc')
(3, 'Gamma Ltd')
*/

-- Prediction Query
SELECT COUNT(*), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(2, 'Alpha LLC')
(2, 'Beta Inc')
(3, 'Gamma Ltd')
(1, 'Zeta Corp')
*/