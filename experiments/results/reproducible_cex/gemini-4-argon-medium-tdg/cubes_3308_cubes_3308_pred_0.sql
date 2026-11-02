-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for Total (> 300.0 vs = 300.0 vs < 300.0), ORDER BY Name (insert order vs alphabetical), and unreferenced People rows (to kill RIGHT/FULL JOIN mutants).
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Zack', 180.0, 90.0, '1990-01-01', 'NY');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Alice', 165.0, 60.0, '1992-05-10', 'LA');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Bob', 175.0, 80.0, '1988-03-15', 'SF');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'Charlie', 170.0, 75.0, '1995-07-20', 'TX');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (10, 1, 150.0, 160.0, 310.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (20, 2, 140.0, 160.0, 300.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (30, 3, 140.5, 160.0, 300.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT * FROM body_builder WHERE (total > 300.0)) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Total > 300;

/*
Prediction Result:
('Zack',)
('Bob',)
*/