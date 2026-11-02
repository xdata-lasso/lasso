-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (2, 'default2', 0.0, 0.0, 'default1', NULL), (0, 'default2', 1.0, NULL, 'default1', NULL), (1, 'default2', 2.0, NULL, 'default1', 'default1'), (3, 'default2', 0.0, 0.0, 'default2', NULL), (4, NULL, 1.0, NULL, 'default2', 'default2');
INSERT INTO body_builder (body_builder_id, people_id, snatch, clean_jerk, total) VALUES (2, 3, NULL, 2.0, 1.0), (0, NULL, NULL, 1.0, 0.0), (1, 3, 1.0, NULL, 0.0), (3, 0, 2.0, 0.0, NULL), (4, 0, 2.0, 1.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, birth_place FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM body_builder AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name, birth_place NULLS LAST;

/*
Gold Result:
(None, 'default2')
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT Name, birth_place FROM people EXCEPT SELECT T1.Name, T1.birth_place FROM people AS T1 JOIN body_builder AS T2 ON T1.people_id = T2.people_id;

/*
Prediction Result:
(None, 'default2')
('default2', 'default1')
*/