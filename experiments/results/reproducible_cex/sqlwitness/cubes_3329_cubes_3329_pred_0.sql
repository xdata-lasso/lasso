-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (0, 'default1', 'default2', 0.0, 1.0, 'default2', 'default1', 'Division 1', 1.0, 'default2'), (1, 'default1', 'Division 1', NULL, 0.0, NULL, 'default2', 'default2', NULL, NULL), (2, 'default1', 'default1', NULL, 1.0, NULL, 'Division 1', 'default1', 0.0, NULL), (3, 'Division 1', 'default2', NULL, 1.0, NULL, NULL, 'Division 1', NULL, 'default1'), (4, 'default1', 'Division 1', NULL, NULL, 'Division 1', NULL, NULL, 0.0, 'default1'), (5, NULL, NULL, NULL, 0.0, 'default1', 'default1', 'default2', 0.0, 'default1'), (6, 'Division 1', NULL, 0.0, NULL, 'default2', 'Division 1', NULL, 1.0, 'default2'), (7, NULL, 'default1', NULL, 1.0, NULL, NULL, 'Division 1', 0.0, 'default2'), (8, 'Division 1', 'default2', NULL, NULL, 'default1', NULL, 'Division 1', 0.0, 'default1');
INSERT INTO school_details (school_id, nickname, colors, league, class, division) VALUES (1, 'default1', NULL, 'Division 1', 'default1', NULL), (7, NULL, 'default1', 'Division 1', 'Division 1', 'Division 1'), (4, 'default2', 'default2', 'Division 1', 'default1', 'default1'), (3, 'default1', 'default1', 'Division 1', 'default2', NULL), (2, NULL, 'Division 1', NULL, NULL, NULL), (6, 'default2', NULL, 'default2', 'default1', 'Division 1'), (0, 'default2', 'default2', 'default2', 'default1', NULL), (5, 'Division 1', 'Division 1', NULL, 'default2', 'Division 1'), (8, NULL, 'default2', NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('default2',)
(None,)
*/