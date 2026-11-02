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
INSERT INTO PEOPLE VALUES (-1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
INSERT INTO CHURCH VALUES (-1, 0, 0, 1829, 0);
INSERT INTO CHURCH VALUES (0, 0, -1, 1830, 0);
INSERT INTO WEDDING VALUES (-1, 0, 0, 0);
INSERT INTO WEDDING VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('-1', '0')
('0', '0')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
('-1', '0')
*/