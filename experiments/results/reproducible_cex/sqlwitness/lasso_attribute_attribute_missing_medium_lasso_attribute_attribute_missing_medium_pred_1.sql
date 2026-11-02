-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO vehicles (vin, make, model, mileage, is_preowned) VALUES ('default2', 'default2', 'default2', 0, 0), ('default1', 'default2', NULL, NULL, 1), ('unique_2', 'default1', NULL, 50000, 49999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1;

/*
Prediction Result:
('default2', None)
*/