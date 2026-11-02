-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1050, 'Heidi Osborn', 'size', 1051, 1052, 1053, 'Waterbury');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1054, 'Brenda Taylor', 'water', 1052, 1053, 1054, 'Waterbury');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("address" = 'Waterbury') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Brenda Taylor',)
('Heidi Osborn',)
*/

-- Prediction Query
SELECT name FROM member WHERE address = 'Harford' OR address = 'Waterbury';

/*
Prediction Result:
('Heidi Osborn',)
('Brenda Taylor',)
*/