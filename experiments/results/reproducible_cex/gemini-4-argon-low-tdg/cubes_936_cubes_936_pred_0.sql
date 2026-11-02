-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Alpha', 'Tokyo', 'Ken', 100.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Alpha', 'Tokyo', 'Ken', 100.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Beta', 'Seoul', 'Min', 200.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (10, 1, 'Widget', 25.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (11, 1, 'Gadget', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Alpha', 'Tokyo', 100.5)
('Alpha', 'Tokyo', 100.5)
('Beta', 'Seoul', 200.0)
*/

-- Prediction Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Beta', 'Seoul', 200.0)
('Alpha', 'Tokyo', 100.5)
('Alpha', 'Tokyo', 100.5)
*/