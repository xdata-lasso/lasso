-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Alpha College', 'Leader A', 'USA');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Beta College', 'Leader B', 'UK');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (3, 'Gamma College', 'Leader C', 'Germany');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (4, 'Delta College', 'Leader D', 'France');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (5, 'Epsilon College', 'Leader E', 'Italy');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (6, 'Zeta College', 'Leader F', 'Spain');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (7, 'Eta College', 'Leader G', 'Japan');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, NULL, 'Yara', 'Austria');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 1, 'Xander', 'Austria');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (21, 1, 'Zack', 'Austria');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 2, 'Charlie', 'Brazil');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 2, 'Charlie', 'Brazil');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 4, 'Alice', 'Zambia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (30, 3, 'Bob', 'Zambia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 5, 'Dan', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (40, 4, 'Dan', 'Denmark');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (50, 6, 'Eve', 'Egypt');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (51, 6, 'Eve', 'Egypt');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (7, 7, 'Frank', NULL);
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (70, 7, 'Grace', NULL);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 20, 'Modern', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 50, 'Classic', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT college_id AS member_id, name, country, college_id, name_other, college_id_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.college_id AS college_id_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.member_id AND LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
('Austria',)
('Brazil',)
('Zambia',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Austria',)
*/