-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'Oakridge High', 'Boston', 1200.0, 1950.0, 'None', 'Coed', 'Day', 1960.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'St. Marys', 'Boston', 850.0, 1920.0, 'Catholic', 'Girls', 'Boarding', 1930.0, 'Red and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Pinecrest Academy', 'Austin', 1500.0, 1985.0, 'None', 'Coed', 'Day', 1990.0, 'Green and Silver');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Westview Prep', 'Chicago', 600.0, 2000.0, 'Lutheran', 'Boys', 'Day', 2005.0, 'Black and Yellow');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Oaks', 'Blue/White', 'Metro', 'AA', 'North');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (2, 'Saints', 'Red/Gold', 'Catholic', 'A', 'East');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2020-2021', 'Runner-up', 'Champion');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2021-2022', 'Semi-finalist', 'Champion');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (3, '2020-2021', 'Champion', 'None');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (101, 1, 'John Doe', 'Varsity', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (102, 1, 'Jake Smith', 'JV', 15, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (103, 2, 'Sarah Connor', 'Varsity', 18, 'Center');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM school ORDER BY LOCATION, school.school_id NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT LOCATION FROM school ORDER BY Enrollment ASC, school.school_id NULLS LAST;

/*
Prediction Result:
('Chicago',)
('Boston',)
('Boston',)
('Austin',)
*/