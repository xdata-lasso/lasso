-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (10, 'St. Jude', 'Zeta City', 500.0, 1920.0, 'Catholic', 'Boys', 'Day', 1950.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (20, 'Oakridge High', 'Alpha Town', 1200.0, 1985.0, 'Non-denominational', 'Co-ed', 'Boarding', 1990.0, 'Green and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (30, 'Westview Prep', 'Beta Village', 800.0, 1960.0, 'Anglican', 'Girls', 'Day', 1975.0, 'Red and Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (40, 'Ghost Academy', 'Omega Hills', 300.0, 2000.0, 'Presbyterian', 'Co-ed', 'Day', 2005.0, 'Silver');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (10, 20, 'John Doe', 'Warriors', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (20, 10, 'Alex Smith', 'Hawks', 16, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (30, 20, 'Sam Brown', 'Hawks', 18, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (40, 20, 'Chris Green', 'Hawks', 15, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (50, 30, 'Pat Taylor', ' Falcons', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (60, NULL, 'Unassigned Player', 'Lions', 19, 'Striker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, LOCATION FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.enrollment AS enrollment, LHS.founded AS founded, LHS.denomination AS denomination, LHS.boys_or_girls AS boys_or_girls, LHS.day_or_boarding AS day_or_boarding, LHS.year_entered_competition AS year_entered_competition, LHS.school_colors AS school_colors, RHS.player_id AS player_id, RHS.player AS player, RHS.team AS team, RHS.age AS age, RHS.position AS POSITION FROM school AS LHS INNER JOIN player AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY team, LOCATION NULLS LAST;

/*
Gold Result:
(' Falcons', 'Beta Village')
('Hawks', 'Alpha Town')
('Hawks', 'Alpha Town')
('Hawks', 'Zeta City')
('Warriors', 'Alpha Town')
*/

-- Prediction Query
SELECT T1.Team, T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('Warriors', 'Alpha Town')
('Hawks', 'Zeta City')
('Hawks', 'Alpha Town')
('Hawks', 'Alpha Town')
(' Falcons', 'Beta Village')
*/