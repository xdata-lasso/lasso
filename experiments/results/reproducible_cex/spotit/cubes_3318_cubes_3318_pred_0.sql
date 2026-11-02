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
INSERT INTO BODY_BUILDER VALUES (-1, 0, 0, 0, 0);
INSERT INTO BODY_BUILDER VALUES (0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0, NULL);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_birth_place_ FROM (SELECT COUNT(*) AS n FROM people) ORDER BY count_distinct_birth_place_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Birth_Place) FROM people;

/*
Prediction Result:
(0,)
*/