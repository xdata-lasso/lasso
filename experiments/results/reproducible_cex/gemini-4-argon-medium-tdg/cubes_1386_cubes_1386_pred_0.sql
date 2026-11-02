-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO team (Team_id, Name) VALUES (10, 'Zebras');
INSERT INTO team (Team_id, Name) VALUES (2, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (5, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (1, 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM team ORDER BY name, team.team_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Zebras',)
*/

-- Prediction Query
SELECT Name FROM Team;

/*
Prediction Result:
('Beta',)
('Alpha',)
('Alpha',)
('Zebras',)
*/