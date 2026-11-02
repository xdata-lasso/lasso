-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'School A', 'Loc A', 500.0, 1889.0, 'Catholic', 'Boys', 'Day', 1910.0, 'Blue');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'School B', 'Loc B', 600.0, 1890.0, 'Anglican', 'Girls', 'Boarding', 1920.0, 'Red');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'School C', 'Loc C', 700.0, 1895.0, 'Baptist', 'Coed', 'Day', 1930.0, 'Green');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'School D', 'Loc D', 800.0, 1900.0, 'Presbyterian', 'Boys', 'Boarding', 1940.0, 'Yellow');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (5, 'School E', 'Loc E', 900.0, 1905.0, 'Methodist', 'Girls', 'Day', 1950.0, 'White');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (6, 'School F', 'Loc F', 1000.0, NULL, 'Lutheran', 'Coed', 'Boarding', 1960.0, 'Black');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM school WHERE (founded < 1890.0 AND founded < 1900.0) ORDER BY denomination, school.school_id NULLS LAST;

/*
Gold Result:
('Catholic',)
*/

-- Prediction Query
SELECT Denomination FROM school WHERE Founded < 1890 INTERSECT SELECT Denomination FROM school WHERE Founded > 1900;

/*
Prediction Result:
*/