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
INSERT INTO DEVICE VALUES (1, 15, 16, 17, 18, 0);
INSERT INTO DEVICE VALUES (0, 15, 16, 17, 18, 0);
INSERT INTO SHOP VALUES (1, 0, 0, 0, 0);
INSERT INTO SHOP VALUES (0, 0, 0, 0, 0);
INSERT INTO STOCK VALUES (1, 1, 0);
INSERT INTO STOCK VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.software_platform AS software_platform, LHS.n AS n, RHS.software_platform AS software_platform_other, RHS.n AS n_other FROM (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS LHS CROSS JOIN (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS RHS) WHERE (n > n_other) ORDER BY software_platform;

/*
Gold Result:
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/