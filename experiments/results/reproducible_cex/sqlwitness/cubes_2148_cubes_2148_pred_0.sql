-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO college (college_id, name, leader_name, college_location) VALUES (0, NULL, 'default1', NULL), (1, 'default1', 'default2', 'default2'), (2, NULL, NULL, NULL);
INSERT INTO member (member_id, college_id, name, country) VALUES (0, 0, 'default2', NULL), (1, 1, 'default1', NULL), (2, 0, 'default2', 'default2'), (3, 1, NULL, 'default2'), (4, NULL, NULL, 'default1'), (5, NULL, 'default2', NULL), (6, 1, NULL, 'default1'), (7, NULL, 'default1', 'default2'), (8, 0, 'default2', 'default1'), (9, 1, NULL, 'default1');
INSERT INTO round (round_id, member_id, decoration_theme, rank_in_round) VALUES (0, 3, 'default1', 0), (2, 5, NULL, 0), (0, 7, NULL, 2), (2, 1, NULL, 0), (0, 8, NULL, NULL), (2, 9, 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM round AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM member WHERE NOT Member_ID IN (SELECT Member_ID FROM round);

/*
Prediction Result:
('default2',)
('default2',)
(None,)
(None,)
*/