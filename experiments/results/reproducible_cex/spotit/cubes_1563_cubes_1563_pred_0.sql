-- Schema DDL
CREATE TABLE "CANDIDATE" (
    "CANDIDATE_ID" INT,
    "PEOPLE_ID" INT,
    "POLL_SOURCE" TEXT,
    "DATE" TEXT,
    "SUPPORT_RATE" FLOAT,
    "CONSIDER_RATE" FLOAT,
    "OPPOSE_RATE" FLOAT,
    "UNSURE_RATE" FLOAT,
    PRIMARY KEY ("CANDIDATE_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "SEX" TEXT,
    "NAME" TEXT,
    "DATE_OF_BIRTH" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CANDIDATE VALUES (-2147483647, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CANDIDATE VALUES (-2147483648, -1, 0, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 190, 0);
INSERT INTO PEOPLE VALUES (-1, 0, 0, 0, 191, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
*/