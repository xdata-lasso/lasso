-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (1, 'Alice', 170.0, 65.0, '1990-01-01', 'New York');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (2, 'Bob', 180.0, 85.0, '1988-05-12', 'Chicago');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (3, 'Charlie', 175.0, 78.0, '1992-09-23', 'Boston');
INSERT INTO people (People_ID, Name, Height, Weight, Birth_Date, Birth_Place) VALUES (4, 'Diana', 165.0, 60.0, '1995-03-15', 'Seattle');
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (10, 1, 120.0, 190.0, 310.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (20, 2, 160.0, 175.0, 335.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (30, 3, 140.0, 210.0, 350.0);
INSERT INTO body_builder (Body_Builder_ID, People_ID, Snatch, Clean_Jerk, Total) VALUES (40, 4, NULL, 220.0, 220.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clean_jerk FROM (SELECT * FROM (SELECT * FROM body_builder ORDER BY snatch DESC, body_builder.body_builder_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(175.0,)
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(210.0,)
*/