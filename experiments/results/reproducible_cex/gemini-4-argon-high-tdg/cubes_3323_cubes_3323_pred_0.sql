-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Jude', 'Chicago', 1200.0, 1920.0, 'Catholic', 'Boys', 'Day', 1925.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Oak Ridge', 'Boston', 850.0, 1950.0, 'None', 'Coed', 'Boarding', 1955.0, 'Green and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Beacon Hill', 'Boston', 600.0, 1890.0, 'Episcopal', 'Girls', 'Day', 1900.0, 'Red and Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Westside Prep', 'Austin', 450.0, 1980.0, 'None', 'Coed', 'Day', 1982.0, 'Purple and Silver');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'Unmatched Academy', 'Denver', 900.0, 1965.0, 'Lutheran', 'Coed', 'Day', 1970.0, 'Orange and Navy');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Falcons', 'Blue and White', 'Metro', 'AA', 'North');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (2, 'Zebras', 'Green and Gold', 'Coastal', 'A', 'East');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (3, 'Bears', 'Red and Black', 'Coastal', 'A', 'East');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (4, 'Wolves', 'Purple and Silver', 'Central', 'AA', 'South');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2020-21', 'Runner-up', 'Champion');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2021-22', 'Semifinalist', 'Champion');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (5, '2021-22', 'Champion', 'None');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (101, 1, 'John Doe', 'Varsity', 17, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (102, 1, 'Mike Smith', 'Varsity', 18, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (103, 5, 'Alex Brown', 'JV', 15, 'Forward');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, nickname FROM (SELECT LHS.school_id AS school_id, LHS.nickname AS nickname, LHS.colors AS colors, LHS.league AS league, LHS.class AS CLASS, LHS.division AS division, RHS.school AS school, RHS.location AS LOCATION, RHS.enrollment AS enrollment, RHS.founded AS founded, RHS.denomination AS denomination, RHS.boys_or_girls AS boys_or_girls, RHS.day_or_boarding AS day_or_boarding, RHS.year_entered_competition AS year_entered_competition, RHS.school_colors AS school_colors FROM school_details AS LHS INNER JOIN school AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY LOCATION, nickname NULLS LAST;

/*
Gold Result:
('Austin', 'Wolves')
('Boston', 'Bears')
('Boston', 'Zebras')
('Chicago', 'Falcons')
*/

-- Prediction Query
SELECT T1.Location, T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('Chicago', 'Falcons')
('Boston', 'Zebras')
('Boston', 'Bears')
('Austin', 'Wolves')
*/