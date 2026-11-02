-- Schema DDL
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "BIRTH_PLACE" TEXT,
    "HEIGHT" FLOAT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PEOPLE VALUES (1, 6, 7);
INSERT INTO PEOPLE VALUES (0, 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
('6', 1)
('6', 1)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
('6', 2)
*/