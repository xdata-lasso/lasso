-- Schema DDL
CREATE TABLE "i010_1" ("id" TEXT, "name" TEXT, "phone_number" INTEGER);

CREATE TABLE "i010_2" ("id" TEXT, "date" TEXT, "phone_number" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i010_1 (id, name, phone_number) VALUES ('A', 'Alice', 20);
INSERT INTO i010_1 (id, name, phone_number) VALUES ('Z', 'Zack', 999);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('B', '2023-01-01', 300);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', '2023-02-01', 100);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', NULL, 50);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', '2023-01-01', 100);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', '2023-01-01', NULL);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', '2023-01-01', 20);
INSERT INTO i010_2 (id, date, phone_number) VALUES ('A', '2023-01-01', 20);
INSERT INTO i010_2 (id, date, phone_number) VALUES (NULL, '2023-05-01', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, date, phone_number FROM i010_2 ORDER BY id, date NULLS LAST, phone_number NULLS LAST;

/*
Gold Result:
(None, '2023-05-01', 10)
('A', '2023-01-01', 20)
('A', '2023-01-01', 100)
('A', '2023-01-01', None)
('A', '2023-02-01', 100)
('A', None, 50)
('B', '2023-01-01', 300)
*/

-- Prediction Query
SELECT * FROM i010_2 WHERE NOT EXISTS(SELECT * FROM i010_1 WHERE i010_1.phone_number = i010_2.phone_number);

/*
Prediction Result:
('B', '2023-01-01', 300)
('A', '2023-02-01', 100)
('A', None, 50)
('A', '2023-01-01', 100)
('A', '2023-01-01', None)
(None, '2023-05-01', 10)
*/