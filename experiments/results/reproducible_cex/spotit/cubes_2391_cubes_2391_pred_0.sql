-- Schema DDL
CREATE TABLE "MOUNTAIN" (
    "MOUNTAIN_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "PROMINENCE" FLOAT,
    "RANGE" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("MOUNTAIN_ID")
);
CREATE TABLE "CLIMBER" (
    "CLIMBER_ID" INT,
    "MOUNTAIN_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "TIME" TEXT,
    "POINTS" FLOAT,
    PRIMARY KEY ("CLIMBER_ID"),
    FOREIGN KEY ("MOUNTAIN_ID") REFERENCES "MOUNTAIN"("MOUNTAIN_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MOUNTAIN VALUES (0, 7, 8, 9, 10, 6);
INSERT INTO MOUNTAIN VALUES (-1, 12, 13, 14, 11, 6);
INSERT INTO CLIMBER VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO CLIMBER VALUES (0, -1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('6',)
*/