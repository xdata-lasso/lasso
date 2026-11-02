-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'M1', 'H1', NULL, 40.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'M2', 'H2', NULL, 60.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'M3', 'H3', 'Charlie', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'M4', 'H4', 'Adams', 30.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'M5', 'H5', 'Adams', 70.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'M6', 'H6', 'Baker', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (1, 1, 'P1', 100.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (2, 3, 'P2', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (3, 3, 'P3', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, founder FROM (SELECT founder, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY founder) ORDER BY sum_revenue_, founder NULLS LAST;

/*
Gold Result:
(50.0, 'Baker')
(100.0, 'Adams')
(100.0, 'Charlie')
(100.0, None)
*/

-- Prediction Query
SELECT SUM(revenue), founder FROM manufacturers GROUP BY founder;

/*
Prediction Result:
(100.0, None)
(100.0, 'Adams')
(50.0, 'Baker')
(100.0, 'Charlie')
*/