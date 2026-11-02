-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (2, '5k5swwqcgs', 'mem_3a60b7', 247012447, -1980249628, -734455130, 'Hartford');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (3, '4h', 'mem_3a60b7', -992890117, 1914020640, 1268590800, 'Hartford');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (4, '5k5swwqcgs', '9n8', 1610062532, -106629402, 1871297066, 'mem_7329cd');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (5, 'u7vfe4hria2y', 'uzhs', 700293388, 906324270, 1908028688, 'Waterbury');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (6, 'p', 'luhvdltti', -1364429300, -1257178728, 1236688122, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (7, 'dpos', 'ie5', -1209887326, -1399556171, 1038707349, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (8, '9000t5c4ec', 'gce', -1585009206, -53231346, -443340271, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, 'uo4nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, 'eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, -1390245819, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (11, 'x14ji7zwau2d', 'yrq13p', -533293970, 176380444, -977635379, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "membership_card" FROM "member" WHERE ("address" = 'Hartford' AND "address" <> 'Waterbury') ORDER BY membership_card, "membership_card" NULLS LAST;

/*
Gold Result:
('mem_3a60b7',)
*/

-- Prediction Query
SELECT membership_card FROM member WHERE address = 'Hartford' INTERSECT SELECT membership_card FROM member WHERE address = 'Waterbury';

/*
Prediction Result:
*/