-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1008, 'Allen Robinson', 1009.5, 1010.5, 'mouth', 'kind');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1011, 'Cristian Santos', 1010.5, 1011.5, 'discussion', 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_date FROM people ORDER BY birth_date, people.people_id NULLS LAST;

/*
Gold Result:
('discussion',)
('mouth',)
*/

-- Prediction Query
SELECT Birth_Date FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('mouth',)
('discussion',)
*/