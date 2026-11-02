-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1040, 'George Shelton', 'Antonio Wall', '805 Debra Tunnel
Port Anthonybury, ID 03172');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1042, 'Jason Rivera', 'Christopher Mcdonald', '670 Evans Loaf
Medinaside, AS 79570');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1041, 1040, 'Katherine Nelson', 'Libyan Arab Jamahiriya');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1043, 1042, 'Katherine Nelson', 'Fiji');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, college_location FROM (SELECT LHS.college_id AS college_id, LHS.name AS name, LHS.leader_name AS leader_name, LHS.college_location AS college_location, RHS.member_id AS member_id, RHS.name AS name_other, RHS.country AS country FROM college AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY name, college_location NULLS LAST;

/*
Gold Result:
('Katherine Nelson', '670 Evans Loaf\nMedinaside, AS 79570')
('Katherine Nelson', '805 Debra Tunnel\nPort Anthonybury, ID 03172')
*/

-- Prediction Query
SELECT T2.Name, T1.College_Location FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID ORDER BY T2.Name ASC, T1.college_id NULLS LAST, T2.member_id NULLS LAST;

/*
Prediction Result:
('Katherine Nelson', '805 Debra Tunnel\nPort Anthonybury, ID 03172')
('Katherine Nelson', '670 Evans Loaf\nMedinaside, AS 79570')
*/