-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'Oakridge High', 'Westview', 1200.0, 1950.0, 'Public', 'Co-ed', 'Boarding', 1960.0, 'Red and White');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Pinecrest Academy', 'Eastside', 800.0, 1920.0, 'Private', 'Boys', 'Day', 1930.0, 'Blue and Gold');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Maple Leaf School', 'Northgate', 950.0, 1980.0, 'Catholic', 'Girls', 'Day and Boarding', 1985.0, 'Green and Silver');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Oaks', 'Crimson', 'North', 'A', '1');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (2, 'Pines', 'Navy', 'South', 'AA', '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_colors FROM (SELECT * FROM (SELECT * FROM school ORDER BY day_or_boarding DESC, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Green and Silver',)
*/

-- Prediction Query
SELECT School_Colors FROM school ORDER BY Enrollment DESC, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Red and White',)
*/