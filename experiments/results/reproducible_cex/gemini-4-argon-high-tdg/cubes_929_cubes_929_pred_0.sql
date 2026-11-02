-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Mfg_One', 'HQ_NewYork', 'Founder_Ann', 1000.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Mfg_Two', 'HQ_London', 'Founder_Bob', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Mfg_Three', 'HQ_Tokyo', 'Founder_Cara', 90.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Mfg_Four', 'HQ_Paris', 'Founder_Dan', 80.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Mfg_Five', 'HQ_Berlin', 'Founder_Eve', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 4, 'Prod_A', 500.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 5, 'Prod_B', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('Mfg_One',)
('Mfg_Two',)
('Mfg_Three',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
('Mfg_One',)
*/