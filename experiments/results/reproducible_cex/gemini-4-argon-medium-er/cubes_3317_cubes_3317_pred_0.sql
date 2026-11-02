-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'John', 180.0, 80.0, '1990-01-01', 'NY');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (1, 1, 100.0, 120.0, 220.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT name, total, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.people_id AS people_id_other, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS CROSS JOIN people AS RHS) WHERE (people_id = people_id_other)) GROUP BY name, total) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM people WHERE NOT people_id IN (SELECT People_ID FROM body_builder);

/*
Prediction Result:
(0,)
*/