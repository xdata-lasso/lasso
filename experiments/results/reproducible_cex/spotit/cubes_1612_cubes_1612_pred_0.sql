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
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
INSERT INTO CHURCH VALUES (1, 19, 20, 0, 21);
INSERT INTO CHURCH VALUES (0, 12, 13, 0, 14);
INSERT INTO WEDDING VALUES (0, 1, 0, 0);
INSERT INTO WEDDING VALUES (0, 1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_date, n AS count___ FROM (SELECT church_id, open_date, COUNT(*) AS n FROM church GROUP BY church_id, open_date) ORDER BY open_date, count___ NULLS LAST;

/*
Gold Result:
(0, 1)
(0, 1)
*/

-- Prediction Query
SELECT open_date, COUNT(*) FROM church GROUP BY open_date;

/*
Prediction Result:
(0, 2)
*/