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
INSERT INTO DEVICE VALUES (0, 13, 14, 15, 16, -1);
INSERT INTO DEVICE VALUES (1, 13, 10, 11, 12, -1);
INSERT INTO SHOP VALUES (-1, 0, 0, 0, 0);
INSERT INTO SHOP VALUES (0, 0, 0, 0, 0);
INSERT INTO STOCK VALUES (-1, 0, 0);
INSERT INTO STOCK VALUES (0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.device AS device, LHS.software_platform AS software_platform, LHS.maxn AS maxn, RHS.carrier AS carrier, RHS.package_version AS package_version, RHS.applications AS applications, RHS.software_platform AS software_platform_other FROM (SELECT device, software_platform, MAX(n) AS maxn FROM (SELECT device, software_platform, COUNT(*) AS n FROM device GROUP BY device, software_platform) GROUP BY device, software_platform) AS LHS INNER JOIN device AS RHS ON (LHS.maxn = RHS.device_id AND LHS.device = RHS.device)) ORDER BY software_platform;

/*
Gold Result:
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/