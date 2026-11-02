-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs OUTER JOINs, DISTINCT vs ALL (duplicate location/nickname pairs), and basic ORDER BY (LOCATION, nickname).
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'Oak High', 'Boston', 1200.0, 1950.0, 'Public', 'Coed', 'Day', 1960.0, 'Red and White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'Pine High', 'Austin', 800.0, 1975.0, 'Private', 'Boys', 'Boarding', 1980.0, 'Blue and Gold');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'Maple High', 'Boston', 950.0, 1965.0, 'Catholic', 'Girls', 'Day', 1970.0, 'Green and White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'Cedar High', 'Chicago', 1500.0, 1940.0, 'Public', 'Coed', 'Day', 1950.0, 'Black and Gold');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (5, 'Elm High', 'Austin', 800.0, 1980.0, 'Public', 'Coed', 'Day', 1985.0, 'Purple');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (1, 'Tigers', 'Red/White', 'North', 'AA', 'Div 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (2, 'Eagles', 'Blue/Gold', 'South', 'A', 'Div 2');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (3, 'Bears', 'Green/White', 'North', 'AA', 'Div 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (5, 'Eagles', 'Purple', 'South', 'A', 'Div 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, nickname FROM (SELECT LHS.school_id AS school_id, LHS.nickname AS nickname, LHS.colors AS colors, LHS.league AS league, LHS.class AS CLASS, LHS.division AS division, RHS.school AS school, RHS.location AS LOCATION, RHS.enrollment AS enrollment, RHS.founded AS founded, RHS.denomination AS denomination, RHS.boys_or_girls AS boys_or_girls, RHS.day_or_boarding AS day_or_boarding, RHS.year_entered_competition AS year_entered_competition, RHS.school_colors AS school_colors FROM school_details AS LHS INNER JOIN school AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY LOCATION, nickname NULLS LAST;

/*
Gold Result:
('Austin', 'Eagles')
('Austin', 'Eagles')
('Boston', 'Bears')
('Boston', 'Tigers')
*/

-- Prediction Query
SELECT T1.Location, T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('Boston', 'Tigers')
('Austin', 'Eagles')
('Boston', 'Bears')
('Austin', 'Eagles')
*/