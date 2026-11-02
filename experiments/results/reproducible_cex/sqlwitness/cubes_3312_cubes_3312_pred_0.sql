-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, birth_date, birth_place) VALUES (0, 'default1', 0.0, NULL, 'default1', 'default1'), (1, 'default2', 1.0, NULL, NULL, 'default1');
INSERT INTO body_builder (body_builder_id, people_id, snatch, clean_jerk, total) VALUES (1, NULL, 0.0, 0.0, 0.0), (0, NULL, 0.0, 1.0, 1.0), (2, NULL, NULL, 0.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT body_builder_id, people_id, snatch, clean_jerk, total FROM body_builder ORDER BY body_builder_id;

/*
Gold Result:
(0, None, 0.0, 1.0, 1.0)
(1, None, 0.0, 0.0, 0.0)
(2, None, None, 0.0, 0.0)
*/

-- Prediction Query
SELECT * FROM body_builder;

/*
Prediction Result:
(0, None, 0.0, 1.0, 1.0)
(1, None, 0.0, 0.0, 0.0)
(2, None, None, 0.0, 0.0)
*/