-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Beta', 'Tokyo', 'Ken', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Alpha', 'Austin', 'Sam', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Zeta', 'Seoul', 'Lee', 40.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Zeta', 'Seoul', 'Lee', 40.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Beta', 'Osaka', 'Ken', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 2, 'Laptop', 1200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 2, 'Mouse', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 1, 'Monitor', 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, name FROM (SELECT name, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY name) ORDER BY sum_revenue_, name NULLS LAST;

/*
Gold Result:
(80.0, 'Zeta')
(150.0, 'Beta')
(300.0, 'Alpha')
*/

-- Prediction Query
SELECT SUM(revenue), name FROM manufacturers GROUP BY name;

/*
Prediction Result:
(300.0, 'Alpha')
(150.0, 'Beta')
(80.0, 'Zeta')
*/