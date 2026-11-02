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
INSERT INTO ROLLER_COASTER VALUES (-1, 0, 16, 17, 18, 13, 19, 20, -1);
INSERT INTO ROLLER_COASTER VALUES (0, -1, 8, 9, 10, 7, 11, 12, 0);
INSERT INTO COUNTRY VALUES (-1, 0, 0, 0, 0);
INSERT INTO COUNTRY VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT height, status, COUNT(*) AS n FROM roller_coaster GROUP BY height, status) WHERE (n <= 2) ORDER BY status;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*) > 2;

/*
Prediction Result:
*/