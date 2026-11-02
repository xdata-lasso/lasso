-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journal --
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1, 'lhs_d2a02c', 'lhs_63c9ab', 1);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (-2147483647, 'lhs_6c8295', 'lhs_e19e51', 1);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (-2147483646, 'q_0_92bb3a', 'q_0_0b6c3e', 1);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (-2147483645, 'q_0_92bb3a', 'q_0_0b6c3e', 1);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (2, '5k5swwqcgs', '9n8', 1610062532);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (3, 'pgu7vfe4', 'hria2ypuzhs', 700293388);

-- Inserting into table: editor --
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (4, 'wbbp6luhvdlt', 304.02808);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (5, 'mdpos', 133.007885);

-- Inserting into table: journal_committee --
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (4, 2, 'bnp');

INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (5, 3, '5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, theme, sales FROM (SELECT * FROM journal AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.journal_id = RHS.journal_id))) ORDER BY date, theme NULLS LAST, sales NULLS LAST;

/*
Gold Result:
('lhs_6c8295', 'lhs_e19e51', 1)
('lhs_d2a02c', 'lhs_63c9ab', 1)
('q_0_92bb3a', 'q_0_0b6c3e', 1)
('q_0_92bb3a', 'q_0_0b6c3e', 1)
*/

-- Prediction Query
SELECT date, theme, sales FROM journal EXCEPT SELECT T1.date, T1.theme, T1.sales FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID;

/*
Prediction Result:
('lhs_6c8295', 'lhs_e19e51', 1)
('lhs_d2a02c', 'lhs_63c9ab', 1)
('q_0_92bb3a', 'q_0_0b6c3e', 1)
*/