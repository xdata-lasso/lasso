-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("School_ID", "Enrollment", "Day_or_Boarding", "School_Colors") VALUES (1, 100.0, 'Day', 'Red');
INSERT INTO "school" ("School_ID", "Enrollment", "Day_or_Boarding", "School_Colors") VALUES (2, 200.0, 'Boarding', 'Blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_colors FROM (SELECT * FROM (SELECT * FROM school ORDER BY day_or_boarding DESC, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Red',)
*/

-- Prediction Query
SELECT School_Colors FROM school ORDER BY Enrollment DESC, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Blue',)
*/