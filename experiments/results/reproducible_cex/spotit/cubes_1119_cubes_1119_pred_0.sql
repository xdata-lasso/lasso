-- Schema DDL
CREATE TABLE "EVENT" (
    "EVENT_ID" INT,
    "DATE" TEXT,
    "VENUE" TEXT,
    "NAME" TEXT,
    "EVENT_ATTENDANCE" INT,
    PRIMARY KEY ("EVENT_ID")
);
CREATE TABLE "JOURNALIST" (
    "JOURNALIST_ID" INT,
    "NAME" TEXT,
    "NATIONALITY" TEXT,
    "AGE" TEXT,
    "YEARS_WORKING" INT,
    PRIMARY KEY ("JOURNALIST_ID")
);
CREATE TABLE "NEWS_REPORT" (
    "JOURNALIST_ID" INT,
    "EVENT_ID" INT,
    "WORK_TYPE" TEXT,
    PRIMARY KEY ("JOURNALIST_ID", "EVENT_ID"),
    FOREIGN KEY ("EVENT_ID") REFERENCES "EVENT"("EVENT_ID"),
    FOREIGN KEY ("JOURNALIST_ID") REFERENCES "JOURNALIST"("JOURNALIST_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EVENT VALUES (1, 0, 0, 0, 0);
INSERT INTO EVENT VALUES (0, 0, 0, 0, 0);
INSERT INTO JOURNALIST VALUES (-1, 17, 13, 18, 1);
INSERT INTO JOURNALIST VALUES (0, 19, 0, 20, 0);
INSERT INTO NEWS_REPORT VALUES (0, 1, 0);
INSERT INTO NEWS_REPORT VALUES (-1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.name AS name_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM journalist AS LHS INNER JOIN journalist AS RHS ON (LHS.years_working = RHS.journalist_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('13',)
*/