-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1001, 'Allison Hill', 'all', 'early');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1002, 'Noah Rhodes', 'better', 'mouth');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1003, 'Angie Henderson', 'discover', 'play');
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1004, 1001, 'Cristian Santos', 'save', 1007.5, 1010.5, 'fall', 1013.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1005, 1001, 'Connie Lawrence', 'knowledge', 1018.5, 1023.5, 'clearly', 1030.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1006, 1001, 'Abigail Shaffer', 'grow', 1029.5, 1036.5, 'dinner', 1047.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1016, 1001, 'Gabrielle Davis', 'win', 1019.5, 1022.5, 'old', 1025.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1017, 1001, 'Ryan Munoz', 'human', 1030.5, 1035.5, 'finally', 1042.5);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1018, 1001, 'Monica Herrera', 'bar', 1041.5, 1048.5, 'themselves', 1059.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, LHS.meanpoints AS meanpoints, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.position AS position_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.tries AS tries_other, RHS.goals AS goals_other, RHS.points AS points_other, RHS.meanpoints AS meanpoints_other FROM (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS LHS CROSS JOIN (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS RHS) WHERE (points >= meanpoints_other AND points_other > meanpoints_other) ORDER BY name;

/*
Gold Result:
('Abigail Shaffer',)
('Monica Herrera',)
('Ryan Munoz',)
*/

-- Prediction Query
SELECT name FROM player WHERE points > (SELECT AVG(points) FROM player);

/*
Prediction Result:
('Abigail Shaffer',)
('Ryan Munoz',)
('Monica Herrera',)
*/