-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'Alpha High', 'Austin', 100.0, 1800.0, 'Anglican', 'Boys', 'Boarding', 1900.0, 'Amber');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (10, 'Beta Prep', 'Boston', 500.0, 1900.0, 'Baptist', 'Coed', 'Day', 1950.0, 'Crimson');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (20, 'Gamma Academy', 'Chicago', 300.0, 1850.0, 'Catholic', 'Girls', 'Day', 1920.0, 'Emerald');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (30, 'Delta College', 'Denver', 900.0, 2000.0, 'Lutheran', 'Girls', 'Boarding', 2010.0, 'Violet');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (5, 'Aces', 'Gold', 'North', 'A', 'Div 1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (20, 'Gators', 'Green', 'South', 'AA', 'Div 2');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (30, 'Dragons', 'Purple', 'West', 'A', 'Div 1');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (5, '2020', '1st', '2nd');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (20, '2020', '2nd', '1st');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (30, '2020', '3rd', '3rd');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (1, 5, 'John Doe', 'Varsity', 16, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (2, 20, 'Jane Roe', 'Varsity', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (3, 30, 'Sam Smith', 'JV', 15, 'Center');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_colors FROM (SELECT * FROM (SELECT * FROM school ORDER BY day_or_boarding DESC, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Crimson',)
*/

-- Prediction Query
SELECT School_Colors FROM school ORDER BY Enrollment DESC, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Violet',)
*/