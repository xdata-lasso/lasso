-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (30, 'Zenith', 'Tokyo', 'Kenji', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'Apex', 'Zurich', 'Alice', 1200.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'Apex', 'Boston', 'Bob', 800.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Nova', 'London', 'Clara', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 10, 'Widget A', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 10, 'Widget B', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 30, 'Gadget X', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Apex', 'Zurich')
('Apex', 'Boston')
('Nova', 'London')
('Zenith', 'Tokyo')
*/

-- Prediction Query
SELECT name, headquarter FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Apex', 'Zurich')
('Apex', 'Boston')
('Zenith', 'Tokyo')
('Nova', 'London')
*/