-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: editor --
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483648, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483647, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483646, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483645, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483644, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483643, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483642, 'edi_0d10bb', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483641, 'edi_0d10bb', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483640, 'edi_0d10bb', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483639, NULL, 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483638, NULL, 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483637, NULL, 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483636, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483635, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483634, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483633, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483632, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483631, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483630, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483629, 'edi_0d10bb', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483628, 'edi_0d10bb', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
(1.0, 3)
(1.0, 15)
*/

-- Prediction Query
SELECT Age, COUNT(*) FROM editor GROUP BY Age;

/*
Prediction Result:
(None, 3)
(1.0, 18)
*/