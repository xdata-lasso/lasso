-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'NY', 'Alice', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Alpha', 'CA', 'Bob', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Beta', 'TX', 'Charlie', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Gamma', 'FL', 'David', 400.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'ProdA', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 2, 'ProdB', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 2, 'ProdC', 30.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (104, 3, 'ProdD', 40.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (105, 3, 'ProdE', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (106, 3, 'ProdF', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT manufacturer, name, COUNT(*) AS n FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY manufacturer, name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Alpha')
(2, 'Alpha')
(3, 'Beta')
*/

-- Prediction Query
SELECT COUNT(*), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(3, 'Alpha')
(3, 'Beta')
*/