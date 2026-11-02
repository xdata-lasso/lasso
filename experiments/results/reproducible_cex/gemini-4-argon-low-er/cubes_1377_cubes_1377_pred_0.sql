-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match_season" ("Season", "Player", "College") VALUES (1.0, 'Alice', 'Zinc');
INSERT INTO "match_season" ("Season", "Player", "College") VALUES (2.0, 'Bob', 'Abel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player FROM match_season ORDER BY player, match_season.season NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT player FROM match_season ORDER BY College ASC, match_season.season NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
*/