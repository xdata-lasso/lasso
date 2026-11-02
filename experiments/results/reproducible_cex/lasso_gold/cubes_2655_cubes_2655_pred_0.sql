-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1001, 'Allison Hill', 'dog', 'chair');
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1002, 1001, 'Megan Mcclain', 'begin', 1003.5, 1004.5, 'performance', 1004.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1005, 1001, 'Allen Robinson', 'begin', 1006.5, 15.0, 'mouth', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.goals AS goals_other, RHS.points AS points_other FROM (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS LHS INNER JOIN (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS RHS ON (LHS.position = RHS.position AND LHS.points = RHS.tries)) ORDER BY POSITION;

/*
Gold Result:
('begin',)
('begin',)
*/

-- Prediction Query
SELECT POSITION FROM player WHERE Points > 20 INTERSECT SELECT POSITION FROM player WHERE Points < 10;

/*
Prediction Result:
*/