-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'Xavier High', 'Boston', 500.0, 1920.0, 'Catholic', 'Boys', 'Day', 1925.0, 'Blue and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Alpha Academy', 'Atlanta', 1200.0, 1980.0, 'None', 'Coed', 'Boarding', 1985.0, 'Red and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Middleton Prep', 'Chicago', 800.0, 1950.0, 'Episcopal', 'Girls', 'Day', 1960.0, 'Green and Silver');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Beta Institute', 'Atlanta', 300.0, 1890.0, 'Methodist', 'Coed', 'Day', 1900.0, 'Black and Yellow');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Eagles', 'Blue', 'Metro', 'AA', 'Div 1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (2, 'Lions', 'Red', 'Southern', 'A', 'Div 2');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2020-21', '1st', '2nd');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2021-22', '2nd', '1st');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (101, 1, 'John Doe', 'Varsity', 17, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (102, 1, 'Jake Smith', 'Varsity', 18, 'Forward');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM school ORDER BY LOCATION, school.school_id NULLS LAST;

/*
Gold Result:
('Atlanta',)
('Atlanta',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT LOCATION FROM school ORDER BY Enrollment ASC, school.school_id NULLS LAST;

/*
Prediction Result:
('Atlanta',)
('Boston',)
('Chicago',)
('Atlanta',)
*/