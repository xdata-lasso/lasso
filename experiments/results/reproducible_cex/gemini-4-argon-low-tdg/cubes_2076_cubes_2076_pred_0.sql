-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2022-05-01', 'Math', 500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2022-06-01', 'Physics', 600);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Frank', 55.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Frank', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Grace', 40.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, NULL);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 2, NULL);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 1, 'Proofread');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 2, 'Proofread');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 1, 'Layout');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.n AS n FROM editor AS LHS INNER JOIN (SELECT editor_id, COUNT(*) AS n FROM journal_committee GROUP BY editor_id) AS RHS ON (LHS.editor_id = RHS.editor_id)) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Frank',)
('Frank',)
*/

-- Prediction Query
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID = T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Frank',)
*/