-- Schema DDL
CREATE TABLE "JOURNAL" (
    "JOURNAL_ID" INT,
    "DATE" TEXT,
    "THEME" TEXT,
    "SALES" INT,
    PRIMARY KEY ("JOURNAL_ID")
);
CREATE TABLE "EDITOR" (
    "EDITOR_ID" INT,
    "NAME" TEXT,
    "AGE" FLOAT,
    PRIMARY KEY ("EDITOR_ID")
);
CREATE TABLE "JOURNAL_COMMITTEE" (
    "EDITOR_ID" INT,
    "JOURNAL_ID" INT,
    "WORK_TYPE" TEXT,
    PRIMARY KEY ("JOURNAL_ID", "EDITOR_ID"),
    FOREIGN KEY ("JOURNAL_ID") REFERENCES "JOURNAL"("JOURNAL_ID"),
    FOREIGN KEY ("EDITOR_ID") REFERENCES "EDITOR"("EDITOR_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO JOURNAL VALUES (-1, 0, 0, -1);
INSERT INTO JOURNAL VALUES (0, 0, 1, 0);
INSERT INTO EDITOR VALUES (0, 0, 0);
INSERT INTO EDITOR VALUES (-1, 0, 0);
INSERT INTO JOURNAL_COMMITTEE VALUES (0, 0, 15);
INSERT INTO JOURNAL_COMMITTEE VALUES (-1, 0, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, theme, sales FROM (SELECT * FROM journal AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.journal_id = RHS.journal_id))) ORDER BY date, theme NULLS LAST, sales NULLS LAST;

/*
Gold Result:
('0', '0', -1)
*/

-- Prediction Query
SELECT date, theme, sales FROM journal EXCEPT SELECT T1.date, T1.theme, T1.sales FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID;

/*
Prediction Result:
('0', '0', -1)
*/