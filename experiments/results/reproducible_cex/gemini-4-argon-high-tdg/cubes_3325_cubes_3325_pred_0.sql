-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'St. Mary High', 'Boston', 600.0, 1920.0, 'Catholic', 'Coed', 'Day', 1950.0, 'Blue and White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'Trinity Prep', 'New York', 850.0, 1890.0, 'Anglican', 'Boys', 'Boarding', 1930.0, 'Red and Gold');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'Grace Academy', 'Chicago', 300.0, 1975.0, 'Lutheran', 'Girls', 'Day', 1980.0, 'Green and Silver');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'Knox College', 'Seattle', 300.0, 1960.0, 'Presbyterian', 'Coed', 'Day', 1965.0, 'Black and Gold');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (5, 'Oakridge School', 'Austin', 450.0, 1985.0, NULL, 'Coed', 'Day', 1990.0, 'Navy and White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (6, 'First Baptist School', 'Dallas', 120.0, 2000.0, 'Baptist', 'Coed', 'Day', 2005.0, 'Maroon');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (1, 'Saints', 'Blue/White', 'Metro', 'AA', 'Div 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (2, 'Titans', 'Red/Gold', 'Colonial', 'A', 'Div 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (3, 'Eagles', 'Green/Silver', 'Midwest', 'B', 'Div 2');
INSERT INTO "school_performance" ("School_Id", "School_Year", "Class_A", "Class_AA") VALUES (1, '2020-21', '1st', '2nd');
INSERT INTO "school_performance" ("School_Id", "School_Year", "Class_A", "Class_AA") VALUES (2, '2020-21', '3rd', '1st');
INSERT INTO "school_performance" ("School_Id", "School_Year", "Class_A", "Class_AA") VALUES (2, '2021-22', '1st', '1st');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (101, 1, 'John Doe', 'Varsity', 17, 'Forward');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (102, 2, 'Alex Smith', 'Varsity', 18, 'Guard');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (103, 2, 'Sam Brown', 'JV', 15, 'Center');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enrollment" FROM "school" WHERE ("denomination" <> 'Catholic') ORDER BY enrollment, school.school_id NULLS LAST;

/*
Gold Result:
(120.0,)
(300.0,)
(300.0,)
(850.0,)
*/

-- Prediction Query
SELECT Enrollment FROM school WHERE Denomination <> 'Catholic';

/*
Prediction Result:
(850.0,)
(300.0,)
(300.0,)
(120.0,)
*/