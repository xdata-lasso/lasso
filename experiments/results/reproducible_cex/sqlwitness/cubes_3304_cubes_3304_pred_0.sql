-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (1, 'default1', NULL, 0.0, 'default2', 'default1'), (0, 'default2', 1.0, NULL, 'default1', 'default1'), (2, NULL, 0.0, 1.0, 'default2', NULL), (3, 'default2', NULL, 1.0, 'default1', NULL), (4, 'default1', NULL, 1.0, 'default1', 'default2'), (5, NULL, 0.0, NULL, NULL, NULL), (6, NULL, 1.0, 1.0, 'default2', 'default2'), (7, 'default2', 1.0, 0.0, 'default2', 'default1'), (8, 'default1', NULL, 0.0, 'default2', NULL), (9, NULL, 0.0, 1.0, 'default1', NULL), (10, 'default2', 0.0, 0.0, 'default2', 'default2'), (11, 'default2', NULL, 1.0, 'default1', 'default1'), (12, 'default2', 1.0, NULL, 'default1', 'default2');
INSERT INTO body_builder (body_builder_id, people_id, snatch, clean_jerk, total) VALUES (1, 9, NULL, 1.0, 1.0), (0, 0, 1.0, 0.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Total DESC, T1.body_builder_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('default2',)
(None,)
*/