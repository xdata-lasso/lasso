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
INSERT INTO JOURNAL VALUES (-1, 0, 0, 0);
INSERT INTO JOURNAL VALUES (0, 0, 0, 0);
INSERT INTO EDITOR VALUES (1, 11, 12);
INSERT INTO EDITOR VALUES (0, 11, 13);
INSERT INTO JOURNAL_COMMITTEE VALUES (1, -1, 17);
INSERT INTO JOURNAL_COMMITTEE VALUES (0, 0, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.n AS n FROM editor AS LHS INNER JOIN (SELECT editor_id, COUNT(*) AS n FROM journal_committee GROUP BY editor_id) AS RHS ON (LHS.editor_id = RHS.editor_id)) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID = T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('11',)
*/