-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: editor --
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483648, '5k5swwqcgs', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483647, '9n8', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483646, '4', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (2, 'gu7v', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (3, 'e4', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483645, 'hria2ypuzhs', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483642, 'rwbbp6luhvd', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483641, 'tti', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483640, 'bnp', 3.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483639, 'mdpos', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483638, 'ie5', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483637, 'nw6klf', 3.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483636, 'a9000t5c4eci', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483635, 'gce376nium52', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483634, 'zbuo4nrqrof', 3.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483633, 'qyp5s5bbp0', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483632, '2eutliqa11r', 2.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483631, 'ytoo3o9', 3.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483630, 'l7', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483629, 'klex14ji', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483628, '7zwau2dwyr', NULL);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483627, '13pyu', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483626, '8d99rljsl', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483625, 'b4yp5qi', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT Age FROM editor GROUP BY Age ORDER BY COUNT(*) DESC, Age NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/