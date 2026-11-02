-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO editor (editor_id, name, age) VALUES (1, 'default2', 26.0), (0, 'default1', 1.0), (26, NULL, 24.0), (25, NULL, NULL), (24, 'default1', 1.0), (2, 'default2', 1.0), (3, 'default1', 24.0), (4, NULL, 25.0), (5, 'default1', 0.0), (6, 'default1', 25.0), (7, 'default2', 26.0), (8, NULL, 26.0), (9, 'default1', 0.0), (10, NULL, 26.0), (11, 'default1', 26.0), (12, NULL, 1.0), (13, 'default1', 25.0), (14, 'default1', 0.0), (15, 'default2', NULL), (16, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor WHERE (age > 25.0) ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE Age > 25;

/*
Prediction Result:
('default2',)
('default2',)
(None,)
(None,)
('default1',)
*/