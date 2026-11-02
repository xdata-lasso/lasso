-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1001, 'Allison Hill', 1002.5, 1003.5, 'dog', 'chair');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1009, 'Allison Hill', 1002.5, 1003.5, 'dog', 'chair');
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1004, 1001, 1005.5, 1006.5, 314.0);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1007, NULL, 1005.5, 1006.5, 314.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT * FROM body_builder WHERE (total < 315.0)) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY height;

/*
Gold Result:
(None,)
(1002.5,)
*/

-- Prediction Query
SELECT T2.Height FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Total < 315;

/*
Prediction Result:
(1002.5,)
*/