-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha Corp', 'Zurich', 'James', 500.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta Inc', 'Austin', 'James', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma Ltd', 'Zurich', 'James', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'James', 'London', 'Robert', 400.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Delta Co', 'James', 'Alice', 250.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'Epsilon', 'Berlin', 'james', 600.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'Zeta', 'Tokyo', 'Jameson', 700.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Widget A', 10.5);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Widget B', 20.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 4, 'James', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarter" FROM "manufacturers" WHERE ("founder" = 'James') ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Zurich',)
('Zurich',)
*/

-- Prediction Query
SELECT headquarter FROM manufacturers WHERE founder = 'James';

/*
Prediction Result:
('Zurich',)
('Austin',)
('Zurich',)
*/