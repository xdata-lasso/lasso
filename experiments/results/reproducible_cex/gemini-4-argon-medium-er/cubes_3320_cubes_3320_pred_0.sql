-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Alice', 180.0, 75.0, '1990-01-01', 'NY');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Bob', 170.0, 70.0, '1992-01-01', 'LA');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (1, 1, 100.0, 120.0, 220.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (2, 2, 110.0, 130.0, 240.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (3, NULL, 90.0, 110.0, 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT * FROM body_builder WHERE (total < 315.0)) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY height;

/*
Gold Result:
(None,)
(170.0,)
(180.0,)
*/

-- Prediction Query
SELECT T2.Height FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Total < 315;

/*
Prediction Result:
(180.0,)
(170.0,)
*/