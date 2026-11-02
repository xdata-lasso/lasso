-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1106, 'Julie King', 1107, 1108.5, 1109.5, 1110.5);
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1114, 'Debra Davidson', 1115, 1116.5, 1117.5, 1118.5);
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1111, 1106, 1112, 'on', 'traditional', 'yes', 'activity', 'response');
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1119, 1114, 1120, 'brother', 'finally', 'learn', 'coach', 'long');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1113, 1111, 'set', 'building', 'rest', 'serve');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1121, 1119, 'everyone', 'seven', 'type', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "number_of_matches", "source" FROM "injury_accident" WHERE ("injury" <> 'Knee problem') ORDER BY player, injury_accident.id NULLS LAST;

/*
Gold Result:
('everyone', 'type', 'value')
('set', 'rest', 'serve')
*/

-- Prediction Query
SELECT player, number_of_matches, SOURCE FROM injury_accident WHERE injury <> 'Knee problem';

/*
Prediction Result:
('set', 'rest', 'serve')
('everyone', 'type', 'value')
*/