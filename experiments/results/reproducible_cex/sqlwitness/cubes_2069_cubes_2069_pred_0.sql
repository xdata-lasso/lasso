-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO editor (editor_id, name, age) VALUES (0, 'default2', 25.0), (26, 'default2', 1.0), (1, 'default1', 24.0), (25, 'default1', 0.0), (24, 'default2', 23.0), (23, 'default1', 24.0), (2, NULL, 23.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor WHERE (age >= 24.0 AND age <= 25.0) ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE Age = 24 OR Age = 25;

/*
Prediction Result:
('default2',)
('default1',)
('default1',)
*/