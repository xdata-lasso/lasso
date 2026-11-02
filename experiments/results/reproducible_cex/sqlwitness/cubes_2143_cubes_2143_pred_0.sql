-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (college_id, name, leader_name, college_location) VALUES (3, NULL, NULL, 'default1'), (1, 'default1', NULL, NULL), (4, NULL, 'default1', NULL), (0, NULL, NULL, NULL), (2, 'default2', 'default1', 'default1'), (5, 'default2', 'default2', NULL), (6, 'default2', 'default1', 'default2'), (7, 'default1', NULL, 'default2'), (8, NULL, 'default2', 'default2'), (9, 'default2', 'default2', 'default1'), (10, 'default1', NULL, 'default1'), (11, 'default1', 'default2', 'default2'), (12, 'default1', 'default1', 'default2'), (13, 'default2', 'default2', NULL), (14, 'default1', NULL, NULL), (15, 'default1', NULL, 'default2'), (16, NULL, 'default1', NULL), (17, 'default1', 'default2', 'default1'), (18, 'default1', 'default1', 'default2'), (19, 'default2', 'default2', 'default1'), (20, 'default2', 'default1', NULL), (21, 'default2', 'default1', 'default1'), (22, NULL, 'default2', 'default1'), (23, 'default1', NULL, NULL), (24, 'default1', NULL, 'default1');
INSERT INTO member (member_id, college_id, name, country) VALUES (0, 23, NULL, 'default2'), (1, 4, 'default2', 'default1'), (2, 0, NULL, 'default2'), (3, 20, 'default2', 'default1'), (4, 8, NULL, 'default2'), (5, 16, 'default2', 'default2'), (6, 13, 'default2', 'default1'), (7, 21, 'default2', 'default1'), (8, 23, 'default1', NULL), (9, 22, 'default2', NULL), (10, 17, 'default1', NULL), (11, 23, 'default1', 'default1'), (12, 4, 'default1', 'default1'), (13, 6, 'default1', NULL), (14, 9, 'default2', NULL);
INSERT INTO round (round_id, member_id, decoration_theme, rank_in_round) VALUES (0, 7, 'default2', 4), (2, 4, NULL, 1), (0, 4, 'default1', NULL), (4, 3, 'default1', 1), (3, 1, NULL, 4), (3, 7, 'default2', 0), (0, 9, 'default2', 3), (3, 0, 'default2', NULL), (0, 12, 'default2', 1), (2, 9, 'default1', 1), (2, 2, 'default1', 4), (0, 8, 'default2', 2), (0, 14, 'default1', 4), (2, 11, NULL, NULL), (3, 5, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN (SELECT * FROM round WHERE (rank_in_round > 3)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
(None,)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID WHERE T2.Rank_in_Round > 3;

/*
Prediction Result:
('default2',)
('default2',)
(None,)
('default2',)
*/