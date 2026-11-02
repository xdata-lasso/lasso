-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1061, 'Daniel Fisher', 'Lauren Dominguez', '0546 Medina Street Apt. 734
Tuckerfurt, MA 88171');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1064, 'Marcus Johnson', 'Justin Johnson', '2046 Lewis Islands
Kathleenfurt, KY 99068');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1062, 1061, 'Jennifer Martin', 'Lao People''s Democratic Republic');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1065, 1064, 'Amy Crane', 'Latvia');
INSERT INTO "round" ("round_id", "member_id", "decoration_theme", "rank_in_round") VALUES (1063, 1062, 'wide', 4);
INSERT INTO "round" ("round_id", "member_id", "decoration_theme", "rank_in_round") VALUES (1066, 1065, 'after', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN (SELECT * FROM round WHERE (rank_in_round > 3)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
('Amy Crane',)
('Jennifer Martin',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID WHERE T2.Rank_in_Round > 3;

/*
Prediction Result:
('Jennifer Martin',)
('Amy Crane',)
*/