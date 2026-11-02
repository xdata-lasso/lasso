-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha Corp', 'NY', 'Alice', 100.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta Inc', 'LA', 'Alice', 100.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Gamma LLC', 'NY', 'Bob', 201.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Delta Co', 'SF', NULL, 201.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Epsilon Ltd', 'TX', 'Charlie', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Widget A', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Widget B', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, founder FROM (SELECT founder, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY founder) ORDER BY sum_revenue_, founder NULLS LAST;

/*
Gold Result:
(50.0, 'Charlie')
(201.0, 'Alice')
(201.0, 'Bob')
(201.0, None)
*/

-- Prediction Query
SELECT SUM(revenue), founder FROM manufacturers GROUP BY founder;

/*
Prediction Result:
(201.0, None)
(201.0, 'Alice')
(201.0, 'Bob')
(50.0, 'Charlie')
*/