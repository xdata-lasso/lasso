-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Code (ascending), and column selection.
-- Also tests extraneous joins (Products table has 0 products for one manufacturer and 2 for another).
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Acme', 'New York', 'Wile E.', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Acme', 'Chicago', 'Road Runner', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Beta', 'London', 'Alice', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'Tokyo', 'Bob', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 20, 'Anvil', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 20, 'TNT', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Acme', 'Chicago')
('Acme', 'New York')
('Alpha', 'Tokyo')
('Beta', 'London')
*/

-- Prediction Query
SELECT name, headquarter FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Beta', 'London')
('Acme', 'New York')
('Acme', 'Chicago')
('Alpha', 'Tokyo')
*/