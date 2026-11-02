-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'Austin', 'Ann', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Bravo', 'Boston', 'Ben', 500.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (201, 1, 'Item 1', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (202, 2, 'Item 2', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, headquarter, founder FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, LHS.maxrevenue AS maxrevenue, RHS.code AS code_other, RHS.name AS name_other, RHS.headquarter AS headquarter_other, RHS.founder AS founder_other, RHS.revenue AS revenue_other FROM (SELECT code, name, headquarter, founder, revenue, MAX(revenue) OVER () AS maxrevenue FROM manufacturers) AS LHS CROSS JOIN manufacturers AS RHS) WHERE (revenue = maxrevenue AND revenue <> revenue_other) ORDER BY name, headquarter NULLS LAST, founder NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name, headquarter, founder FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha', 'Austin', 'Ann')
*/