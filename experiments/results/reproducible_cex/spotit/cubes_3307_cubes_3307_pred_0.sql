-- Schema DDL
CREATE TABLE "BODY_BUILDER" (
    "BODY_BUILDER_ID" INT,
    "PEOPLE_ID" INT,
    "SNATCH" FLOAT,
    "CLEAN_JERK" FLOAT,
    "TOTAL" FLOAT,
    PRIMARY KEY ("BODY_BUILDER_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "BIRTH_DATE" TEXT,
    "BIRTH_PLACE" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BODY_BUILDER VALUES (-1, 1, -1, 0, 0);
INSERT INTO BODY_BUILDER VALUES (0, 1, -2, 0, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT snatch AS min_snatch_ FROM (SELECT MIN(snatch) AS snatch FROM body_builder) ORDER BY min_snatch_;

/*
Gold Result:
(-2.0,)
*/

-- Prediction Query
SELECT MIN(snatch) FROM body_builder;

/*
Prediction Result:
(-2.0,)
*/