-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Zeta Corp', 'New York', 'Alice', 100.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Ypsilon Inc', 'London', 'Bob', 150.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Alpha Ltd', 'Tokyo', 'Charlie', 149.99);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Beta LLC', 'Berlin', 'David', 99.99);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Gamma Group', 'Paris', 'Eve', 125.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'Delta Co', 'Seoul', 'Frank', NULL);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'Epsilon Tech', 'Toronto', 'Grace', 200.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (8, 'Omega Systems', 'Sydney', 'Heidi', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Alpha Ltd',)
('Gamma Group',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
('Zeta Corp',)
('Ypsilon Inc',)
('Alpha Ltd',)
('Gamma Group',)
*/