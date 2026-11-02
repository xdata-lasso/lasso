-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO team (Team_id, Name) VALUES (10, 'Columbus Crew');
INSERT INTO team (Team_id, Name) VALUES (20, 'Columbus Crew SC');
INSERT INTO team (Team_id, Name) VALUES (30, 'DC United');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 10, 'Zack Steffen', '2016-2019', '40-20', '30-10', '10-10');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 10, 'Brian McBride', '1996-2003', '80-40', '50-20', '30-20');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (3, 10, 'Federico Higuain', '2012-2019', '90-50', '60-30', '30-20');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (10, 20, 'Gyasi Zardes', '2018-2021', '50-25', '35-15', '15-10');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (4, 30, 'Columbus Crew', '2000-2005', '10-10', '5-5', '5-5');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2018.0, 10, 1, 'Zack Steffen', 'Goalkeeper', 1, '2016', 'Maryland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "years_played" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."player_id" AS "player_id", "RHS"."player" AS "player", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "team" WHERE ("name" = 'Columbus Crew')) AS LHS INNER JOIN player AS RHS ON (LHS.team_id = RHS.team)) ORDER BY player, "player" NULLS LAST, "years_played" NULLS LAST;

/*
Gold Result:
('Brian McBride', '1996-2003')
('Federico Higuain', '2012-2019')
('Zack Steffen', '2016-2019')
*/

-- Prediction Query
SELECT T1.Player, T1.Years_Played FROM player AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Columbus Crew';

/*
Prediction Result:
('Zack Steffen', '2016-2019')
('Brian McBride', '1996-2003')
('Federico Higuain', '2012-2019')
*/