-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Beta', 'NY', 'John', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Alpha', 'LA', 'Jane', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'SF', 'Bob', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Alpha', 'SF')
('Alpha', 'LA')
('Beta', 'NY')
*/

-- Prediction Query
SELECT name, headquarter FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Alpha', 'LA')
('Alpha', 'SF')
('Beta', 'NY')
*/