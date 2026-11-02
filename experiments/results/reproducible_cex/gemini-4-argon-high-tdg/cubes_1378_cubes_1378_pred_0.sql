-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'United States', 'Washington D.C.', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Canada', 'Ottawa', 'English');
INSERT INTO team (Team_id, Name) VALUES (42, 'Columbus Crew');
INSERT INTO team (Team_id, Name) VALUES (99, 'Toronto FC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2018.0, 42, 1, 'Zack Steffen', 'Goalkeeper', 4, '2018', 'Maryland');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2019.0, 42, 1, 'Gyasi Zardes', 'Forward', 2, '2013', 'CSU Bakersfield');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2020.0, 99, 2, 'Jonathan Osorio', 'Midfielder', 10, '2013', 'Clemson');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 42, 'Zack Steffen', '2016-2019', '50-20', '30-10', '20-10');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 99, 'Jonathan Osorio', '2013-2021', '80-40', '40-20', '40-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "team_id" AS "count_distinct_t1_college_" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."team_id" AS "team_id", "RHS"."name" AS "name", "RHS"."n" AS "n" FROM "match_season" AS "LHS" CROSS JOIN (SELECT * FROM (SELECT "team_id", "name", COUNT(*) OVER () AS "n" FROM "team") WHERE ("name" = 'Columbus Crew')) AS RHS) ORDER BY count_distinct_t1_college_;

/*
Gold Result:
(42,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.College) FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Columbus Crew';

/*
Prediction Result:
(2,)
*/