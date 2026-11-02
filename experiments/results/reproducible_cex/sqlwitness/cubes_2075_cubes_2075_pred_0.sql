-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO editor (editor_id, name, age) VALUES (0, 'default1', NULL), (1, 'default2', 0.0), (2, 'default2', NULL), (3, 'default2', 1.0), (4, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM editor ORDER BY Age ASC, editor.editor_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
('default2',)
('default2',)
*/