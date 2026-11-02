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
INSERT INTO SCHOOL VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO SCHOOL VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO BUDGET VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO BUDGET VALUES (-1, 1, 0, 0, 0, 0, 0);
INSERT INTO ENDOWMENT VALUES (0, -1, 0, 31891);
INSERT INTO ENDOWMENT VALUES (1, 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name, sumamount AS sum_amount_ FROM (SELECT donator_name, school_id, SUM(amount) AS sumamount FROM endowment GROUP BY donator_name, school_id) ORDER BY donator_name, sum_amount_ NULLS LAST;

/*
Gold Result:
('0', 31891.0)
('0', None)
*/

-- Prediction Query
SELECT donator_name, SUM(amount) FROM endowment GROUP BY donator_name ORDER BY SUM(amount) DESC, donator_name NULLS LAST;

/*
Prediction Result:
('0', 31891.0)
*/