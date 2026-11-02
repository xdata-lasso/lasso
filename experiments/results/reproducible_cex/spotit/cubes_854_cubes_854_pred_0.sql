-- Schema DDL
CREATE TABLE "PERPETRATOR" (
    "PERPETRATOR_ID" INT,
    "PEOPLE_ID" INT,
    "DATE" TEXT,
    "YEAR" FLOAT,
    "LOCATION" TEXT,
    "COUNTRY" TEXT,
    "KILLED" INT,
    "INJURED" INT,
    PRIMARY KEY ("PERPETRATOR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "HOME_TOWN" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERPETRATOR VALUES (-1, 0, 0, 0, 0, 0, 0, 51);
INSERT INTO PERPETRATOR VALUES (0, 1, 0, 0, 0, NULL, 0, 50);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM perpetrator WHERE (injured >= 50 AND injured > 20) ORDER BY country, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
(None,)
('0',)
*/

-- Prediction Query
SELECT Country FROM perpetrator WHERE Injured > 50 INTERSECT SELECT Country FROM perpetrator WHERE Injured < 20;

/*
Prediction Result:
*/