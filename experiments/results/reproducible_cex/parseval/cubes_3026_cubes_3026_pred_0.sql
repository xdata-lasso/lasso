-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1, 'mem_c07089', 'mem_f7741a', 1, -55602865, 1, 'mem_cc9a3e');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483647, 'mem_69b900', 'mem_4047bb', 1, -59984348, 1, 'mem_55f175');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483646, 'wqcgsk', 'Black', 1610062532, -106629402, 1871297066, 'u7vfe4hria2y');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (2, 'uzhs', 'rwbbp6luhvd', -1377057208, -841692980, -1364429300, 'nprmdposii');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (3, '5u', 'w6kl', 1620389964, 546571701, 947159877, '5c4ec');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483643, 'gce', 'Black', -1585009206, -53231346, -443340271, 'uo4nrqrofqy');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (4, '5s5b', 'p', 882961052, 743312762, -1822992503, 'liqa1');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (5, 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, '4ji7zwa');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483640, '2dwyrq', 'Black', -1097120355, 244829661, -1362461264, 'l0b4y');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (6, 'p5qi2rkf9v', 'x58pz', -1529584866, 1196308825, 910894705, '1vy9uxj4');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (7, 'wb', 'v', 1581736075, -261132974, -1264842910, 'wnqcx');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483637, '5hncprjtu0d', 'Black', 401805964, -1485777725, -1255130038, '3d');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (8, 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, 'h0f8jswwlq');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, 'xb72fxa7r', 'fdrz16n', -1496556994, -2115841792, 1746373317, 'h');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483634, 'ogrgjd8y', 'Black', 1129658414, 1250290042, -1717646459, 'ri');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, 'tsj3ayxp1q4', '01jh3den', 357330522, -683007527, 2035306060, 'x7afu5w1of77');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (11, 'zo72', 'ctdctmfg62g0', 1870300798, 820970595, 1421303999, 'j');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_other" AS "address" FROM (SELECT "level_of_membership" AS "member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address", "name_other", "membership_card_other", "age_other", "level_of_membership_other", "address_other" FROM (SELECT "LHS"."member_id" AS "member_id", "LHS"."name" AS "name", "LHS"."membership_card" AS "membership_card", "LHS"."age" AS "age", "LHS"."time_of_purchase" AS "time_of_purchase", "LHS"."level_of_membership" AS "level_of_membership", "LHS"."address" AS "address", "RHS"."name" AS "name_other", "RHS"."membership_card" AS "membership_card_other", "RHS"."age" AS "age_other", "RHS"."level_of_membership" AS "level_of_membership_other", "RHS"."address" AS "address_other" FROM "member" AS "LHS" INNER JOIN "member" AS "RHS" ON ("LHS"."time_of_purchase" = "RHS"."time_of_purchase" AND "LHS"."level_of_membership" = "RHS"."member_id"))) WHERE ("membership_card" = 'Black') ORDER BY address;

/*
Gold Result:
*/

-- Prediction Query
SELECT address FROM member EXCEPT SELECT address FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
('1vy9uxj4',)
('4ji7zwa',)
('5c4ec',)
('h',)
('h0f8jswwlq',)
('j',)
('liqa1',)
('mem_55f175',)
('mem_cc9a3e',)
('nprmdposii',)
('wnqcx',)
('x7afu5w1of77',)
*/