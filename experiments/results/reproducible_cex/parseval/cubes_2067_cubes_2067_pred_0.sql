-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journal --
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1, '5k5swwqcgs', 'jou_3904f1', 247012447);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (-2147483647, '8c4pgu7vfe', 'jou_3904f1', -1633151678);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (2, 'a2y', NULL, 1115440883);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM journal ORDER BY theme, journal.journal_id NULLS LAST;

/*
Gold Result:
(None,)
('jou_3904f1',)
('jou_3904f1',)
*/

-- Prediction Query
SELECT DISTINCT Theme FROM journal;

/*
Prediction Result:
('jou_3904f1',)
(None,)
*/