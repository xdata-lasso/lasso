-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Jude', 'City A', 500.0, 1950.0, 'Catholic', 'Boys', 'Day', 1960.0, 'Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'St. Mary', 'City B', 600.0, 1955.0, 'Catholic', 'Girls', 'Boarding', 1965.0, 'Red');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Grace High', 'City C', 450.0, 1970.0, 'Baptist', 'Coed', 'Day', 1975.0, 'Green');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Faith Academy', 'City D', 400.0, 1980.0, 'Baptist', 'Coed', 'Day', 1985.0, 'White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'Hope Prep', 'City E', 350.0, 1990.0, 'Baptist', 'Boys', 'Boarding', 1995.0, 'Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (6, 'Charity School', 'City F', 300.0, 2000.0, 'Baptist', 'Girls', 'Boarding', 2005.0, 'Silver');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (7, 'Trinity', 'City G', 700.0, 1910.0, 'Anglican', 'Boys', 'Boarding', 1920.0, 'Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (8, 'St. Paul', 'City H', 750.0, 1915.0, 'Anglican', 'Girls', 'Boarding', 1925.0, 'Purple');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (9, 'All Saints', 'City I', 800.0, 1920.0, 'Anglican', 'Coed', 'Boarding', 1930.0, 'Yellow');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (10, 'Zion High', 'City J', 250.0, 1985.0, 'Lutheran', 'Coed', 'Day', 1990.0, 'Orange');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
('Anglican',)
('Baptist',)
('Baptist',)
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
('Anglican',)
('Baptist',)
('Catholic',)
*/