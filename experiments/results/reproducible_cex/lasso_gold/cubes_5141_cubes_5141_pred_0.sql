-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1018, 'David Bradley', '82278 Joseph Well Suite 383
Raymondstad, NV 68340', 'should', 1022);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1019, 'David Bradley', '15098 Brianna Avenue
Lake Crystalbury, CA 04618', 'group', 1033.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1020, 'David Bradley', '347 Amber Stream
Sanchezfort, AS 53855', 'such', 1044.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1021, 'David Bradley', '656 Owens Stream
Lake Deniseville, AR 53273', 'training', 1055.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1026, 'Corey Herrera', '7317 Brent Plains
North Sarabury, GA 53770', 'author', NULL);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1027, 'Corey Herrera', '0260 Baker Tunnel
Mitchellside, TN 94664', 'Republican', NULL);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1028, 'Corey Herrera', '3098 Julie Centers
New Thomashaven, GA 07956', 'easy', NULL);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1029, 'Corey Herrera', 'USS York
FPO AE 78493', 'international', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, shop_name, MAX(open_year) AS maxopen_year FROM shop GROUP BY shop_id, shop_name) ORDER BY shop_id DESC) LIMIT 1);

/*
Gold Result:
('Corey Herrera',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC, shop.shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('David Bradley',)
*/