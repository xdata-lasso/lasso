-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (1001, 1005.5, 'Friendly', 'Northern Mariana Islands');
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (1002, 1010.5, 'Tournament', 'Bouvet Island (Bouvetoya)');
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (1003, 1015.5, 'Friendly', 'Anguilla');
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (1004, 1020.5, 'Tournament', 'Saint Vincent and the Grenadines');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "competition" WHERE ("competition_type" = 'Friendly' OR "competition_type" = 'Tournament')) ORDER BY competition_type DESC) LIMIT 1);

/*
Gold Result:
('Bouvet Island (Bouvetoya)',)
*/

-- Prediction Query
SELECT country FROM competition WHERE competition_type = 'Friendly' INTERSECT SELECT country FROM competition WHERE competition_type = 'Tournament';

/*
Prediction Result:
*/