-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V001', 'Toyota', 'Camry', 49999, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V002', 'Honda', 'Civic', 50000, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V003', 'Ford', 'Focus', 50001, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V004', 'Chevy', 'Malibu', 30000, 0);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V005', 'Nissan', 'Altima', 30000, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
('Toyota', 'Camry')
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1;

/*
Prediction Result:
('Toyota', 'Camry')
('Honda', 'Civic')
('Ford', 'Focus')
*/