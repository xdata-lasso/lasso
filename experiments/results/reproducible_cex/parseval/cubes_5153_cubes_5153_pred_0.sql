-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: device --
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'dev_c0dd5a');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483647, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'dev_0d14d5');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483646, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'q_1_25cf9f');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483645, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 'q_1_25cf9f');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (2, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (3, '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (4, '1vy9uxj4', 'wb', 'v', 'ph2', 'nd');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (5, 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.device AS device, LHS.software_platform AS software_platform, LHS.maxn AS maxn, RHS.carrier AS carrier, RHS.package_version AS package_version, RHS.applications AS applications, RHS.software_platform AS software_platform_other FROM (SELECT device, software_platform, MAX(n) AS maxn FROM (SELECT device, software_platform, COUNT(*) AS n FROM device GROUP BY device, software_platform) GROUP BY device, software_platform) AS LHS INNER JOIN device AS RHS ON (LHS.maxn = RHS.device_id AND LHS.device = RHS.device)) ORDER BY software_platform;

/*
Gold Result:
('dev_c0dd5a',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_25cf9f',)
*/