-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Multiple tied maximum totals with identical clean_jerk (tests DISTINCT),
-- multiple tied maximum totals with different clean_jerk (tests ORDER BY ASC vs DESC vs insertion order),
-- and non-maximum rows where Snatch or Clean_Jerk is actually the highest (tests column confusion).
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Alice', 170.0, 65.0, '1990-01-01', 'CityA');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Bob', 180.0, 80.0, '1988-05-12', 'CityB');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Charlie', 175.0, 75.0, '1992-07-23', 'CityC');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Diana', 165.0, 60.0, '1995-11-30', 'CityD');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 1, 140.0, 210.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 2, 160.0, 190.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (3, 3, 140.0, 210.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (4, 4, 200.0, 250.0, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT clean_jerk FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, LHS.maxtotal AS maxtotal, RHS.body_builder_id AS body_builder_id_other, RHS.people_id AS people_id_other, RHS.snatch AS snatch_other, RHS.clean_jerk AS clean_jerk_other, RHS.total AS total_other, RHS.maxtotal AS maxtotal_other FROM (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS LHS CROSS JOIN (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS RHS) WHERE (total >= maxtotal_other OR maxtotal < total_other) ORDER BY clean_jerk;

/*
Gold Result:
(190.0,)
(210.0,)
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(210.0,)
*/