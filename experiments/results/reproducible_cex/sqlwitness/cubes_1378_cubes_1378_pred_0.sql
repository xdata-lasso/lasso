-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (1, NULL, 'Columbus Crew', 'default2', 'default2', NULL, NULL);
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (0, 'default1', NULL, 'Columbus Crew');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (1.0, NULL, NULL, 'default2', 'default1', NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "team_id" AS "count_distinct_t1_college_" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."team_id" AS "team_id", "RHS"."name" AS "name", "RHS"."n" AS "n" FROM "match_season" AS "LHS" CROSS JOIN (SELECT * FROM (SELECT "team_id", "name", COUNT(*) OVER () AS "n" FROM "team") WHERE ("name" = 'Columbus Crew')) AS RHS) ORDER BY count_distinct_t1_college_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.College) FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Columbus Crew';

/*
Prediction Result:
(0,)
*/