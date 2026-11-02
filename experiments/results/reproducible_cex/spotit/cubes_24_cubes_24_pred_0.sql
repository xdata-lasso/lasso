-- Schema DDL
CREATE TABLE "I010_1" (
    "ID" TEXT,
    "NAME" TEXT,
    "PHONE_NUMBER" INT
);
CREATE TABLE "I010_2" (
    "ID" TEXT,
    "DATE" TEXT,
    "PHONE_NUMBER" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I010_1 VALUES (0, 0, 0);
INSERT INTO I010_1 VALUES (0, 0, 0);
INSERT INTO I010_2 VALUES (1, 0, 0);
INSERT INTO I010_2 VALUES (0, -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, date, phone_number FROM i010_2 ORDER BY id, date NULLS LAST, phone_number NULLS LAST;

/*
Gold Result:
('0', '-1', 0)
('1', '0', 0)
*/

-- Prediction Query
SELECT * FROM i010_2 WHERE NOT EXISTS(SELECT * FROM i010_1 WHERE i010_1.phone_number = i010_2.phone_number);

/*
Prediction Result:
*/