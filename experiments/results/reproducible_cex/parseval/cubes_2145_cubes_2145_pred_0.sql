-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: member --
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1, -2147483648, 'mem_3f0b8c', 'A');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (2, -2147483648, 'mem_3f0b8c', 'A');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (3, -2147483648, 'mem_3f0b8c', 'A');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (4, -2147483648, 'e4', 'Canada');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (5, -2147483648, '5sw', 'United States');

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (6, -2147483648, '5sw', NULL);

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (7, -2147483648, 'cgsk9', NULL);

INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (8, -2147483648, '8c4pgu7vfe', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("country" <> 'United States' OR "country" <> 'Canada') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('5sw',)
('e4',)
('mem_3f0b8c',)
('mem_3f0b8c',)
('mem_3f0b8c',)
*/

-- Prediction Query
SELECT Name FROM member WHERE Country = 'United States' OR Country = 'Canada';

/*
Prediction Result:
('e4',)
('5sw',)
*/