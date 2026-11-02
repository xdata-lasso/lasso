-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Alpha Arena', 10, 30000.0, 300000.0, 105.5);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (2, 'Beta Bowl', 12, 25000.0, 300000.0, 100.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (3, 'Gamma Ground', 8, 15000.0, 120000.0, 110.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (4, 'Delta Dome', 15, 30000.0, 450000.0, 102.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (5, 'Epsilon Park', 20, 40000.0, 800000.0, 95.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2022, '2022-05-01', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (2, 1, 2022, '2022-05-08', 'Team A', 'Team C', '0-0', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (3, 2, 2022, '2022-05-15', 'Team D', 'Team E', '1-3', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (4, 4, 2022, '2022-05-20', 'Team F', 'Team G', '4-2', 'League');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'John Doe', 'Hamstring', '3', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 1, 'Jane Roe', 'Ankle', '1', 'Press');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT average_attendance FROM stadium WHERE (capacity_percentage > 100.0) ORDER BY average_attendance, stadium.id NULLS LAST;

/*
Gold Result:
(15000.0,)
(30000.0,)
(30000.0,)
*/

-- Prediction Query
SELECT average_attendance FROM stadium WHERE capacity_percentage > 100;

/*
Prediction Result:
(30000.0,)
(15000.0,)
(30000.0,)
*/