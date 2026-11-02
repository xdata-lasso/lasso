-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 170.0, 65.0, '1990-01-01', 'NY');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT name, total, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.people_id AS people_id_other, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS CROSS JOIN people AS RHS) WHERE (people_id = people_id_other)) GROUP BY name, total) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM people WHERE NOT people_id IN (SELECT People_ID FROM body_builder);

/*
Prediction Result:
(1,)
*/