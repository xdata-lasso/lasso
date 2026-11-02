-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (0, NULL, 'default1', NULL, 0.0, NULL, NULL, 'default2', 1.0, NULL), (2, NULL, 'default1', 2.0, 0.0, 'default1', 'default2', NULL, 2.0, NULL), (1, 'default2', NULL, 2.0, 1.0, NULL, 'default1', 'default1', 2.0, 'default2'), (3, 'default1', 'default1', 0.0, 1.0, 'default2', 'default1', 'default2', 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_colors FROM (SELECT * FROM (SELECT * FROM school ORDER BY day_or_boarding DESC, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT School_Colors FROM school ORDER BY Enrollment DESC, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/