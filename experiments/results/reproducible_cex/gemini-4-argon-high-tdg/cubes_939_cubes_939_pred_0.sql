-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'TechCorp', 'New York', 'Alice', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'BioHealth', 'Boston', 'Bob', 2000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'AutoWorks', 'Detroit', 'Charlie', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'EmptyMfg', 'Miami', 'Diana', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 2, 'Sensor', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 1, 'Laptop', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 1, 'Mouse', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (4, 1, 'Monitor', 40.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (5, 3, 'Tire', 10.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (6, 3, 'Engine', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (7, NULL, 'UnassignedWidget', 99.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(15.25, 'AutoWorks')
(20.0, 'TechCorp')
(50.0, 'BioHealth')
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(15.25, 'AutoWorks')
(50.0, 'BioHealth')
(20.0, 'TechCorp')
*/