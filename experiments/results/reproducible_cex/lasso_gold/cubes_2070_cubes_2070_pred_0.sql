-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1014, 'Michele Williams', 26.0);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1015, 'Jamie Arnold', 26.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor WHERE (age > 25.0) ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Jamie Arnold',)
('Michele Williams',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE Age > 25;

/*
Prediction Result:
('Michele Williams',)
('Jamie Arnold',)
*/