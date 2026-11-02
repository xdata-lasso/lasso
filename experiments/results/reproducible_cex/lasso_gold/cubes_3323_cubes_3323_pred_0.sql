-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1023, 'about', 'USNV Stanton
FPO AE 67043', 1024.5, 1025.5, 'United States Minor Outlying Islands', 'born', 'truth', 1026.5, 'process');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (1023, 'Mark Lynch', 'claim', 'hour', 'sound', 'color');
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (1033, 'Mark Lynch', 'claim', 'hour', 'sound', 'color');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, nickname FROM (SELECT LHS.school_id AS school_id, LHS.nickname AS nickname, LHS.colors AS colors, LHS.league AS league, LHS.class AS CLASS, LHS.division AS division, RHS.school AS school, RHS.location AS LOCATION, RHS.enrollment AS enrollment, RHS.founded AS founded, RHS.denomination AS denomination, RHS.boys_or_girls AS boys_or_girls, RHS.day_or_boarding AS day_or_boarding, RHS.year_entered_competition AS year_entered_competition, RHS.school_colors AS school_colors FROM school_details AS LHS INNER JOIN school AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY LOCATION, nickname NULLS LAST;

/*
Gold Result:
(None, 'Mark Lynch')
('USNV Stanton\nFPO AE 67043', 'Mark Lynch')
*/

-- Prediction Query
SELECT T1.Location, T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('USNV Stanton\nFPO AE 67043', 'Mark Lynch')
(None, 'Mark Lynch')
*/