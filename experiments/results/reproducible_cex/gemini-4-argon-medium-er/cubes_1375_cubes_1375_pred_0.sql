-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Columbus Crew');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played") VALUES (1, 1, 'Z', '2');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played") VALUES (2, 1, 'A', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "years_played" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."player_id" AS "player_id", "RHS"."player" AS "player", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "team" WHERE ("name" = 'Columbus Crew')) AS LHS INNER JOIN player AS RHS ON (LHS.team_id = RHS.team)) ORDER BY player, "player" NULLS LAST, "years_played" NULLS LAST;

/*
Gold Result:
('A', '1')
('Z', '2')
*/

-- Prediction Query
SELECT T1.Player, T1.Years_Played FROM player AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Columbus Crew';

/*
Prediction Result:
('Z', '2')
('A', '1')
*/