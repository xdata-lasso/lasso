-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping by both Day_or_Boarding and Denomination, duplicate counts across different Day_or_Boarding values (kills SELECT DISTINCT), and ordering by Denomination then count___ (inserted out of order to kill unordered or DESC mutants).
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'St. Jude', 'City A', 500.0, 1950.0, 'Catholic', 'Boys', 'Day', 1960.0, 'Blue');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'St. Mary', 'City B', 600.0, 1960.0, 'Catholic', 'Girls', 'Day', 1970.0, 'White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'St. Peter', 'City C', 450.0, 1940.0, 'Catholic', 'Boys', 'Day', 1955.0, 'Red');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'Holy Cross', 'City D', 300.0, 1920.0, 'Catholic', 'Co-ed', 'Boarding', 1930.0, 'Green');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (5, 'Trinity', 'City E', 700.0, 1910.0, 'Anglican', 'Boys', 'Boarding', 1925.0, 'Gold');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (6, 'Grace', 'City F', 650.0, 1915.0, 'Anglican', 'Girls', 'Boarding', 1928.0, 'Silver');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (7, 'All Saints', 'City G', 400.0, 1980.0, 'Anglican', 'Co-ed', 'Day', 1985.0, 'Black');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (8, 'St. Paul', 'City H', 550.0, 1975.0, 'Anglican', 'Co-ed', 'Day', 1980.0, 'Purple');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (9, 'King School', 'City I', 800.0, 1900.0, 'Anglican', 'Boys', 'Day & Boarding', 1910.0, 'Navy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination, n AS count___ FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) ORDER BY denomination, count___ NULLS LAST;

/*
Gold Result:
('Anglican', 1)
('Anglican', 2)
('Anglican', 2)
('Catholic', 1)
('Catholic', 3)
*/

-- Prediction Query
SELECT Denomination, COUNT(*) FROM school GROUP BY Denomination;

/*
Prediction Result:
('Anglican', 5)
('Catholic', 4)
*/