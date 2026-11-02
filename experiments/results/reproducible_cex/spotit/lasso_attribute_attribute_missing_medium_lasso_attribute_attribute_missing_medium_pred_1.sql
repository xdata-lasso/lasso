-- Schema DDL
CREATE TABLE "VEHICLES" (
    "VIN" TEXT,
    "MAKE" TEXT,
    "MODEL" TEXT,
    "MILEAGE" INT,
    "IS_PREOWNED" INT,
    PRIMARY KEY ("VIN")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO VEHICLES VALUES (3, 0, 0, 50000, 1);
INSERT INTO VEHICLES VALUES (4, 0, 0, 0, 2);
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
('0', '0')
*/