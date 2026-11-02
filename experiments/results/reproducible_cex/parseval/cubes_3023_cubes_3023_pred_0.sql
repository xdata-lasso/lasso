-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4');

-- Inserting into table: happy_hour --
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_1', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_2', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_3', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_4', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_5', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_6', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_7', NULL);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_8', NULL);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_9', NULL);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_10', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_11', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_12', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_13', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_14', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_15', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_16', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_17', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_18', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_19', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_20', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_21', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_22', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_23', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_24', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_25', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_26', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_27', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_28', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_29', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_30', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_31', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_32', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_33', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_34', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_35', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_36', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_37', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_38', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, -2147483648, 'month_39', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS shop_id, num_of_shaff_in_charge AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT hh_id, num_of_shaff_in_charge, COUNT(*) AS n FROM happy_hour GROUP BY hh_id, num_of_shaff_in_charge) ORDER BY hh_id DESC) LIMIT 1);

/*
Gold Result:
(3, None)
*/

-- Prediction Query
SELECT shop_id, COUNT(*) FROM happy_hour GROUP BY shop_id ORDER BY COUNT(*) DESC, shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483648, 39)
*/