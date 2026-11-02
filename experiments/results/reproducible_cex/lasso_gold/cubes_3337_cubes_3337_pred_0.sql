-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1070, 'cover', '78108 Tanya Terrace
East Richard, NJ 28517', 1071.5, 1072.5, 'Tonga', 'institution', 'weight', 1073.5, 'artist');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1076, 'in', '93990 Robert Prairie Suite 435
West Randy, TN 85108', 1077.5, 1078.5, 'Malawi', 'be', 'today', 1079.5, 'cultural');
INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (1074, 1070, 'authority', 'hundred', 1075, 'able');
INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (1080, 1076, 'community', 'Republican', 1076, 'author');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, LOCATION FROM (SELECT LHS.school_id AS school_id, LHS.school AS school, LHS.location AS LOCATION, LHS.enrollment AS enrollment, LHS.founded AS founded, LHS.denomination AS denomination, LHS.boys_or_girls AS boys_or_girls, LHS.day_or_boarding AS day_or_boarding, LHS.year_entered_competition AS year_entered_competition, LHS.school_colors AS school_colors, RHS.player_id AS player_id, RHS.player AS player, RHS.team AS team, RHS.age AS age, RHS.position AS POSITION FROM school AS LHS INNER JOIN player AS RHS ON (LHS.school_id = RHS.school_id)) ORDER BY team, LOCATION NULLS LAST;

/*
Gold Result:
('Republican', '93990 Robert Prairie Suite 435\nWest Randy, TN 85108')
('hundred', '78108 Tanya Terrace\nEast Richard, NJ 28517')
*/

-- Prediction Query
SELECT T1.Team, T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID = T2.School_ID;

/*
Prediction Result:
('hundred', '78108 Tanya Terrace\nEast Richard, NJ 28517')
('Republican', '93990 Robert Prairie Suite 435\nWest Randy, TN 85108')
*/