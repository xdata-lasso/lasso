-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Andrew''s College', 'Aurora', 600.0, 1899.0, 'Presbyterian', 'Boys', 'Day', 1905.0, 'Red and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Knox College', 'Toronto', 550.0, 1844.0, 'Presbyterian', 'Co-ed', 'Day', 1910.0, 'Blue and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Queen''s Prep', 'Kingston', 480.0, 1841.0, 'Presbyterian', 'Girls', 'Day', 1915.0, 'Blue, Gold and Red');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Calvin Academy', 'Hamilton', 320.0, 1920.0, 'Presbyterian', 'Co-ed', 'Day', 1925.0, 'Maroon and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'St. Michael''s', 'Toronto', 1000.0, 1852.0, 'Catholic', 'Boys', 'Boarding', 1898.0, 'Double Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (6, 'Loyola High', 'Montreal', 750.0, 1896.0, 'Catholic', 'Boys', 'Boarding', 1902.0, 'Maroon and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (7, 'Sacred Heart', 'Halifax', 400.0, 1849.0, 'Catholic', 'Girls', 'Boarding', 1912.0, 'Red and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (8, 'De La Salle', 'Toronto', 620.0, 1851.0, 'Catholic', 'Co-ed', 'Day', 1900.0, 'Oak and Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (9, 'Trinity College School', 'Port Hope', 580.0, 1865.0, 'Anglican', 'Co-ed', 'Day', 1895.0, 'Black and Red');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (10, 'Bishop Strachan', 'Toronto', 900.0, 1867.0, 'Anglican', 'Girls', 'Day', 1901.0, 'Crimson and Navy');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Saints', 'Red and White', 'CISAA', 'A', 'Div 1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (5, 'Kerry Blues', 'Double Blue', 'CISAA', 'AA', 'Div 1');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (5, '2001-02', '1st', '2nd');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (5, '2002-03', '2nd', '1st');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (1, 5, 'John Smith', 'Varsity', 17, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (2, 5, 'Mike Brown', 'Varsity', 18, 'Guard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination, n AS count___ FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) ORDER BY denomination, count___ NULLS LAST;

/*
Gold Result:
('Anglican', 2)
('Catholic', 1)
('Catholic', 3)
('Presbyterian', 4)
*/

-- Prediction Query
SELECT Denomination, COUNT(*) FROM school GROUP BY Denomination;

/*
Prediction Result:
('Anglican', 2)
('Catholic', 4)
('Presbyterian', 4)
*/