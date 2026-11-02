-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (1, 'default2', NULL, 1.0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT LHS.birth_date AS birth_date, LHS.birth_place AS birth_place, LHS.n AS n, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_place AS birth_place_other FROM (SELECT birth_date, birth_place, COUNT(*) AS n FROM people GROUP BY birth_date, birth_place) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.birth_date = RHS.birth_date)) ORDER BY birth_place;

/*
Gold Result:
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/