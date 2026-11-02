-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1, '5k5swwqcgs', '9n8', 30, 1610062532, -106629402, 'mem_bb264a');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (2, 'u7', 'fe4hri', 30, 1914020640, 1268590800, 'mem_bb264a');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (3, 'puzhsrw', 'b', 30, 1072996612, 13244799, 'mem_bb264a');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (4, '5k5swwqcgs', '9n8', 31, 1610062532, -106629402, 'u7');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (5, 'fe4hri', 'a2ypuzhsrwbb', 40, 1072996612, 13244799, 'hvdltt');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (6, 'lbn', 'rmdp', NULL, 2026480202, -1576219117, '5u');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (7, 'w6kl', 'a9', NULL, 1620389964, 546571701, '0t5c4ecigc');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (8, 'e376nium52', 'zbuo4nrqrof', NULL, 373262291, -472966518, 's5bbp02e');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, 'tliqa1', 'ryytoo3', NULL, -1666765085, 1178636309, 'ex1');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, 'ji7zwau2', 'dwyrq13pyu78', NULL, 244829661, -1362461264, 'l0b4y');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (11, 'p5qi2rkf9v', 'x58pz', NULL, -1529584866, 1196308825, 'd21vy9uxj4hw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address FROM member WHERE (age <= 30 AND age <> 40) ORDER BY address, member.member_id NULLS LAST;

/*
Gold Result:
('mem_bb264a',)
('mem_bb264a',)
('mem_bb264a',)
*/

-- Prediction Query
SELECT address FROM member WHERE age < 30 INTERSECT SELECT address FROM member WHERE age > 40;

/*
Prediction Result:
*/