-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (101, '2023-01-15', 'Artificial Intelligence', 1500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (102, '2023-06-20', 'Database Systems', 800);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Charlie', 40.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 25.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Bob', 35.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'Alice', 50.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 101, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 102, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 101, 'Lead');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM editor ORDER BY Age ASC, editor.editor_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('Alice',)
*/