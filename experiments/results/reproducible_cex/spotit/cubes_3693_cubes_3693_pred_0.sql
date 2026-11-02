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
INSERT INTO EVENT VALUES (0, 0, 0, 0, 0);
INSERT INTO EVENT VALUES (-1, 0, 0, 0, 0);
INSERT INTO JOURNALIST VALUES (1, 20, 0, 10, 0);
INSERT INTO JOURNALIST VALUES (0, 20, 0, 10, 0);
INSERT INTO NEWS_REPORT VALUES (0, -1, 0);
INSERT INTO NEWS_REPORT VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.age AS age, LHS.nationality AS nationality, LHS.maxn AS maxn, RHS.age AS age_other, RHS.nationality AS nationality_other, RHS.maxn AS maxn_other FROM (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS LHS CROSS JOIN (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS RHS) WHERE (maxn < maxn_other) ORDER BY nationality;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/