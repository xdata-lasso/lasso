-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Alpha', 'HQ1', 'F1', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Alpha', 'HQ2', 'F1', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Alpha', NULL, 'F1', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'Alpha', 'HQ1', 'F2', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Alpha', 'HQ1', NULL, 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (6, 'Beta', 'HQ1', 'F1', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (7, 'Gamma', 'HQ3', 'F3', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (8, 'Gamma', 'HQ3', 'F3', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (9, 'Delta', 'HQ4', 'F4', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (10, 'Epsilon', 'HQ5', 'F5', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (11, 'Zeta', 'HQ6', 'F6', NULL);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'ProdA', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'ProdB', 60.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 9, 'ProdC', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, headquarter, founder FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, LHS.maxrevenue AS maxrevenue, RHS.code AS code_other, RHS.name AS name_other, RHS.headquarter AS headquarter_other, RHS.founder AS founder_other, RHS.revenue AS revenue_other FROM (SELECT code, name, headquarter, founder, revenue, MAX(revenue) OVER () AS maxrevenue FROM manufacturers) AS LHS CROSS JOIN manufacturers AS RHS) WHERE (revenue = maxrevenue AND revenue <> revenue_other) ORDER BY name, headquarter NULLS LAST, founder NULLS LAST;

/*
Gold Result:
('Alpha', 'HQ1', 'F1')
('Alpha', 'HQ1', 'F2')
('Alpha', 'HQ1', None)
('Alpha', 'HQ2', 'F1')
('Alpha', None, 'F1')
('Beta', 'HQ1', 'F1')
('Gamma', 'HQ3', 'F3')
*/

-- Prediction Query
SELECT name, headquarter, founder FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha', 'HQ1', 'F1')
*/