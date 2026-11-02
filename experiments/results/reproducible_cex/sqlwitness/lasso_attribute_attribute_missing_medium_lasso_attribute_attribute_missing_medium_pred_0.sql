-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO vehicles (vin, make, model, mileage, is_preowned) VALUES ('default2', 'default1', 'default2', 2, 2), ('default1', 'default2', 'default1', 2, 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE mileage < 50000;

/*
Prediction Result:
('default1', 'default2')
('default2', 'default1')
*/