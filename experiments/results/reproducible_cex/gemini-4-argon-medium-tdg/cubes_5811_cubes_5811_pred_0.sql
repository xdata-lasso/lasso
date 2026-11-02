-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "school" ("School_ID", "School") VALUES (1, 'Oak High');
INSERT INTO "school" ("School_ID", "School") VALUES (2, 'Pine High');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (1, 1, 'Alice', 'Tigers', 20, 'G');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (2, 1, 'Bob', 'Tigers', 18, 'F');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (3, 1, 'Charlie', 'Tigers', 16, 'C');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (4, 2, 'David', 'Lions', 22, 'G');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (5, 2, 'Eve', 'Bears', 22, 'F');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (6, 2, 'Frank', 'Bears', 20, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT team, MAX(age) AS age FROM player GROUP BY team) AS RHS WHERE (LHS.team = RHS.team AND LHS.age = RHS.age))) ORDER BY team;

/*
Gold Result:
('Bears',)
('Tigers',)
('Tigers',)
*/

-- Prediction Query
SELECT Team FROM player ORDER BY Age DESC, player.player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lions',)
*/