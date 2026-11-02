-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1001, 'purpose', '32181 Johnson Course Apt. 389
New Jamesside, MT 29394', 1002.5, 0.0, 'Kiribati', 'perform', 'fall', 1003.5, 'table');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM school WHERE (founded < 1890.0 AND founded < 1900.0) ORDER BY denomination, school.school_id NULLS LAST;

/*
Gold Result:
('Kiribati',)
*/

-- Prediction Query
SELECT Denomination FROM school WHERE Founded < 1890 INTERSECT SELECT Denomination FROM school WHERE Founded > 1900;

/*
Prediction Result:
*/