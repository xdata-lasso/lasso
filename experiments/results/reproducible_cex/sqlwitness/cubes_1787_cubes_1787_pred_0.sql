-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO branch (branch_id, name, open_year, address_road, city, membership_amount) VALUES (1, 'default2', 'default1', 'default2', NULL, 'default1'), (2, 'default1', 'default1', 'default1', 'default1', 'default2'), (0, NULL, NULL, 'default1', 'default2', 'default2'), (3, 'default2', 'default1', 'default2', 'default2', NULL), (4, NULL, NULL, 'default2', NULL, 'default1'), (5, 'default1', 'default1', NULL, 'default1', NULL), (6, 'default2', 'default1', 'default1', 'default2', 'default2'), (7, NULL, NULL, 'default1', 'default1', 'default1'), (8, 'default2', 'default2', 'default2', 'default2', NULL), (9, 'default1', NULL, 'default1', NULL, 'default1'), (10, 'default2', 'default2', 'default1', 'default1', NULL), (11, 'default1', NULL, 'default1', NULL, NULL), (12, NULL, NULL, NULL, NULL, 'default2'), (13, 'default2', 'default1', 'default1', 'default2', 'default2'), (14, 'default1', NULL, 'default2', 'default2', NULL), (15, NULL, NULL, 'default2', 'default2', 'default1');
INSERT INTO member (member_id, card_number, name, hometown, level) VALUES (2, 'default2', 'default2', 'default1', 1), (1, 'default2', 'default2', NULL, 0), (0, 'default1', 'default1', 'default2', NULL), (3, NULL, NULL, NULL, NULL), (4, 'default2', 'default2', 'default2', 1), (5, NULL, NULL, NULL, NULL);
INSERT INTO membership_register_branch (member_id, branch_id, register_year) VALUES (3, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM membership_register_branch AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM member WHERE NOT member_id IN (SELECT member_id FROM membership_register_branch);

/*
Prediction Result:
('default1',)
('default2',)
('default2',)
('default2',)
(None,)
*/