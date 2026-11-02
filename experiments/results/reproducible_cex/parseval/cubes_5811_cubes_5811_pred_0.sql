-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: school --
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 475.173408, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 749.826493, 'luhvdltti');

-- Inserting into table: player --
INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (1, 1, 'lhs_cee8d4', 'lhs_80c0cd', 1, 'lhs_31cb21');

INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (-2147483647, 1, 'lhs_3421fc', 'lhs_5a69cd', 1, 'lhs_3f68f1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT team, MAX(age) AS age FROM player GROUP BY team) AS RHS WHERE (LHS.team = RHS.team AND LHS.age = RHS.age))) ORDER BY team;

/*
Gold Result:
*/

-- Prediction Query
SELECT Team FROM player ORDER BY Age DESC, player.player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_5a69cd',)
*/