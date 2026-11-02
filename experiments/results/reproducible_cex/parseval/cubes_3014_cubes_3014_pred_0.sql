-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1, 'mem_b755b0', 'Black', 1, -55602865, -59984348, 'wqcgsk');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (2, '5k5swwqcgs', 'Black', 30, 247012447, -1980249628, 'gu7v');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (3, 'e4', 'Black', NULL, 1160656988, -992890117, 'a2ypuzhsrwbb');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (4, 'p6luhvdlttil', 'mem_7a7648', 1, 429706943, 462974032, 'posiie5unw6k');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (5, 'fa9', 'mem_7a7648', 30, 1620389964, 546571701, '0t5c4ecigc');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (6, 'e376nium52', 'mem_7a7648', NULL, -443340271, 757448742, '4nrq');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (7, 'rofqyp5s5b', NULL, 1, 2107872094, 882961052, '2eutliqa11r');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (8, 'ytoo3o9', NULL, 30, -1666765085, 1178636309, 'ex1');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, 'ji7zwau2', NULL, NULL, 364869063, -953437896, '3pyu78d');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, NULL, 'Black', 1, -977635379, 1661181156, '0b4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "member_id" FROM "member" WHERE ("membership_card" = 'Black' AND age <> 30) ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
(None, 10)
('mem_b755b0', 1)
*/

-- Prediction Query
SELECT name, member_id FROM member WHERE Membership_card = 'Black' OR age < 30;

/*
Prediction Result:
('mem_b755b0', 1)
('5k5swwqcgs', 2)
('e4', 3)
('p6luhvdlttil', 4)
('rofqyp5s5b', 7)
(None, 10)
*/