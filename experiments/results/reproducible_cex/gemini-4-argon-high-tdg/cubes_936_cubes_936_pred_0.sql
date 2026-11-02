-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Zeta', 'HQ_Z', 'F_Z', 500.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Alpha', 'HQ_Z_First', 'F_A1', 900.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (30, 'Alpha', 'HQ_A_Second', 'F_A2', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Beta', 'HQ_B', 'F_B', 250.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 10, 'Prod_Z1', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 10, 'Prod_Z2', 35.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 20, 'Prod_A1', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Alpha', 'HQ_Z_First', 900.0)
('Alpha', 'HQ_A_Second', 100.0)
('Beta', 'HQ_B', 250.0)
('Zeta', 'HQ_Z', 500.5)
*/

-- Prediction Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Alpha', 'HQ_Z_First', 900.0)
('Zeta', 'HQ_Z', 500.5)
('Beta', 'HQ_B', 250.0)
('Alpha', 'HQ_A_Second', 100.0)
*/