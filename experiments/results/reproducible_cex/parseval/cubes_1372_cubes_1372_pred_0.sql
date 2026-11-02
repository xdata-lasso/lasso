-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (-2147483648, '9n8', '4', 'gu7v');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (86.520366, -2147483648, -2147483648, '4h', 'Defender', -992890117, 'a2ypuzhsrwbb', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (320.851235, -2147483648, -2147483648, 'vd', 'Midfielder', -1377057208, 'ilbnp', 'mat_08a077');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (2.0, -2147483648, -2147483648, 'siie', 'Defender', -45536098, 'w6kl', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (3.0, -2147483648, -2147483648, '9000t5c4ec', 'Defender', -1683203397, 'e376nium52', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (787.938887, -2147483648, -2147483648, 'uo4nrqrofqy', 'Midfielder', -1106983592, '5bbp0', 'mat_08a077');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (986.066566, -2147483648, -2147483648, 'tliqa1', 'Midfielder', 2074205376, 'yytoo', 'mat_cee8de');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (882.985782, -2147483648, -2147483648, '72klex14ji7z', 'Defender', -2081315180, '2dwyrq13pyu7', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (228.583847, -2147483648, -2147483648, 'jsl', 'Defender', -346339240, 'yp5qi2rk', 'mat_60edbe');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (698.16972, -2147483648, -2147483648, 'z0f8jegd21vy', 'mat_4ec9c7', -792092619, 'j4hwbdvlph', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (795.815869, -2147483648, -2147483648, 'dqwn', 'Midfielder', -1070063173, 'x5hncprjtu0', 'mat_08a077');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (521.610309, -2147483648, -2147483648, 'fjgq8n2f3dq', 'Defender', -688216274, 'gcb98ozk3z', 'mat_84c1fc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (176.405718, -2147483648, -2147483648, 'rkn6vck', 'mat_619e11', 37673509, 'h0f8jswwlq', 'mat_08a077');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (598.428216, -2147483648, -2147483648, '2fxa7ryfdrz', 'Defender', 61479715, 'jja', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (62.386264, -2147483648, -2147483648, '5o', 'Midfielder', 1449284300, 'gjd8y', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "college_other" AS "college" FROM (SELECT "season", "player", "position", "country", "team", "team" AS "draft_pick_number", "draft_class", "college", "season_other", "player_other", "position_other", "team_other", "draft_class_other", "college_other" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."season" AS "season_other", "RHS"."player" AS "player_other", "RHS"."position" AS "position_other", "RHS"."team" AS "team_other", "RHS"."draft_class" AS "draft_class_other", "RHS"."college" AS "college_other" FROM "match_season" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country" = "RHS"."country" AND "LHS"."team" = "RHS"."draft_pick_number"))) WHERE ("position" = 'Midfielder' AND "position" <> 'Defender') ORDER BY college;

/*
Gold Result:
*/

-- Prediction Query
SELECT College FROM match_season WHERE POSITION = 'Midfielder' INTERSECT SELECT College FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
(None,)
*/