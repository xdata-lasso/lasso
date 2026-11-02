-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (2, NULL, NULL, 2.0, NULL, 'default2', 'default1', 'default2', 1.0, 'default1'), (0, NULL, NULL, 2.0, NULL, NULL, 'default1', 'default2', NULL, 'default2'), (1, 'default2', NULL, 1.0, 2.0, NULL, 'default1', 'default2', 2.0, NULL), (3, 'default2', 'default1', NULL, 2.0, NULL, NULL, 'default2', NULL, NULL), (4, 'default2', 'default2', NULL, 1.0, 'default1', NULL, 'default2', 0.0, NULL), (5, NULL, NULL, 0.0, 0.0, 'default1', 'default1', 'default1', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('default1',)
*/