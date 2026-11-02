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
INSERT INTO MOUNTAIN VALUES (0, 0, 5200, 0, 0, 0);
INSERT INTO MOUNTAIN VALUES (-1, 0, 0, 0, 0, NULL);
INSERT INTO CLIMBER VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO CLIMBER VALUES (-1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/