-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (School_ID, Location) VALUES (1, 'B');
INSERT INTO school (School_ID, Location) VALUES (2, 'A');
INSERT INTO school (School_ID, Location) VALUES (3, 'A');
INSERT INTO school_details (School_ID, Nickname) VALUES (1, 'Tigers');
INSERT INTO school_details (School_ID, Nickname) VALUES (2, NULL);
INSERT INTO school_details (School_ID, Nickname) VALUES (3, 'Eagles');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, nickname FROM (SELECT LHS.school_id AS school_id, LHS.nickname AS nickname, LHS.colors AS colors, LHS.league AS league, LHS.class AS CLASS, LHS.division AS division, RHS.school AS school, RHS.location AS LOCATION, RHS.enrollment AS enrollment, RHS.founded AS founded, RHS.denomination AS denomination, RHS.boys_or_girls AS boys_or_girls, RHS.day_or_boarding AS day_or_boarding, RHS.year_entered_competition AS year_entered_competition, RHS.school_colors AS school_colors FROM school_details AS LHS INNER JOIN school AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY LOCATION, nickname NULLS LAST;

/*
Gold Result:
('A', 'Eagles')
('A', None)
('B', 'Tigers')
*/

-- Prediction Query
SELECT T1.Location, T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('B', 'Tigers')
('A', None)
('A', 'Eagles')
*/