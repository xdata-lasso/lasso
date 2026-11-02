-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Canada', 'Ottawa', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Mexico', 'Mexico City', 'Spanish');
INSERT INTO team (Team_id, Name) VALUES (10, 'Lakers');
INSERT INTO team (Team_id, Name) VALUES (20, 'Bulls');
INSERT INTO team (Team_id, Name) VALUES (30, 'Celtics');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 20, 'Federer', '2000-2020', '100-10', '80-5', '20-5');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 20, 'Nadal', '2001-2022', '90-15', '70-10', '20-5');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (99, 10, 'Djokovic', '2003-2023', '110-12', '90-6', '20-6');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2020.0, 10, 1, 'LeBron', 'SF', 1, '2003', 'None');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2021.0, 20, 2, 'Nadal', 'PG', 2, '2004', 'UNC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2022.0, 10, 3, 'Kobe', 'SG', 13, '1996', 'None');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2023.0, NULL, 1, 'Shaq', 'C', 1, '1992', 'LSU');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2024.0, 10, NULL, 'Magic', 'PG', 1, '1979', 'MSU');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, player, name FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, name, player_other, years_played, total_wl, singles_wl, doubles_wl, team_other, country AS player_id FROM (SELECT LHS.season AS season, LHS.player AS player, LHS.position AS POSITION, LHS.country AS country, LHS.team AS team, LHS.draft_pick_number AS draft_pick_number, LHS.draft_class AS draft_class, LHS.college AS college, RHS.name AS name, RHS.player AS player_other, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team_other FROM match_season AS LHS INNER JOIN (SELECT LHS.team_id AS team_id, LHS.name AS name, RHS.player_id AS player_id, RHS.player AS player, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team FROM team AS LHS CROSS JOIN player AS RHS) AS RHS ON (LHS.country = RHS.player_id AND LHS.team = RHS.team_id))) ORDER BY season, player NULLS LAST, name NULLS LAST;

/*
Gold Result:
(2020.0, 'LeBron', 'Lakers')
(2021.0, 'Nadal', 'Bulls')
*/

-- Prediction Query
SELECT T1.Season, T1.Player, T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id;

/*
Prediction Result:
(2020.0, 'LeBron', 'Lakers')
(2021.0, 'Nadal', 'Bulls')
(2022.0, 'Kobe', 'Lakers')
(2024.0, 'Magic', 'Lakers')
*/