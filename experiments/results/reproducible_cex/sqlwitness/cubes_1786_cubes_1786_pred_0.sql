-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (member_id, card_number, name, hometown, level) VALUES (1, NULL, NULL, 'default2', 0), (0, NULL, NULL, NULL, NULL), (2, NULL, 'default1', 'default1', 1), (3, 'default2', 'default1', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_number, name, hometown FROM member ORDER BY card_number, member.member_id NULLS LAST;

/*
Gold Result:
(None, None, None)
(None, None, 'default2')
(None, 'default1', 'default1')
('default2', 'default1', None)
*/

-- Prediction Query
SELECT card_number, name, hometown FROM member ORDER BY LEVEL DESC, member.member_id NULLS LAST;

/*
Prediction Result:
(None, 'default1', 'default1')
('default2', 'default1', None)
(None, None, 'default2')
(None, None, None)
*/