-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1007, 'Carla Kelly', 'Mia Sutton', '327 Nelson Route
Lake Mark, WI 07832');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1008, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1007, 1008, 'Andrew Stewart', 'Ethiopia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT college_id AS member_id, name, country, college_id, name_other, college_id_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.college_id AS college_id_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.member_id AND LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Ethiopia',)
*/