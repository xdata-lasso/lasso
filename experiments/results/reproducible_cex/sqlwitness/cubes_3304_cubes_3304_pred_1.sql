-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (0, 'default1', 0.0, NULL, 'default1', 'default2'), (1, 'default1', NULL, 1.0, NULL, NULL), (2, NULL, 0.0, NULL, 'default2', 'default2'), (3, 'default2', 0.0, 0.0, 'default1', NULL), (4, 'default1', 0.0, NULL, NULL, NULL);
INSERT INTO body_builder (body_builder_id, people_id, snatch, clean_jerk, total) VALUES (1, 3, 1.0, 0.0, 0.0), (0, 4, 0.0, 1.0, NULL), (2, 1, NULL, NULL, 0.0), (3, NULL, 0.0, 1.0, 0.0), (4, 1, 0.0, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
('default1',)
*/