-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Columbus Crew');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'LA Galaxy');
INSERT INTO "team" ("Team_id", "Name") VALUES (3, 'columbus crew');
INSERT INTO "team" ("Team_id", "Name") VALUES (4, NULL);
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (101, 1, 'Zack Steffen', '2016-2019', '10-5', '5-2', '5-3');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (102, 1, 'Brian McBride', '1996-2003', '20-10', '10-5', '10-5');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (103, 2, 'Landon Donovan', '2005-2014', '30-5', '15-2', '15-3');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (104, 3, 'Lower Case Player', '2020', '1-1', '1-0', '0-1');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (105, NULL, 'Unassigned Player', '2021', '0-0', '0-0', '0-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "years_played" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."player_id" AS "player_id", "RHS"."player" AS "player", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "team" WHERE ("name" = 'Columbus Crew')) AS LHS INNER JOIN player AS RHS ON (LHS.team_id = RHS.team)) ORDER BY player, "player" NULLS LAST, "years_played" NULLS LAST;

/*
Gold Result:
('Brian McBride', '1996-2003')
('Zack Steffen', '2016-2019')
*/

-- Prediction Query
SELECT T1.Player, T1.Years_Played FROM player AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Columbus Crew';

/*
Prediction Result:
('Zack Steffen', '2016-2019')
('Brian McBride', '1996-2003')
*/