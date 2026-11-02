-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO editor (editor_id, name, age) VALUES (0, 'default1', 1.0), (1, NULL, 0.0), (2, NULL, 1.0), (3, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
(None, 0.0)
(None, 1.0)
(None, None)
('default1', 1.0)
*/

-- Prediction Query
SELECT Name, Age FROM editor;

/*
Prediction Result:
('default1', 1.0)
(None, 0.0)
(None, 1.0)
(None, None)
*/