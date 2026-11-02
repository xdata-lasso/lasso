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
INSERT INTO BODY_BUILDER VALUES (-1, 1, 0, 0, 0);
INSERT INTO BODY_BUILDER VALUES (0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (1, 15, 11, 16, 17, 0);
INSERT INTO PEOPLE VALUES (0, 7, 8, 9, 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('0', 1)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
('0', 2)
*/