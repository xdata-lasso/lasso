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
INSERT INTO ROLLER_COASTER VALUES (1, 1, 0, 0, 0, 0, 10, 0, 0);
INSERT INTO ROLLER_COASTER VALUES (0, 1, 0, 0, 0, 0, 9, 0, 0);
INSERT INTO COUNTRY VALUES (0, 0, 0, 0, 0);
INSERT INTO COUNTRY VALUES (1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('9',)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('9',)
*/