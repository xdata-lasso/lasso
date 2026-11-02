-- Schema DDL
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "IS_MALE" TEXT,
    "AGE" INT,
    PRIMARY KEY ("PEOPLE_ID")
);
CREATE TABLE "CHURCH" (
    "CHURCH_ID" INT,
    "NAME" TEXT,
    "ORGANIZED_BY" TEXT,
    "OPEN_DATE" INT,
    "CONTINUATION_OF" TEXT,
    PRIMARY KEY ("CHURCH_ID")
);
CREATE TABLE "WEDDING" (
    "CHURCH_ID" INT,
    "MALE_ID" INT,
    "FEMALE_ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("CHURCH_ID", "MALE_ID", "FEMALE_ID"),
    FOREIGN KEY ("FEMALE_ID") REFERENCES "PEOPLE"("PEOPLE_ID"),
    FOREIGN KEY ("MALE_ID") REFERENCES "PEOPLE"("PEOPLE_ID"),
    FOREIGN KEY ("CHURCH_ID") REFERENCES "CHURCH"("CHURCH_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PEOPLE VALUES (3, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (2, 0, 0, 0, 0);
INSERT INTO CHURCH VALUES (1, 0, 0, 0, 0);
INSERT INTO CHURCH VALUES (0, 0, 0, 0, 0);
INSERT INTO WEDDING VALUES (1, 2, 2, 2016);
INSERT INTO WEDDING VALUES (1, 3, 3, 2016);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT female_id AS count__distinct_church_id_ FROM (SELECT church_id, female_id, COUNT(DISTINCT church_id) AS n_distinct FROM wedding GROUP BY church_id, female_id) WHERE (church_id <> 2016 AND n_distinct = church_id) ORDER BY count__distinct_church_id_;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT church_id) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(1,)
*/