-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (1, 'Catholic', 'default1', NULL, 0.0, 'default2', NULL, NULL, NULL, 'default2'), (0, 'Catholic', NULL, NULL, 1.0, NULL, 'Catholic', NULL, 0.0, NULL), (2, 'default1', 'default1', 1.0, 1.0, 'default2', NULL, 'Catholic', 0.0, NULL), (3, NULL, 'default2', NULL, 0.0, 'Catholic', NULL, 'Catholic', NULL, 'Catholic'), (4, 'default2', 'default1', 0.0, 1.0, 'default2', 'default1', 'Catholic', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enrollment" FROM "school" WHERE ("denomination" <> 'Catholic') ORDER BY enrollment, school.school_id NULLS LAST;

/*
Gold Result:
(None,)
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Enrollment FROM school WHERE Denomination <> 'Catholic';

/*
Prediction Result:
(None,)
(1.0,)
(0.0,)
*/