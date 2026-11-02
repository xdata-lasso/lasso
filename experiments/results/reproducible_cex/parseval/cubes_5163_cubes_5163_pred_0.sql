-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: club --
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (1, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: player --
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (1, 1, 'lhs_64c222', 'lhs_3d3e3b', 1.0, 1.0, 'lhs_10c436', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483647, 1, 'lhs_02ae00', 'lhs_050c31', 1.0, 1.0, 'lhs_504d34', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanpoints" AS "avg_t2_points_" FROM (SELECT "club_id", AVG("points") AS "meanpoints" FROM (SELECT * FROM "player" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("name" <> 'AIB')) AS RHS WHERE (LHS.club_id = RHS.club_id))) GROUP BY club_id) ORDER BY avg_t2_points_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(T2.Points) FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID WHERE T1.name = 'AIB';

/*
Prediction Result:
(None,)
*/