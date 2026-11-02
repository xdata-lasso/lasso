-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO editor (editor_id, name, age) VALUES (0, NULL, 2.0), (3, 'default2', 2.0), (2, NULL, 0.0), (1, NULL, 2.0), (4, 'default2', 0.0), (5, NULL, 3.0), (6, 'default2', NULL);
INSERT INTO journal (journal_id, date, theme, sales) VALUES (1, 'default1', 'default1', NULL), (3, NULL, 'default1', 2), (2, 'default2', NULL, 0), (0, 'default1', NULL, NULL), (4, NULL, NULL, NULL), (5, 'default1', NULL, NULL), (6, 'default1', 'default2', 3), (7, NULL, 'default2', 0), (8, 'default1', NULL, 3), (9, 'default2', 'default2', 3);
INSERT INTO journal_committee (editor_id, journal_id, work_type) VALUES (0, 0, 'default2'), (4, 8, NULL), (5, 1, NULL), (6, 6, 'default2'), (4, 6, 'default1'), (4, 0, NULL), (2, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.n AS n FROM editor AS LHS INNER JOIN (SELECT editor_id, COUNT(*) AS n FROM journal_committee GROUP BY editor_id) AS RHS ON (LHS.editor_id = RHS.editor_id)) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID = T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('default2',)
*/