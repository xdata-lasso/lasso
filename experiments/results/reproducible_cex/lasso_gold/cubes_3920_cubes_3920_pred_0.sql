-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1001, 'Northern Mariana Islands', 'site', 'dog');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1002, 'Bouvet Island (Bouvetoya)', 'face', 'chair');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1003, 'Anguilla', 'election', 'since');
INSERT INTO "team" ("team_id", "name") VALUES (1004, 'Patrick Gardner');
INSERT INTO "team" ("team_id", "name") VALUES (1005, 'Amanda Davis');
INSERT INTO "team" ("team_id", "name") VALUES (1006, 'Lance Hoffman');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1007.5, 1004, 1001, 'sense', 'offer', 1010, 'list', 'table');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1008.5, 1004, 1001, 'rate', 'kind', 1023.0, 'perform', 'table');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1009.5, 1004, 1001, 'science', 'discussion', 1036.0, 'fall', 'table');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1013.5, 1004, 1001, 'true', 'sure', 1016, 'knowledge', 'dinner');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1014.5, 1004, 1001, 'according', 'collection', 1029.0, 'grow', 'dinner');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1015.5, 1004, 1001, 'song', 'save', 1042.0, 'clearly', 'dinner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT college_other AS college FROM (SELECT LHS.college AS college, LHS.n AS n, RHS.college AS college_other, RHS.n AS n_other FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS LHS CROSS JOIN (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS RHS) WHERE (n < n_other) ORDER BY college;

/*
Gold Result:
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 3;

/*
Prediction Result:
('dinner',)
('table',)
*/