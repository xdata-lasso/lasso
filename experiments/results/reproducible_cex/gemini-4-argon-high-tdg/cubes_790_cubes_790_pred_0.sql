-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Central Arena', 15, 25000.5, 375007.5, 85.2);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (2, 'North Park', 12, 18000.0, 216000.0, 72.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (3, 'South Field', 20, 40000.0, 800000.0, 95.5);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 2, 2021, '2022-10-15', 'Tigers', 'Lions', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (2, 3, 2023, '2020-05-01', 'Bears', 'Wolves', '0-0', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (3, 1, 2022, '2021-08-20', 'Eagles', 'Hawks', '3-2', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (4, 1, 2020, '2020-05-01', 'Sharks', 'Falcons', '1-4', 'Friendly');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'John Doe', 'Hamstring', '3', 'Official Report');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 2, 'Alex Smith', 'Ankle Sprain', '2', 'Press');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (3, 3, 'Sam Brown', 'Concussion', '5', 'Medical Staff');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (4, 4, 'Chris Green', 'Knee Injury', '10', 'News');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM game ORDER BY date, game.id NULLS LAST;

/*
Gold Result:
('2020-05-01',)
('2020-05-01',)
('2021-08-20',)
('2022-10-15',)
*/

-- Prediction Query
SELECT Date FROM game ORDER BY home_team DESC, game.id NULLS LAST;

/*
Prediction Result:
('2022-10-15',)
('2020-05-01',)
('2021-08-20',)
('2020-05-01',)
*/