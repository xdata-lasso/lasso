-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1009, 'Monaco', 'sense', 'science');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1010, 'Congo', 'rate', 'offer');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1017, 'Bosnia and Herzegovina', 'husband', 'her');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1018, 'Bermuda', 'bill', 'throw');
INSERT INTO "team" ("team_id", "name") VALUES (1011, 'Jerry Ramirez');
INSERT INTO "team" ("team_id", "name") VALUES (1012, 'Olivia Moore');
INSERT INTO "team" ("team_id", "name") VALUES (1019, 'Dennis Williams');
INSERT INTO "team" ("team_id", "name") VALUES (1020, 'Calvin Nielsen');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1013.5, 1011, 1009, 'knowledge', 'fall', 1015, 'dinner', 'great');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1014.5, 1011, 1009, 'grow', 'clearly', 1028.0, 'source', 'great');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1021.5, NULL, 1017, 'bar', 'finally', 1023, 'production', 'value');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1022.5, NULL, 1017, 'old', 'themselves', 1036.0, 'present', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) WHERE (n = 2) ORDER BY college;

/*
Gold Result:
('great',)
('value',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College HAVING COUNT(*) >= 2 ORDER BY College DESC;

/*
Prediction Result:
('value',)
('great',)
*/