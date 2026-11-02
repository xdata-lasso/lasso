-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'Oak High', 'Boston', 1200.0, 1950.0, 'None', 'Coed', 'Day', 1960.0, 'Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Pine Academy', 'Austin', 800.0, 1980.0, 'Catholic', 'Boys', 'Boarding', 1985.0, 'Green');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Maple Prep', 'Chicago', 500.0, 2000.0, 'Private', 'Girls', 'Day', 2005.0, 'Red');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (1, 1, 'John', 'Tigers', 16, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (2, 1, 'Mike', 'Tigers', 17, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (3, 2, 'Alex', 'Eagles', 15, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (4, NULL, 'Sam', 'Lions', 18, 'Forward');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, LOCATION FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.enrollment AS enrollment, LHS.founded AS founded, LHS.denomination AS denomination, LHS.boys_or_girls AS boys_or_girls, LHS.day_or_boarding AS day_or_boarding, LHS.year_entered_competition AS year_entered_competition, LHS.school_colors AS school_colors, RHS.player_id AS player_id, RHS.player AS player, RHS.team AS team, RHS.age AS age, RHS.position AS POSITION FROM school AS LHS INNER JOIN player AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY team, LOCATION NULLS LAST;

/*
Gold Result:
('Eagles', 'Austin')
('Tigers', 'Boston')
('Tigers', 'Boston')
*/

-- Prediction Query
SELECT T1.Team, T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('Tigers', 'Boston')
('Tigers', 'Boston')
('Eagles', 'Austin')
*/