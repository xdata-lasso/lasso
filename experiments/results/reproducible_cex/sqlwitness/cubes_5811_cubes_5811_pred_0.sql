-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO school (school_id, school, location, enrollment, founded, denomination, boys_or_girls, day_or_boarding, year_entered_competition, school_colors) VALUES (1, 'default1', NULL, 2.0, 1.0, 'default1', NULL, 'default1', 1.0, 'default2'), (2, 'default2', NULL, 1.0, 0.0, 'default2', 'default1', 'default1', 2.0, NULL), (0, 'default2', 'default1', NULL, 0.0, 'default2', 'default1', 'default2', 0.0, 'default2'), (3, 'default1', 'default2', 1.0, 1.0, 'default1', NULL, 'default2', 2.0, 'default2'), (4, 'default2', NULL, 0.0, NULL, 'default2', NULL, 'default2', 0.0, NULL), (5, NULL, 'default1', 1.0, 2.0, 'default1', NULL, NULL, 0.0, 'default2');
INSERT INTO player (player_id, school_id, player, team, age, position) VALUES (1, 3, NULL, 'default1', 2, 'default1'), (2, 0, NULL, 'default2', NULL, NULL), (0, 1, 'default1', NULL, 2, 'default2'), (3, 2, NULL, 'default1', 1, NULL), (4, 0, 'default2', NULL, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT team, MAX(age) AS age FROM player GROUP BY team) AS RHS WHERE (LHS.team = RHS.team AND LHS.age = RHS.age))) ORDER BY team;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Team FROM player ORDER BY Age DESC, player.player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/