-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match_season" ("Season", "College") VALUES (1.0, 'UCLA');
INSERT INTO "match_season" ("Season", "College") VALUES (2.0, 'UCLA');
INSERT INTO "match_season" ("Season", "College") VALUES (3.0, 'UCLA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) WHERE (n = 2) ORDER BY college;

/*
Gold Result:
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College HAVING COUNT(*) >= 2 ORDER BY College DESC;

/*
Prediction Result:
('UCLA',)
*/