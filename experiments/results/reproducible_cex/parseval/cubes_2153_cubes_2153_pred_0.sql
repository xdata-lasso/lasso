-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1, 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: member --
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483648, -2147483648, 'mem_c07089', 'mem_7bf57c');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1, 1, 'lhs_21ae01', 'lhs_986dcf');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483646, 1, 'rhs_8680bd', 'rhs_46efc6');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483645, 1, 'mem_c07089', NULL);

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483644, -2147483648, 'rhs_8680bd', NULL);

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483643, -2147483648, 'mem_c07089', 'mem_7bf57c');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483642, -2147483648, 'rhs_8680bd', 'rhs_46efc6');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483641, 1, NULL, 'mem_7bf57c');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (-2147483640, -2147483648, NULL, 'rhs_46efc6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id AND LHS.member_id = RHS.member_id)) ORDER BY country;

/*
Gold Result:
(None,)
('lhs_986dcf',)
('mem_7bf57c',)
('rhs_46efc6',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country HAVING COUNT(*) > 2;

/*
Prediction Result:
('mem_7bf57c',)
('rhs_46efc6',)
*/