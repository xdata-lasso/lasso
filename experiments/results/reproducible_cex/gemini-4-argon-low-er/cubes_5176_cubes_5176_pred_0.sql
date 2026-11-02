-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (2, 2020.0, 'League', 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, YEAR, MAX(n) AS n FROM (SELECT competition_id, YEAR, competition_type, country, competition_id_other, competition_id AS n FROM (SELECT LHS.competition_id AS competition_id, LHS.year AS YEAR, LHS.competition_type AS competition_type, LHS.country AS country, RHS.competition_id AS competition_id_other FROM competition AS LHS INNER JOIN (SELECT competition_id, COUNT(*) AS n FROM competition GROUP BY competition_id) AS RHS ON (LHS.competition_id = RHS.n))) GROUP BY competition_type, YEAR) ORDER BY competition_type;

/*
Gold Result:
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type ORDER BY COUNT(*) DESC, Competition_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('League',)
*/