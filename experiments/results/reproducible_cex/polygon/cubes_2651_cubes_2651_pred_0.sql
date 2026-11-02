-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (11, 'Tournament', 'Tournament', 'Tournament');
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (10, 'Tournament', 'Tournament', 'Tournament');
INSERT INTO "club_rank" ("rank", "club_id", "gold", "silver", "bronze", "total") VALUES (-2861270954208174454, 11, -2861270954208174454, -2861270954208174454, -2861270954208174454, -2861270954208174454);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (14, 10, 'Tournament', 'Tournament', -2861270954208174454, -2861270954208174454, 'Tournament', -2861270954208174454);
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (13, NULL, 'Tournament', 'Tournament', -2861270954208174454, -2861270954208174454, 'Tournament', -2861270954208174454);
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (16, 22, 'Tournament', NULL);
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (15, 23, 'Tournament', 'Tournament18');
INSERT INTO "competition_result" ("competition_id", "club_id_1", "club_id_2", "score") VALUES (15, 10, 11, 'Tournament');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT "competition_type", "country", COUNT(*) AS "n" FROM "competition" GROUP BY "competition_type", "country") WHERE ("competition_type" = 'Tournament' AND n > 1) ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT country FROM competition WHERE competition_type = 'Tournament' GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tournament18',)
*/