-- Schema DDL
CREATE TABLE "PEOPLE" (
    "ID" INT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    "ALT_FIRST_NAME" TEXT,
    "ALT_LAST_NAME" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PEOPLE VALUES (-1, 4, 0, 1143848998954138487, 1555982625500808461);
INSERT INTO PEOPLE VALUES (0, 5, 0, 1143848998954138487, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM people WHERE first_name = 'Alice' AND last_name = 'Smith';

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name, last_name FROM people WHERE (first_name = 'Alice' AND last_name = 'Smith') OR (alt_first_name = 'Alice' AND alt_last_name = 'Smith');

/*
Prediction Result:
*/