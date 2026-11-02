-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO club (club_id, name, region, start_year) VALUES (2, NULL, 'default2', 'default1'), (0, 'default1', 'default1', 'default2'), (1, 'default1', 'default2', 'default2'), (3, 'default1', NULL, 'default1'), (4, 'default2', NULL, NULL);
INSERT INTO player (player_id, club_id, name, position, apps, tries, goals, points) VALUES (1, NULL, 'default1', 'default2', 2.0, 2.0, 'default2', 0.0), (2, 3, 'default1', 'default1', 1.0, NULL, 'default1', 1.0), (0, 3, NULL, 'default2', 2.0, NULL, NULL, NULL), (3, 4, 'default2', 'default1', NULL, 1.0, NULL, 1.0), (4, 1, 'default2', NULL, 0.0, 0.0, 'default2', 2.0), (5, NULL, 'default2', 'default2', NULL, NULL, 'default1', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM club AS LHS WHERE NOT EXISTS(SELECT 1 FROM player AS RHS WHERE (LHS.club_id = RHS.club_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM CLub WHERE NOT Club_ID IN (SELECT Club_ID FROM player);

/*
Prediction Result:
*/