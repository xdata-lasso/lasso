-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Acme', 'NY', 'Wile', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Acme', 'NY', 'Road', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Acme', 'NY', 'Bugs', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Acme', 'LA', 'Daffy', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Beta', 'NY', 'Porky', 400.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'Anvil', 50.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'TNT', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, revenue AS max_revenue_, headquarter FROM (SELECT headquarter, name, MAX(revenue) AS revenue FROM manufacturers GROUP BY headquarter, name) ORDER BY name, max_revenue_ NULLS LAST, headquarter NULLS LAST;

/*
Gold Result:
('Acme', 200.0, 'LA')
('Acme', 300.0, 'NY')
('Beta', 400.0, 'NY')
*/

-- Prediction Query
SELECT name, MAX(revenue), Headquarter FROM manufacturers GROUP BY Headquarter;

/*
Prediction Result:
('Acme', 200.0, 'LA')
('Beta', 400.0, 'NY')
*/