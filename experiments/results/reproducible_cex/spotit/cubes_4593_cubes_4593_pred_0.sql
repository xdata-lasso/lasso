-- Schema DDL
CREATE TABLE "SCHOOL" (
    "SCHOOL_ID" TEXT,
    "SCHOOL_NAME" TEXT,
    "LOCATION" TEXT,
    "MASCOT" TEXT,
    "ENROLLMENT" INT,
    "IHSAA_CLASS" TEXT,
    "IHSAA_FOOTBALL_CLASS" TEXT,
    "COUNTY" TEXT,
    PRIMARY KEY ("SCHOOL_ID")
);
CREATE TABLE "BUDGET" (
    "SCHOOL_ID" INT,
    "YEAR" INT,
    "BUDGETED" INT,
    "TOTAL_BUDGET_PERCENT_BUDGETED" FLOAT,
    "INVESTED" INT,
    "TOTAL_BUDGET_PERCENT_INVESTED" FLOAT,
    "BUDGET_INVESTED_PERCENT" TEXT,
    PRIMARY KEY ("SCHOOL_ID", "YEAR"),
    FOREIGN KEY ("SCHOOL_ID") REFERENCES "SCHOOL"("SCHOOL_ID")
);
CREATE TABLE "ENDOWMENT" (
    "ENDOWMENT_ID" INT,
    "SCHOOL_ID" INT,
    "DONATOR_NAME" TEXT,
    "AMOUNT" FLOAT,
    PRIMARY KEY ("ENDOWMENT_ID"),
    FOREIGN KEY ("SCHOOL_ID") REFERENCES "SCHOOL"("SCHOOL_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SCHOOL VALUES (0, 3, 23, 24, -1, 25, 26, 27);
INSERT INTO SCHOOL VALUES (-1, 2, 28, 29, -1, 30, 31, 32);
INSERT INTO BUDGET VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO BUDGET VALUES (-1, 1, 0, 0, 0, 0, 0);
INSERT INTO ENDOWMENT VALUES (0, -1, 0, 0);
INSERT INTO ENDOWMENT VALUES (1, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT LHS.enrollment AS enrollment, RHS.school_id AS school_id, RHS.school_name AS school_name, RHS.location AS LOCATION, RHS.mascot AS mascot, RHS.ihsaa_class AS ihsaa_class, RHS.ihsaa_football_class AS ihsaa_football_class, RHS.county AS county FROM (SELECT MIN(enrollment) AS enrollment FROM school) AS LHS LEFT JOIN school AS RHS ON (LHS.enrollment = RHS.enrollment)) ORDER BY school_name;

/*
Gold Result:
('2',)
('3',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2',)
*/