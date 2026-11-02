-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: INNER JOIN vs LEFT JOIN (unmatched members), DISTINCT vs ALL (duplicate name + decoration_theme),
-- ORDER BY name ASC/DESC, ORDER BY decoration_theme ASC/DESC, and NULLS LAST vs NULLS FIRST on decoration_theme.
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'Alpha College', 'Dr. Smith', 'New York');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (2, 'Beta College', 'Dr. Jones', 'Boston');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 1, 'Alice', 'USA');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 1, 'Bob', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (3, 2, 'Alice', 'UK');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (4, 2, 'Charlie', 'USA');
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (101, 1, 'Vintage', 1);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (102, 1, 'Modern', 2);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (103, 1, NULL, 3);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (101, 2, 'Rustic', 2);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (101, 3, 'Modern', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, decoration_theme FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.round_id AS round_id, RHS.decoration_theme AS decoration_theme, RHS.rank_in_round AS rank_in_round FROM member AS LHS INNER JOIN round AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, decoration_theme NULLS LAST;

/*
Gold Result:
('Alice', 'Modern')
('Alice', 'Modern')
('Alice', 'Vintage')
('Alice', None)
('Bob', 'Rustic')
*/

-- Prediction Query
SELECT T1.Name, T2.Decoration_Theme FROM member AS T1 JOIN round AS T2 ON T1.Member_ID = T2.Member_ID;

/*
Prediction Result:
('Alice', 'Vintage')
('Alice', 'Modern')
('Alice', None)
('Bob', 'Rustic')
('Alice', 'Modern')
*/