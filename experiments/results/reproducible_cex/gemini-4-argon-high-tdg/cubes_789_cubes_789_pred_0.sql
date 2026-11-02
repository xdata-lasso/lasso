-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (10, 'Alpha Arena', 19, 45000.5, 855009.5, 95.2);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (20, 'Beta Park', 19, 32000.0, 608000.0, 88.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (30, 'Unused Stadium', 0, 0.0, 0.0, 0.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 10, 2022, '2023-05-10', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (10, 20, 2022, '2023-05-02', 'Team C', 'Team D', '0-0', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (20, NULL, 2022, '2023-05-01', 'Team E', 'Team F', '1-3', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (30, 10, 2022, '2023-05-03', 'Team G', 'Team H', '4-2', 'Friendly');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (20, 10, 'Alice', 'Hamstring', '3', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (30, 20, 'Bob', 'Ankle Sprain', '1', 'Press');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (40, NULL, 'Charlie', 'Knee', '5', 'Medical');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, player FROM (SELECT LHS.stadium_id AS stadium_id, LHS.id AS id, LHS.season AS season, LHS.date AS date, LHS.home_team AS home_team, LHS.away_team AS away_team, LHS.score AS score, LHS.competition AS competition, RHS.id AS id_other, RHS.player AS player, RHS.injury AS injury, RHS.number_of_matches AS number_of_matches, RHS.source AS SOURCE FROM game AS LHS INNER JOIN injury_accident AS RHS ON (LHS.id = RHS.game_id)) ORDER BY date, player NULLS LAST;

/*
Gold Result:
('2023-05-01', 'Bob')
('2023-05-02', 'Alice')
*/

-- Prediction Query
SELECT T1.date, T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id ORDER BY T1.season DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('2023-05-02', 'Alice')
('2023-05-01', 'Bob')
*/