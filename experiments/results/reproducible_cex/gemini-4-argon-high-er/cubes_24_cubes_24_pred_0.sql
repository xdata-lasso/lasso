-- Schema DDL
CREATE TABLE "i010_1" ("id" TEXT, "name" TEXT, "phone_number" INTEGER);

CREATE TABLE "i010_2" ("id" TEXT, "date" TEXT, "phone_number" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i010_1 (id, name, phone_number) VALUES ('1', 'Alice', 12345);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('1', '2023-01-01', 12345);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, date, phone_number FROM i010_2 ORDER BY id, date NULLS LAST, phone_number NULLS LAST;

/*
Gold Result:
('1', '2023-01-01', 12345)
*/

-- Prediction Query
SELECT * FROM i010_2 WHERE NOT EXISTS(SELECT * FROM i010_1 WHERE i010_1.phone_number = i010_2.phone_number);

/*
Prediction Result:
*/