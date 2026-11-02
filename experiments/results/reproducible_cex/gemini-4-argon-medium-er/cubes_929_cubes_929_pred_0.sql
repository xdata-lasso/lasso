-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'M1', 'HQ1', 'F1', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('M1',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
*/