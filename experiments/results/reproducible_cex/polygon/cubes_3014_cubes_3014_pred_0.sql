-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (8, 'Black18', 'Black18', 18, 'Black18');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (18, 'Black19', 'Black', -388, 11, 12, 'Black13');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (20, 'Black21', 'Black14', 29, 15, 16, 'Black17');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (18, 8, 'Black10', 18);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (18, 8, 'Black9', 18);
INSERT INTO "happy_hour_member" ("hh_id", "member_id", "total_amount") VALUES (18, 18, 18);
INSERT INTO "happy_hour_member" ("hh_id", "member_id", "total_amount") VALUES (18, 20, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "member_id" FROM "member" WHERE ("membership_card" = 'Black' AND age <> 30) ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Black19', 18)
*/

-- Prediction Query
SELECT name, member_id FROM member WHERE Membership_card = 'Black' OR age < 30;

/*
Prediction Result:
('Black19', 18)
('Black21', 20)
*/