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
INSERT INTO MEDICINE VALUES (-1, 0, 0, 0);
INSERT INTO MEDICINE VALUES (0, 0, 0, 0);
INSERT INTO ENZYME VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO ENZYME VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO MEDICINE_ENZYME_INTERACTION VALUES (-1, 0, 0);
INSERT INTO MEDICINE_ENZYME_INTERACTION VALUES (0, 0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT LHS.interaction_type AS interaction_type, LHS.n AS n, RHS.n AS n_other FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type)) AS RHS) WHERE (n = n_other) ORDER BY interaction_type, count___ NULLS LAST;

/*
Gold Result:
('-1', 1)
('0', 1)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1', 1)
*/