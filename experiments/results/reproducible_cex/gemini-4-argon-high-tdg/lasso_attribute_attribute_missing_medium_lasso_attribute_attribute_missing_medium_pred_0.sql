-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('VIN001', 'Toyota', 'Corolla', 49999, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('VIN002', 'Honda', 'Civic', 50000, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('VIN003', 'Ford', 'Focus', 30000, 0);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('VIN004', 'Chevrolet', 'Malibu', 60000, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
('Toyota', 'Corolla')
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE mileage < 50000;

/*
Prediction Result:
('Toyota', 'Corolla')
('Ford', 'Focus')
*/