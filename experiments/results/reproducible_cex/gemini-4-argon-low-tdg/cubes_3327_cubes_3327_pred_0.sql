-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic composite GROUP BY (day_or_boarding, denomination), duplicates removal vs SELECT DISTINCT, and secondary ORDER BY on count___
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (1, 'St. Mary', 'Catholic', 'Day');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (2, 'St. Joseph', 'Catholic', 'Day');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (3, 'St. Peter', 'Catholic', 'Boarding');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (4, 'St. Paul', 'Catholic', 'Boarding');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (5, 'St. John', 'Catholic', 'Day & Boarding');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (6, 'Trinity', 'Anglican', 'Day');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (7, 'Grace', 'Anglican', 'Boarding');
INSERT INTO school (School_ID, School, Denomination, Day_or_Boarding) VALUES (8, 'Hope', 'Lutheran', 'Day');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination, n AS count___ FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) ORDER BY denomination, count___ NULLS LAST;

/*
Gold Result:
('Anglican', 1)
('Anglican', 1)
('Catholic', 1)
('Catholic', 2)
('Catholic', 2)
('Lutheran', 1)
*/

-- Prediction Query
SELECT Denomination, COUNT(*) FROM school GROUP BY Denomination ORDER BY COUNT(*) DESC, Denomination NULLS LAST;

/*
Prediction Result:
('Catholic', 5)
('Anglican', 2)
('Lutheran', 1)
*/