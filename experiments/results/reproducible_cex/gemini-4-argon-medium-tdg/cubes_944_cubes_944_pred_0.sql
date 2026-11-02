-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (10, 'TechOne', 'Seattle', 'Zack', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'TechTwo', 'Seattle', 'Alice', 2000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (20, 'TechThree', 'Boston', 'Bob', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 10, 'Laptop', 999.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 10, 'Mouse', 25.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarter FROM manufacturers ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Boston',)
('Seattle',)
('Seattle',)
*/

-- Prediction Query
SELECT DISTINCT headquarter FROM manufacturers;

/*
Prediction Result:
('Seattle',)
('Boston',)
*/