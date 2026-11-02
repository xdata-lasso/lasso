-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (101, '2023-01-15', 'Artificial Intelligence', 1500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (102, '2023-06-20', 'Quantum Computing', 800);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Bob', 25.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Bob', 55.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (10, 'Alice', 45.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (20, 'Alice', 22.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (30, 'Charlie', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (40, 'Charlie', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (50, 'Diana', 38.25);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 101, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 102, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (10, 101, 'Lead');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Alice', 45.5)
('Alice', 22.0)
('Bob', 25.0)
('Bob', 55.0)
('Charlie', 30.0)
('Charlie', 30.0)
('Diana', 38.25)
*/

-- Prediction Query
SELECT Name, Age FROM editor;

/*
Prediction Result:
('Bob', 25.0)
('Bob', 55.0)
('Alice', 45.5)
('Alice', 22.0)
('Charlie', 30.0)
('Charlie', 30.0)
('Diana', 38.25)
*/