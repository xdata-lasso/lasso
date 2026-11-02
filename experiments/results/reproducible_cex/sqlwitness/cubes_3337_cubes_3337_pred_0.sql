-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (0, 'default2', 'default1', NULL, 1.0, 'default2', 'default2', 'default1', 1.0, NULL), (1, NULL, 'default2', 1.0, 0.0, NULL, 'default1', 'default2', 0.0, 'default2'), (2, 'default1', NULL, 0.0, NULL, 'default1', 'default2', 'default2', NULL, 'default2'), (3, 'default1', 'default1', 0.0, 1.0, 'default1', 'default1', NULL, 0.0, 'default2'), (4, 'default2', 'default2', 1.0, NULL, 'default2', 'default1', 'default2', 0.0, NULL), (5, 'default1', 'default2', 1.0, NULL, 'default1', 'default2', 'default2', NULL, NULL), (6, 'default1', 'default2', NULL, 1.0, NULL, NULL, NULL, 1.0, NULL), (7, 'default1', 'default2', NULL, 0.0, 'default1', NULL, NULL, 1.0, 'default2'), (8, 'default1', 'default1', 0.0, 1.0, 'default2', 'default2', 'default2', NULL, 'default1'), (9, 'default1', NULL, 1.0, 1.0, 'default1', 'default1', 'default1', NULL, NULL), (10, 'default2', 'default2', NULL, NULL, 'default2', 'default2', 'default2', NULL, 'default2');
INSERT INTO player (player_id, school_id, player, team, age, position) VALUES (1, 10, NULL, 'default1', 1, NULL), (0, 1, NULL, 'default1', NULL, 'default1'), (2, 9, NULL, 'default1', NULL, 'default1'), (3, 7, 'default2', 'default2', 0, 'default2'), (4, 0, 'default2', 'default2', 1, NULL), (5, 9, 'default2', 'default2', 1, NULL), (6, 0, 'default2', 'default2', 0, 'default1'), (7, 8, 'default1', 'default1', 0, 'default2'), (8, 0, NULL, 'default2', NULL, 'default1'), (9, 2, NULL, 'default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, LOCATION FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.enrollment AS enrollment, LHS.founded AS founded, LHS.denomination AS denomination, LHS.boys_or_girls AS boys_or_girls, LHS.day_or_boarding AS day_or_boarding, LHS.year_entered_competition AS year_entered_competition, LHS.school_colors AS school_colors, RHS.player_id AS player_id, RHS.player AS player, RHS.team AS team, RHS.age AS age, RHS.position AS POSITION FROM school AS LHS INNER JOIN player AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY team, LOCATION NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default1', 'default2')
('default1', 'default2')
('default1', None)
('default2', 'default1')
('default2', 'default1')
('default2', 'default1')
('default2', 'default2')
('default2', None)
('default2', None)
*/

-- Prediction Query
SELECT T1.Team, T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('default1', 'default2')
('default1', 'default2')
('default1', None)
('default2', 'default2')
('default2', 'default1')
('default2', None)
('default2', 'default1')
('default1', 'default1')
('default2', 'default1')
('default2', None)
*/