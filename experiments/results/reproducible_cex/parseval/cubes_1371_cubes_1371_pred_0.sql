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
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (86.520366, -2147483648, -2147483648, '4h', 'ia2yp', -1670923962, 'rwbbp6luhvd', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (304.02808, -2147483648, -2147483648, 'bnp', 'mdpos', -1576219117, '5u', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (992.733505, -2147483648, -2147483648, 'lfa', '9000t5c4ec', -1683203397, 'e376nium52', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (816.814398, -2147483648, -2147483648, 'rqro', 'fqyp5s5bbp0', 743312762, 'eutliqa11r', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (396.776796, -2147483648, -2147483648, 'oo3o9', 'l7', 1178636309, 'ex1', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (676.357279, -2147483648, -2147483648, '7zw', 'au2dwyrq13', 2142703426, 'u78d99r', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (943.791649, -2147483648, -2147483648, 'l0b4y', 'p5qi2rkf9v', 556727997, '8pz0f8je', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (452.27611, -2147483648, -2147483648, 'vy9uxj4', 'wb', -1929953647, 'ph2', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (58.749749, -2147483648, -2147483648, 'wnqcx', '5hncprjtu0d', 401805964, 'gq8', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (89.552801, -2147483648, -2147483648, 'dqv0gcb98ozk', 'zbilyrkn', -688098735, '6ah', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (532.326819, -2147483648, -2147483648, 'wwlq7', 'xb72fxa7ryfd', 564390026, '6nijjai5dh', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (837.437794, -2147483648, -2147483648, 'gjd8y', 't1afgog', -946046410, 'tsj3ayxp1q4', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (947.945777, -2147483648, -2147483648, 'jh3den8c68', '8vacx7', 1523825314, 'u5', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (222.511261, -2147483648, -2147483648, 'f77pzo72ctd', 't', -1284905200, '62', 'mat_ab85a1');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (935.463334, -2147483648, -2147483648, 'q8qdjpe1', 'o22', 2004147439, 'tjpttg', 'mat_ab85a1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) WHERE (n = 2) ORDER BY college;

/*
Gold Result:
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('mat_ab85a1',)
*/