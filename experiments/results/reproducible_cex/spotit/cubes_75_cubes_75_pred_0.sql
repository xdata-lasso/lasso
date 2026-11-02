-- Schema DDL
CREATE TABLE "MUSEUM" (
    "MUSEUM_ID" INT,
    "NAME" TEXT,
    "NUM_OF_STAFF" INT,
    "OPEN_YEAR" TEXT,
    PRIMARY KEY ("MUSEUM_ID")
);
CREATE TABLE "VISITOR" (
    "ID" INT,
    "NAME" TEXT,
    "LEVEL_OF_MEMBERSHIP" INT,
    "AGE" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "VISIT" (
    "MUSEUM_ID" INT,
    "VISITOR_ID" TEXT,
    "NUM_OF_TICKET" INT,
    "TOTAL_SPENT" FLOAT,
    PRIMARY KEY ("MUSEUM_ID", "VISITOR_ID"),
    FOREIGN KEY ("VISITOR_ID") REFERENCES "VISITOR"("ID"),
    FOREIGN KEY ("MUSEUM_ID") REFERENCES "MUSEUM"("MUSEUM_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MUSEUM VALUES (0, 0, 0, 0);
INSERT INTO MUSEUM VALUES (-1, 0, 0, 0);
INSERT INTO VISITOR VALUES (0, 0, 0, 0);
INSERT INTO VISITOR VALUES (-1, 0, 0, 0);
INSERT INTO VISIT VALUES (-1, -1, 0, 0);
INSERT INTO VISIT VALUES (0, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT museum_id, name FROM (SELECT * FROM (SELECT * FROM museum ORDER BY num_of_staff DESC, museum.museum_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(-1, '0')
*/

-- Prediction Query
SELECT museum_id, name FROM museum ORDER BY num_of_staff DESC, museum.museum_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1, '0')
*/