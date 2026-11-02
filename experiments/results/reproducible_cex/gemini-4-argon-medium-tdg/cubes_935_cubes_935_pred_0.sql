-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'Boston', 'James', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta', 'Austin', 'James', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma', 'Chicago', 'John', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Delta', 'Denver', 'james', 400.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Epsilon', 'Seattle', NULL, 500.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Widget A', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Widget B', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 3, 'Gadget', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarter" FROM "manufacturers" WHERE ("founder" = 'James') ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
*/

-- Prediction Query
SELECT headquarter FROM manufacturers WHERE founder = 'James';

/*
Prediction Result:
('Boston',)
('Austin',)
*/