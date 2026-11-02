-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary conditions (29, 30, 31), duplicates, NULLs, and foreign key join mutations.
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (1, 'Modern Art', 20, '2000');
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (1, 'Alice', 1, 29);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (2, 'Bob', 2, 30);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (3, 'Bob', 2, 30);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (4, 'Charlie', 3, 31);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (5, 'Diana', 1, 40);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (6, 'Eve', 1, NULL);
INSERT INTO "visit" ("Museum_ID", "visitor_ID", "Num_of_Ticket", "Total_spent") VALUES (1, '2', 2, 50.0);
INSERT INTO "visit" ("Museum_ID", "visitor_ID", "Num_of_Ticket", "Total_spent") VALUES (1, '4', 1, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM visitor WHERE (age >= 30))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM visitor WHERE age < 30;

/*
Prediction Result:
(1,)
*/