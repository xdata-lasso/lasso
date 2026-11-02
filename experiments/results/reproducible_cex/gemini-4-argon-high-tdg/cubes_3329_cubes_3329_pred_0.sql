-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Mary High', 'Boston', 500.0, 1920.0, 'Catholic', 'Coed', 'Day', 1950.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Oak Ridge Academy', 'Austin', 800.0, 1965.0, 'None', 'Boys', 'Boarding', 1970.0, 'Black and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Pine Crest School', 'Miami', 650.0, 1934.0, 'Presbyterian', 'Girls', 'Day', 1960.0, 'Green and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Westside Prep', 'Seattle', 450.0, 1980.0, 'None', 'Coed', 'Day', 1985.0, 'Red and Silver');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'Northview High', 'Denver', 900.0, 1990.0, 'None', 'Coed', 'Day', 1995.0, 'Purple and Gold');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Eagles', 'Blue and White', 'Metro', 'AA', 'Division 1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (2, 'Zebras', 'Black and Gold', 'Central', 'A', 'Division 2');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (3, 'Bears', 'Green and White', 'Coastal', 'B', 'Division 3');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (4, 'Bears', 'Red and Silver', 'Pacific', 'C', 'Division 0');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2020', '1st', '2nd');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (2, '2020', '3rd', '4th');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (2, '2021', '1st', '1st');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (101, 1, 'John Doe', 'Varsity', 17, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (102, 2, 'Alex Smith', 'Varsity', 16, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (103, 2, 'Sam Brown', 'JV', 15, 'Center');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
('Bears',)
('Bears',)
('Zebras',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('Zebras',)
('Bears',)
('Bears',)
*/