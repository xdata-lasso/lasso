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
INSERT INTO CANDIDATE VALUES (-1, 0, 9, 0, 0, 0, NULL, 0);
INSERT INTO CANDIDATE VALUES (0, 0, 8, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT poll_source FROM (SELECT * FROM (SELECT * FROM candidate ORDER BY oppose_rate DESC, candidate.candidate_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('8',)
*/

-- Prediction Query
SELECT poll_source FROM candidate ORDER BY oppose_rate DESC, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('8',)
*/