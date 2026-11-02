-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO museum (museum_id, name, num_of_staff, open_year) VALUES (1, NULL, 0, 'Plaza Museum'), (0, 'default2', 0, 'Plaza Museum'), (2, 'default2', 0, 'Plaza Museum'), (3, 'Plaza Museum', NULL, 'default2'), (4, NULL, NULL, NULL), (5, 'default2', 0, 'default1'), (6, 'Plaza Museum', 1, 'default2'), (7, NULL, 0, 'default2'), (8, 'default1', 0, NULL), (9, NULL, 1, 'default1'), (10, 'default1', 0, NULL), (11, 'Plaza Museum', NULL, 'default2'), (12, 'Plaza Museum', 0, 'default2'), (13, 'default2', 0, 'default2'), (14, 'Plaza Museum', 0, 'default2'), (15, 'Plaza Museum', 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "num_of_staff", "open_year" FROM "museum" WHERE ("name" = 'Plaza Museum') ORDER BY num_of_staff, museum.museum_id NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, 'default2')
(0, 'default2')
(0, 'default2')
(1, 'default2')
(1, 'default1')
*/

-- Prediction Query
SELECT Num_of_Staff, Open_Year FROM museum WHERE name = 'Plaza Museum';

/*
Prediction Result:
(None, 'default2')
(1, 'default2')
(None, 'default2')
(0, 'default2')
(0, 'default2')
(1, 'default1')
*/