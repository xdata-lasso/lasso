-- Schema DDL
CREATE TABLE "MEDICINE" (
    "ID" INT,
    "NAME" TEXT,
    "TRADE_NAME" TEXT,
    "FDA_APPROVED" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ENZYME" (
    "ID" INT,
    "NAME" TEXT,
    "LOCATION" TEXT,
    "PRODUCT" TEXT,
    "CHROMOSOME" TEXT,
    "OMIM" INT,
    "PORPHYRIA" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "MEDICINE_ENZYME_INTERACTION" (
    "ENZYME_ID" INT,
    "MEDICINE_ID" INT,
    "INTERACTION_TYPE" TEXT,
    PRIMARY KEY ("ENZYME_ID", "MEDICINE_ID"),
    FOREIGN KEY ("MEDICINE_ID") REFERENCES "MEDICINE"("ID"),
    FOREIGN KEY ("ENZYME_ID") REFERENCES "ENZYME"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MEDICINE VALUES (1, 16, 0, 12);
INSERT INTO MEDICINE VALUES (0, 10, 0, 11);
INSERT INTO ENZYME VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO ENZYME VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO MEDICINE_ENZYME_INTERACTION VALUES (-1, 0, 0);
INSERT INTO MEDICINE_ENZYME_INTERACTION VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('0', 1)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
('0', 2)
*/