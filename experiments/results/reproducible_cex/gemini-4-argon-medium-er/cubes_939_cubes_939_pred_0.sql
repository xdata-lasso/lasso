-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name) VALUES (1, 'Acme');
INSERT INTO Manufacturers (Code, Name) VALUES (2, 'Acme');
INSERT INTO Products (Code, Manufacturer, Price) VALUES (1, 1, 10.0);
INSERT INTO Products (Code, Manufacturer, Price) VALUES (2, 2, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(10.0, 'Acme')
(20.0, 'Acme')
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(15.0, 'Acme')
*/