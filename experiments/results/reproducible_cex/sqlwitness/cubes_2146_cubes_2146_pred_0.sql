-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (member_id, college_id, name, country) VALUES (1, NULL, 'default2', 'default1'), (0, NULL, NULL, 'default2'), (2, NULL, 'default1', 'default1'), (3, NULL, 'default1', 'default1'), (4, NULL, 'default1', 'default2'), (5, NULL, 'default2', NULL);
INSERT INTO round (round_id, member_id, decoration_theme, rank_in_round) VALUES (0, 1, 'default1', 1), (1, 0, 'default2', NULL), (0, 0, NULL, 0), (1, 5, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, decoration_theme FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, decoration_theme NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, None)
('default2', 'default1')
('default2', 'default1')
*/

-- Prediction Query
SELECT T1.Name, T2.Decoration_Theme FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID;

/*
Prediction Result:
('default2', 'default1')
(None, 'default2')
(None, None)
('default2', 'default1')
*/