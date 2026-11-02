-- Schema DDL
CREATE TABLE "i010_1" ("id" TEXT, "name" TEXT, "phone_number" INTEGER);

CREATE TABLE "i010_2" ("id" TEXT, "date" TEXT, "phone_number" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i010_2 --
INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', 1);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', NULL);

INSERT INTO "i010_2" ("id", "date", "phone_number") VALUES ('i01_ef632f', 'i01_7b40b8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, date, phone_number FROM i010_2 ORDER BY id, date NULLS LAST, phone_number NULLS LAST;

/*
Gold Result:
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', None)
*/

-- Prediction Query
SELECT * FROM i010_2 WHERE NOT EXISTS(SELECT * FROM i010_1 WHERE i010_1.phone_number = i010_2.phone_number);

/*
Prediction Result:
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', 1)
('i01_ef632f', 'i01_7b40b8', None)
('i01_ef632f', 'i01_7b40b8', None)
*/