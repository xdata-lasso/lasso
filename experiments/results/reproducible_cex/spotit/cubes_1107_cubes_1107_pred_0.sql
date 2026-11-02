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
INSERT INTO EVENT VALUES (-1, 0, 0, 0, 0);
INSERT INTO EVENT VALUES (0, 0, 0, 0, 0);
INSERT INTO JOURNALIST VALUES (0, 0, 0, 0, 11);
INSERT INTO JOURNALIST VALUES (1, 0, -1, 0, 11);
INSERT INTO NEWS_REPORT VALUES (1, 0, 0);
INSERT INTO NEWS_REPORT VALUES (1, -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM journalist WHERE (years_working > 10 OR years_working < 3) ORDER BY nationality;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Nationality FROM journalist WHERE Years_working > 10 INTERSECT SELECT Nationality FROM journalist WHERE Years_working < 3;

/*
Prediction Result:
*/