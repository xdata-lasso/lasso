-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Zeta Corp', 'Tokyo', 'Alice', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Alpha Inc', 'Berlin', 'Bob', 1200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Omega LLC', 'Austin', 'Charlie', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Beta Ltd', 'Tokyo', 'David', 800.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Widget A', 25.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Widget B', 30.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 2, 'Gadget X', 99.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarter FROM manufacturers ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Berlin',)
('Tokyo',)
('Tokyo',)
*/

-- Prediction Query
SELECT DISTINCT headquarter FROM manufacturers;

/*
Prediction Result:
('Tokyo',)
('Berlin',)
('Austin',)
*/