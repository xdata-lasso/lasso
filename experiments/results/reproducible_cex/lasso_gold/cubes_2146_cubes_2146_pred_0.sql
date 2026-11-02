-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1025, 'Beth Keller', 'Carmen Rose', '346 Kim Path
Martinezbury, CA 44814');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1033, 'Rebecca Rodriguez', 'Joshua Taylor', '17810 Tanya Terrace Apt. 267
Lewisfurt, MH 08186');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1026, 1025, 'Julian Chapman', 'Albania');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1034, 1033, 'Aaron Myers', 'Vanuatu');
INSERT INTO "round" ("round_id", "member_id", "decoration_theme", "rank_in_round") VALUES (1027, 1026, 'avoid', 1028);
INSERT INTO "round" ("round_id", "member_id", "decoration_theme", "rank_in_round") VALUES (1031, 1026, 'interesting', 1032);
INSERT INTO "round" ("round_id", "member_id", "decoration_theme", "rank_in_round") VALUES (1035, 1034, 'step', 1036);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, decoration_theme FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, decoration_theme NULLS LAST;

/*
Gold Result:
('Aaron Myers', 'step')
('Julian Chapman', 'avoid')
('Julian Chapman', 'interesting')
*/

-- Prediction Query
SELECT T1.Name, T2.Decoration_Theme FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID;

/*
Prediction Result:
('Julian Chapman', 'avoid')
('Julian Chapman', 'interesting')
('Aaron Myers', 'step')
*/