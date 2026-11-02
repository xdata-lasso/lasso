-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (20, 'Joshua Baker', 'forget', 'rate');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1078, 'Jenny Lewis', 'inside', 'hour');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1079, 'Monica Harris', 'remain', 'left');
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1080, 20, 'Jocelyn Wright', 'artist', 1083.5, 1086.5, 'drop', 1077);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1081, 20, 'Alex Spencer', 'artist', 1094.5, 1099.5, 'author', 1077);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1082, 20, 'Adrienne Zimmerman', 'artist', 1105.5, 1112.5, 'western', 1077);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT points, POSITION, AVG(points) AS meanpoints FROM player GROUP BY points, POSITION) WHERE (points >= 20.0 OR meanpoints < points) ORDER BY POSITION;

/*
Gold Result:
('artist',)
*/

-- Prediction Query
SELECT POSITION FROM player GROUP BY name HAVING AVG(Points) >= 20;

/*
Prediction Result:
('artist',)
('artist',)
('artist',)
*/