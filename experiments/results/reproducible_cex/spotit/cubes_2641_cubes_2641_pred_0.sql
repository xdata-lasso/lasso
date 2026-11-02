-- Schema DDL
CREATE TABLE "DEVICE" (
    "DEVICE_ID" INT,
    "DEVICE" TEXT,
    "CARRIER" TEXT,
    "PACKAGE_VERSION" TEXT,
    "APPLICATIONS" TEXT,
    "SOFTWARE_PLATFORM" TEXT,
    PRIMARY KEY ("DEVICE_ID")
);
CREATE TABLE "SHOP" (
    "SHOP_ID" INT,
    "SHOP_NAME" TEXT,
    "LOCATION" TEXT,
    "OPEN_DATE" TEXT,
    "OPEN_YEAR" INT,
    PRIMARY KEY ("SHOP_ID")
);
CREATE TABLE "STOCK" (
    "SHOP_ID" INT,
    "DEVICE_ID" INT,
    "QUANTITY" INT,
    PRIMARY KEY ("SHOP_ID", "DEVICE_ID"),
    FOREIGN KEY ("DEVICE_ID") REFERENCES "DEVICE"("DEVICE_ID"),
    FOREIGN KEY ("SHOP_ID") REFERENCES "SHOP"("SHOP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEVICE VALUES (0, 11, -1, 12, 13, 14);
INSERT INTO DEVICE VALUES (-1, 15, 0, 16, 17, 18);
INSERT INTO SHOP VALUES (1, 0, 0, 0, 0);
INSERT INTO SHOP VALUES (0, 0, 0, 0, 0);
INSERT INTO STOCK VALUES (0, -1, 0);
INSERT INTO STOCK VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.n AS n FROM device AS LHS INNER JOIN (SELECT * FROM (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) WHERE (n >= 1)) AS RHS ON (LHS.device_id = RHS.device_id)) ORDER BY carrier;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
*/