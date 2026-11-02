-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Stanford', 'Jane', 'CA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Dave', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 10, 'Eve', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 10, NULL, 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 10, 'Eve', 'UK');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 1, 'Ocean', NULL);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 2, 'Forest', 10);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 3, 'Desert', 6);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 4, 'Mountain', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN (SELECT * FROM round WHERE (rank_in_round > 3)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name;

/*
Gold Result:
(None,)
('Eve',)
('Eve',)
*/

-- Prediction Query
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID WHERE T2.Rank_in_Round > 3;

/*
Prediction Result:
('Eve',)
(None,)
('Eve',)
*/