-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V101', 'Toyota', 'Camry', 49999, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V102', 'Honda', 'Civic', 50000, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V103', 'Ford', 'Focus', 50001, 1);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V104', 'Chevy', 'Malibu', 30000, 0);
INSERT INTO Vehicles (vin, make, model, mileage, is_preowned) VALUES ('V105', 'Nissan', 'Altima', 60000, 0);
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