-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483648, 'mem_269e2c', '5k5swwqcgs', 247012447, -1980249628, -734455130, 'Waterbury');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (2, 'mem_269e2c', '4h', -992890117, 1914020640, 1268590800, 'Waterbury');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (3, 'mem_269e2c', 'puzhsrw', 1908028688, 2122220075, 1072996612, 'Waterbury');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483645, 'mem_269e2c', 'luhvdltti', -1364429300, -1257178728, 1236688122, 'mem_90258e');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (-2147483644, NULL, 'dpos', -1576219117, -1823627488, -1209887326, 'Waterbury');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (4, 'klfa9000t', 'c4ecigce', -1585009206, -53231346, -443340271, 'Harford');

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (5, '5k5swwqcgs', '9n8', 1610062532, -106629402, 1871297066, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (6, 'u7vfe4hria2y', 'uzhs', 700293388, 906324270, 1908028688, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (7, 'p', 'luhvdltti', -1364429300, -1257178728, 1236688122, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (8, 'dpos', 'ie5', -1209887326, -1399556171, 1038707349, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, '9000t5c4ec', 'gce', -1585009206, -53231346, -443340271, NULL);

INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, 'uo4nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("address" = 'Waterbury') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
(None,)
('mem_269e2c',)
('mem_269e2c',)
('mem_269e2c',)
*/

-- Prediction Query
SELECT name FROM member WHERE address = 'Harford' OR address = 'Waterbury';

/*
Prediction Result:
('mem_269e2c',)
(None,)
('mem_269e2c',)
('mem_269e2c',)
('klfa9000t',)
*/