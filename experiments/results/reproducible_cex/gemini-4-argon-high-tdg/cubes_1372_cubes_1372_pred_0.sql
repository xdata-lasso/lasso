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
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (4, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (5, 'Spain', 'Madrid', 'Spanish');
INSERT INTO team (Team_id, Name) VALUES (10, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (20, 'Beta');
INSERT INTO team (Team_id, Name) VALUES (30, 'Gamma');
INSERT INTO team (Team_id, Name) VALUES (40, 'Delta');
INSERT INTO team (Team_id, Name) VALUES (50, 'Epsilon');
INSERT INTO team (Team_id, Name) VALUES (60, 'Zeta');
INSERT INTO team (Team_id, Name) VALUES (70, 'Eta');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1.0, 10, 1, 'P1', 'Midfielder', 99, '2010', 'Col_LHS_1');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2.0, 20, 1, 'P2', 'Defender', 10, '2011', 'Col_Z_From_Defender_RHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (3.0, 30, 1, 'P3', 'Midfielder', 10, '2012', 'Col_A_Duplicate');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (4.0, 20, 1, 'P4', 'Forward', 10, '2013', 'Col_A_Duplicate');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (5.0, 10, 2, 'P5', 'Forward', 10, '2014', 'Decoy_Forward_LHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (6.0, 20, 2, 'P6', 'Midfielder', 10, '2015', 'Decoy_Forward_RHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (7.0, 10, 3, 'P7', 'Defender', 10, '2016', 'Decoy_Defender');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (8.0, 40, 1, 'P8', 'Midfielder', 99, '2017', 'Decoy_Country_LHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (9.0, 10, 2, 'P9', 'Midfielder', 40, '2018', 'Decoy_Country_RHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (10.0, 50, 4, 'P10', 'Midfielder', 60, '2019', 'Decoy_Team_LHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (11.0, 60, 4, 'P11', 'Midfielder', 55, '2020', 'Decoy_Team_RHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (12.0, 70, 5, 'P12', 'Midfielder', 80, '2021', 'Decoy_SameTeam_LHS');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (13.0, 70, 5, 'P13', 'Midfielder', 80, '2022', 'Decoy_SameTeam_RHS');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 10, 'P1', '2010-2015', '10-5', '5-2', '5-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "college_other" AS "college" FROM (SELECT "season", "player", "position", "country", "team", "team" AS "draft_pick_number", "draft_class", "college", "season_other", "player_other", "position_other", "team_other", "draft_class_other", "college_other" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."season" AS "season_other", "RHS"."player" AS "player_other", "RHS"."position" AS "position_other", "RHS"."team" AS "team_other", "RHS"."draft_class" AS "draft_class_other", "RHS"."college" AS "college_other" FROM "match_season" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country" = "RHS"."country" AND "LHS"."team" = "RHS"."draft_pick_number"))) WHERE ("position" = 'Midfielder' AND "position" <> 'Defender') ORDER BY college;

/*
Gold Result:
('Col_A_Duplicate',)
('Col_Z_From_Defender_RHS',)
('Decoy_Forward_LHS',)
('Decoy_Forward_RHS',)
('Decoy_Team_LHS',)
*/

-- Prediction Query
SELECT College FROM match_season WHERE POSITION = 'Midfielder' INTERSECT SELECT College FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
*/