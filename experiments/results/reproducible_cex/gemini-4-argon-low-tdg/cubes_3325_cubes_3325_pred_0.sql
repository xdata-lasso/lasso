-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filter (<> 'Catholic'), duplicate preservation (SELECT vs SELECT DISTINCT), and numerical sorting on Enrollment.
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'St. Mary', 'East', 500.0, 1920.0, 'Catholic', 'Boys', 'Day', 1950.0, 'Blue and White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'Oak High', 'West', 1200.5, 1950.0, 'Public', 'Coed', 'Day', 1960.0, 'Green');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'Grace Academy', 'North', 300.0, 1980.0, 'Baptist', 'Coed', 'Day', 1985.0, 'Red');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'Pine Prep', 'South', 300.0, 1990.0, 'Lutheran', 'Girls', 'Boarding', 1995.0, 'Yellow');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enrollment" FROM "school" WHERE ("denomination" <> 'Catholic') ORDER BY enrollment, school.school_id NULLS LAST;

/*
Gold Result:
(300.0,)
(300.0,)
(1200.5,)
*/

-- Prediction Query
SELECT Enrollment FROM school WHERE Denomination <> 'Catholic';

/*
Prediction Result:
(1200.5,)
(300.0,)
(300.0,)
*/