-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1006, 'Noah Rhodes', 1010.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1007, 'Noah Rhodes', 1010.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1008, 'Noah Rhodes', 1010.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1009, 'Noah Rhodes', 1010.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1011, NULL, 1015.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1012, NULL, 1015.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1013, NULL, 1015.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1014, NULL, 1015.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
(1015.5,)
*/

-- Prediction Query
SELECT Age FROM editor GROUP BY Age ORDER BY COUNT(*) DESC, Age NULLS LAST LIMIT 1;

/*
Prediction Result:
(1010.5,)
*/