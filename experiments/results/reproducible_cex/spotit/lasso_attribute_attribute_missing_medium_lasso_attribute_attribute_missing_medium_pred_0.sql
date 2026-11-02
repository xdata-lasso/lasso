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
INSERT INTO VEHICLES VALUES (2, NULL, 0, 0, NULL);
INSERT INTO VEHICLES VALUES (3, 0, 0, NULL, 0);
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
(None, '0')
*/