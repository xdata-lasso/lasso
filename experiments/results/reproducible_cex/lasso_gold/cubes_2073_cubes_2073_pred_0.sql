-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1015, 'James Howard', 1016.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1017, 'Caitlin Henderson', 1017.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM editor AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.editor_id = RHS.editor_id))) ORDER BY name;

/*
Gold Result:
('Caitlin Henderson',)
('James Howard',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE NOT editor_id IN (SELECT editor_id FROM journal_committee);

/*
Prediction Result:
('James Howard',)
('Caitlin Henderson',)
*/