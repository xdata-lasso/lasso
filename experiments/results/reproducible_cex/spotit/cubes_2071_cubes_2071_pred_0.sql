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
INSERT INTO JOURNAL VALUES (0, 9, NULL, 3000);
INSERT INTO JOURNAL VALUES (1, 12, 13, 3000);
INSERT INTO EDITOR VALUES (1, 37, 38);
INSERT INTO EDITOR VALUES (0, -1, 40);
INSERT INTO JOURNAL_COMMITTEE VALUES (0, 0, 36);
INSERT INTO JOURNAL_COMMITTEE VALUES (0, 1, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, LHS.journal_id AS journal_id, LHS.work_type AS work_type, RHS.date AS date, RHS.theme AS theme, RHS.sales AS sales FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.journal_id AS journal_id, RHS.work_type AS work_type FROM editor AS LHS INNER JOIN journal_committee AS RHS ON (LHS.editor_id = RHS.editor_id)) AS LHS INNER JOIN (SELECT * FROM journal WHERE (sales >= 3000)) AS RHS ON (LHS.journal_id = RHS.journal_id)) ORDER BY name;

/*
Gold Result:
('-1',)
('-1',)
*/

-- Prediction Query
SELECT T2.Name FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID WHERE T3.Sales > 3000;

/*
Prediction Result:
*/