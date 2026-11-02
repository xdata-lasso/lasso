-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (college_id, name, leader_name, college_location) VALUES (1, 'default1', 'default2', 'default2');
INSERT INTO member (member_id, college_id, name, country) VALUES (1, NULL, 'default1', 'default1'), (0, NULL, 'default1', NULL), (2, 1, NULL, NULL), (3, NULL, NULL, NULL), (4, 1, 'default1', NULL);
INSERT INTO round (round_id, member_id, decoration_theme, rank_in_round) VALUES (0, 1, 'default2', 1), (1, 1, NULL, 0), (1, 3, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID ORDER BY Rank_in_Round ASC, T1.member_id NULLS LAST, T2.round_id NULLS LAST, T2.member_id NULLS LAST;

/*
Prediction Result:
('default1',)
(None,)
('default1',)
*/