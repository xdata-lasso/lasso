-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journal (journal_id, date, theme, sales) VALUES (1, 'default1', 'default2', NULL), (0, 'default1', 'default2', 1), (2, 'default1', NULL, NULL), (3, 'default2', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM journal ORDER BY theme, journal.journal_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT Theme FROM journal;

/*
Prediction Result:
('default2',)
(None,)
*/