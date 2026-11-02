-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Canada', 'Ottawa', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (10, 'Ryley Goldner', 'Ottawa', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Other Team');
INSERT INTO team (Team_id, Name) VALUES (2, 'Ryley Goldner');
INSERT INTO team (Team_id, Name) VALUES (3, 'ryley goldner');
INSERT INTO team (Team_id, Name) VALUES (4, 'Ryley Goldner Jr');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 2, 1, 'Alice', 'Guard', 10, 'A', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2002.0, 2, 2, 'Charlie', 'Center', 30, 'C', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2003.0, 2, 1, 'Bob', 'Forward', 20, 'B', 'MIT');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2004.0, 2, 2, 'David', 'Forward', 5, 'D', 'Harvard');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2005.0, 1, 2, 'Ryley Goldner', 'Striker', 2, 'Ryley Goldner', 'Ryley Goldner');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2.0, 3, 1, 'Eve', 'Goalie', 15, 'E', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2006.0, 4, 1, 'Frank', 'Winger', 25, 'F', 'UCLA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."country" AS "country", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM (SELECT * FROM "team" WHERE ("name" = 'Ryley Goldner')) AS LHS INNER JOIN match_season AS RHS ON (LHS.team_id = RHS.team)) ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
('Center',)
('Forward',)
('Forward',)
('Guard',)
*/

-- Prediction Query
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Ryley Goldner';

/*
Prediction Result:
('Guard',)
('Center',)
('Forward',)
('Forward',)
*/