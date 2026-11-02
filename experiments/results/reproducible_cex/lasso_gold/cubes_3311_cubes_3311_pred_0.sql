-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1013, 'Cristian Santos', 1014.5, 1015.5, 'offer', 'kind');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1016, 'Cristian Santos', 1014.5, 1015.5, 'offer', 'kind');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, birth_place FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM body_builder AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name, birth_place NULLS LAST;

/*
Gold Result:
('Cristian Santos', 'kind')
('Cristian Santos', 'kind')
*/

-- Prediction Query
SELECT Name, birth_place FROM people EXCEPT SELECT T1.Name, T1.birth_place FROM people AS T1 JOIN body_builder AS T2 ON T1.people_id = T2.people_id;

/*
Prediction Result:
('Cristian Santos', 'kind')
*/