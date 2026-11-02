-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1039, 'Melissa Peterson', 1040.5, 1041.5, 'clearly', 'dinner');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1053, 'Lindsey Roman', 1054.5, 1055.5, 'show', 'machine');
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1042, 1039, 1043.5, 1044.5, 1045.5);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1049, 1039, 1050.5, 1051.5, 1052.5);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1056, 1053, 1057.5, 1058.5, 1059.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Lindsey Roman',)
('Melissa Peterson',)
('Melissa Peterson',)
*/

-- Prediction Query
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('Melissa Peterson',)
('Melissa Peterson',)
('Lindsey Roman',)
*/