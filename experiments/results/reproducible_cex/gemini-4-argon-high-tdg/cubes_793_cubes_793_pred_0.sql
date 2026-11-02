-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (1, 'Main Arena', 10, 25000.5, 250005.0, 85.5);
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (10, 1, 2022, '2022-05-01', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (20, 1, 2022, '2022-05-08', 'Team C', 'Team D', '0-0', 'Cup');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (1, 20, 'Zack', 'Ankle injury', '3', 'Source B');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (2, 20, 'Aaron', 'Shoulder injury', '9', 'Source Z');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (3, 10, 'Aaron', 'Knee problem', '4', 'Source M');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (4, 10, 'Aaron', 'Back trouble', '1', 'Source A');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (5, 10, 'Mike', 'Knee problem', '2', 'Source C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "number_of_matches", "source" FROM "injury_accident" WHERE ("injury" <> 'Knee problem') ORDER BY player, injury_accident.id NULLS LAST;

/*
Gold Result:
('Aaron', '9', 'Source Z')
('Aaron', '1', 'Source A')
('Zack', '3', 'Source B')
*/

-- Prediction Query
SELECT player, number_of_matches, SOURCE FROM injury_accident WHERE injury <> 'Knee problem';

/*
Prediction Result:
('Zack', '3', 'Source B')
('Aaron', '9', 'Source Z')
('Aaron', '1', 'Source A')
*/