-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (0, NULL, 0.0, 1.0, NULL, 'default1'), (1, 'default1', 0.0, 1.0, NULL, 'default2'), (2, 'default1', 1.0, 1.0, 'default2', NULL), (3, 'default1', 1.0, 0.0, NULL, 'default1'), (4, NULL, NULL, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_date FROM people ORDER BY birth_date, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Birth_Date FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('default1',)
(None,)
(None,)
('default2',)
(None,)
*/