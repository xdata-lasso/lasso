-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Olaf Academy', 'Northfield', 500.0, 1874.0, 'Lutheran', 'Boys', 'Boarding', 1900.0, 'Black and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Concordia High', 'Moorhead', 600.0, 1891.0, 'Lutheran', 'Girls', 'Boarding', 1910.0, 'Maroon and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Luther Prep', 'Watertown', 450.0, 1865.0, 'Lutheran', 'Coed', 'Boarding', 1920.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (4, 'Trinity Grammar', 'Kew', 800.0, 1902.0, 'Anglican', 'Boys', 'Day', 1925.0, 'Green and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (5, 'St. Catherine School', 'Toorak', 700.0, 1896.0, 'Anglican', 'Girls', 'Day', 1930.0, 'Blue and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (6, 'Xavier College', 'Melbourne', 1100.0, 1878.0, 'Catholic', 'Boys', 'Day', 1901.0, 'Red and Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (7, 'Loreto Hall', 'Sydney', 950.0, 1892.0, 'Catholic', 'Girls', 'Day', 1915.0, 'Blue and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (8, 'Aquinas Institute', 'Rochester', 750.0, 1902.0, 'Catholic', 'Coed', 'Day', 1935.0, 'Maroon and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (9, 'St. Ignatius Prep', 'Chicago', 1200.0, 1870.0, 'Catholic', 'Boys', 'Day', 1905.0, 'Crimson and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (10, 'Wesley College', 'Prahran', 1500.0, 1866.0, 'Methodist', 'Coed', 'Day', 1899.0, 'Purple and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (11, 'Kingswood School', 'Bath', 650.0, 1748.0, 'Methodist', 'Coed', 'Boarding', 1890.0, 'Red and Black');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (12, 'Carey Grammar', 'Camberwell', 1300.0, 1923.0, 'Baptist', 'Coed', 'Boarding', 1940.0, 'Blue and Gold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
('Anglican',)
('Catholic',)
('Lutheran',)
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
('Anglican',)
('Catholic',)
('Lutheran',)
('Methodist',)
*/