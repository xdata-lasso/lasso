-- Schema DDL
CREATE TABLE Vehicles (vin TEXT PRIMARY KEY, make TEXT, model TEXT, mileage INTEGER, is_preowned INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: vehicles --
INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('vin_1', 'veh_49b377', 'veh_57b7ac', 49999, 1);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('A', 'veh_49b377', 'veh_57b7ac', 49999, 1);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('C', 'veh_49b377', 'veh_57b7ac', 49999, 1);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('vin_4', 'veh_49b377', 'veh_57b7ac', 49999, 2);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('vin_5', 'veh_49b377', 'veh_57b7ac', 50000, 1);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('vin_6', NULL, 'veh_57b7ac', 49999, 1);

INSERT INTO "vehicles" ("vin", "make", "model", "mileage", "is_preowned") VALUES ('vin_7', 'veh_49b377', NULL, 49999, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT make, model FROM Vehicles WHERE is_preowned = 1 AND mileage < 50000;

/*
Gold Result:
('veh_49b377', 'veh_57b7ac')
('veh_49b377', 'veh_57b7ac')
('veh_49b377', 'veh_57b7ac')
(None, 'veh_57b7ac')
('veh_49b377', None)
*/

-- Prediction Query
SELECT make, model FROM Vehicles WHERE mileage < 50000;

/*
Prediction Result:
('veh_49b377', 'veh_57b7ac')
('veh_49b377', 'veh_57b7ac')
('veh_49b377', 'veh_57b7ac')
('veh_49b377', 'veh_57b7ac')
(None, 'veh_57b7ac')
('veh_49b377', None)
*/