-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Peters College', 'Adelaide', 2500.0, 1847.0, 'Presbyterian', 'Boys', 'Day & Boarding', 1920.0, 'Blue & White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Trinity Grammar', 'Melbourne', 1850.0, 1889.0, 'Anglican', 'Boys', 'Day', 1880.0, 'Green & Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Kings School', 'Sydney', 500.0, 1831.0, 'Anglican', 'Boys', 'Boarding', 1950.0, 'Sky Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Xavier College', 'Kew', 1200.0, 1878.0, 'Catholic', 'Boys', 'Day & Boarding', 1901.0, 'Red & Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'Wesley College', 'Perth', 800.0, 1890.0, 'Methodist', 'Co-ed', 'Day', 1885.0, 'Purple & Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (6, 'Concordia College', 'Highgate', 900.0, 1895.0, 'Lutheran', 'Co-ed', 'Day', 1898.0, 'Navy & Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (7, 'Carey Grammar', 'Kew', 1100.0, 1900.0, 'Baptist', 'Co-ed', 'Day', 1905.0, 'Blue & Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (8, 'Friends School', 'Hobart', 600.0, 1925.0, 'Quaker', 'Co-ed', 'Day & Boarding', 1930.0, 'Scarlet & Grey');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Saints', 'Blue', 'APS', 'A', 'Div 1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (5, 'Lions', 'Purple', 'PSA', 'A', 'Div 1');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2020', '1st', '2nd');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (1, '2021', '2nd', '1st');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (101, 1, 'John Smith', 'Varsity', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (102, 1, 'David Jones', 'Varsity', 18, 'Guard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM school WHERE (founded < 1890.0 AND founded < 1900.0) ORDER BY denomination, school.school_id NULLS LAST;

/*
Gold Result:
('Anglican',)
('Anglican',)
('Catholic',)
('Presbyterian',)
*/

-- Prediction Query
SELECT Denomination FROM school WHERE Founded < 1890 INTERSECT SELECT Denomination FROM school WHERE Founded > 1900;

/*
Prediction Result:
*/