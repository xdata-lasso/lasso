-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('6', '8', '9', -563, 7);
INSERT INTO "Vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('5', '8', '9', -635, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
('8', '9')
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE mileage < 50000;

/*
Prediction Result:
('8', '9')
('8', '9')
*/