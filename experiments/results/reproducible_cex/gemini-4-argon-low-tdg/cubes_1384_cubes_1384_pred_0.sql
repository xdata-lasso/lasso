-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'Spain', 'Madrid', 'Spanish');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'France', 'Paris', 'French');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (99, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO team (Team_id, Name) VALUES (10, 'Lions');
INSERT INTO team (Team_id, Name) VALUES (20, 'Tigers');
INSERT INTO team (Team_id, Name) VALUES (30, 'Bears');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 10, 'P_One', '1', '1-0', '1-0', '0-0');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 20, 'P_Two', '2', '2-0', '2-0', '0-0');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (3, 30, 'P_Three', '3', '3-0', '3-0', '0-0');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2010.0, 10, 1, 'Valid_Match', 'Center', 1, '2010', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2011.0, 10, 99, 'Unmatched_Country_PlayerID', 'Forward', 2, '2011', 'USC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2012.0, NULL, 2, 'Null_Team', 'Guard', 3, '2012', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2013.0, 20, NULL, 'Null_Country', 'Guard', 4, '2013', 'Cal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, player, name FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, name, player_other, years_played, total_wl, singles_wl, doubles_wl, team_other, country AS player_id FROM (SELECT LHS.season AS season, LHS.player AS player, LHS.position AS POSITION, LHS.country AS country, LHS.team AS team, LHS.draft_pick_number AS draft_pick_number, LHS.draft_class AS draft_class, LHS.college AS college, RHS.name AS name, RHS.player AS player_other, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team_other FROM match_season AS LHS INNER JOIN (SELECT LHS.team_id AS team_id, LHS.name AS name, RHS.player_id AS player_id, RHS.player AS player, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team FROM team AS LHS CROSS JOIN player AS RHS) AS RHS ON (LHS.country = RHS.player_id AND LHS.team = RHS.team_id))) ORDER BY season, player NULLS LAST, name NULLS LAST;

/*
Gold Result:
(2010.0, 'Valid_Match', 'Lions')
*/

-- Prediction Query
SELECT T1.Season, T1.Player, T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id;

/*
Prediction Result:
(2010.0, 'Valid_Match', 'Lions')
(2011.0, 'Unmatched_Country_PlayerID', 'Lions')
(2013.0, 'Null_Country', 'Tigers')
*/