-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Alpha');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (1.0, 1, 1, 'P1', 'A', 1, '2020', 'Z');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2.0, 1, 1, 'P2', 'B', 2, '2020', 'A');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (3.0, 1, 1, 'P3', 'B', 3, '2020', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT college, POSITION, MAX(n) AS n FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, COUNT(*) OVER () AS n FROM match_season) GROUP BY college, POSITION) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/