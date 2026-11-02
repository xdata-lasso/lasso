-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'David Miller', 182.0, 90.0, '1985-03-10', 'Seattle');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Eva Green', 165.0, 65.0, '1995-07-22', 'Miami');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Frank White', 178.0, 88.0, '1991-09-14', 'Denver');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Grace Hall', 172.0, 72.0, '1993-12-01', 'Austin');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 1, 140.0, 210.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 2, 160.0, 190.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (3, 3, 150.0, 200.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (4, 4, 130.0, 170.0, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT clean_jerk FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, LHS.maxtotal AS maxtotal, RHS.body_builder_id AS body_builder_id_other, RHS.people_id AS people_id_other, RHS.snatch AS snatch_other, RHS.clean_jerk AS clean_jerk_other, RHS.total AS total_other, RHS.maxtotal AS maxtotal_other FROM (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS LHS CROSS JOIN (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS RHS) WHERE (total >= maxtotal_other OR maxtotal < total_other) ORDER BY clean_jerk;

/*
Gold Result:
(190.0,)
(200.0,)
(210.0,)
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(210.0,)
*/