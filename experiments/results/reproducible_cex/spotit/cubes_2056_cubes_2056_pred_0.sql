-- Schema DDL
CREATE TABLE "ROLLER_COASTER" (
    "ROLLER_COASTER_ID" INT,
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "PARK" TEXT,
    "LENGTH" FLOAT,
    "HEIGHT" FLOAT,
    "SPEED" TEXT,
    "OPENED" TEXT,
    "STATUS" TEXT,
    PRIMARY KEY ("ROLLER_COASTER_ID"),
    FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRY"("COUNTRY_ID")
);
CREATE TABLE "COUNTRY" (
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "POPULATION" INT,
    "AREA" INT,
    "LANGUAGES" TEXT,
    PRIMARY KEY ("COUNTRY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROLLER_COASTER VALUES (0, 0, 0, 0, NULL, 100, 0, 0, -1);
INSERT INTO ROLLER_COASTER VALUES (1, 0, 0, 0, NULL, 100, 0, 0, 0);
INSERT INTO COUNTRY VALUES (0, 0, 0, 0, 0);
INSERT INTO COUNTRY VALUES (1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
*/