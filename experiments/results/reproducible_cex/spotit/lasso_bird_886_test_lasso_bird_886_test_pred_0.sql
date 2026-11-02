-- Schema DDL
CREATE TABLE "SEASONS" (
    "YEAR" INT,
    PRIMARY KEY ("YEAR")
);
CREATE TABLE "RACES" (
    "RACEID" INT,
    "YEAR" INT,
    "ROUND" INT,
    PRIMARY KEY ("RACEID"),
    FOREIGN KEY ("YEAR") REFERENCES "SEASONS"("YEAR")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SEASONS VALUES (-1);
INSERT INTO SEASONS VALUES (0);
INSERT INTO RACES VALUES (0, 0, 0);
INSERT INTO RACES VALUES (1, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(round) DESC, year NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(*) DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1,)
*/