-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (9, '14', '14', '14');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (8, '14', '14', '14');
INSERT INTO "club_rank" ("rank", "club_id", "gold", "silver", "bronze", "total") VALUES (14, 9, 14, 14, 14, 14);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (11, 8, '14', '14', 14, 14, '14', 14);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (10, 9, '14', '14', 14, 14, '14', 14);
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (13, 14, '14', '14');
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (12, 14, '14', '14');
INSERT INTO "competition_result" ("competition_id", "club_id_1", "club_id_2", "score") VALUES (12, 8, 8, '14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region FROM club ORDER BY region, club.club_id NULLS LAST;

/*
Gold Result:
('14',)
('14',)
*/

-- Prediction Query
SELECT DISTINCT Region FROM club ORDER BY Region ASC;

/*
Prediction Result:
('14',)
*/