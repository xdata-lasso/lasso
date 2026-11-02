-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cat TEXT, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: items --
INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483648, 'ite_a673e0', 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483647, 'ite_c8404c', '5k5swwqcgs');

INSERT INTO "items" ("id", "cat", "status") VALUES (2, 'ite_a673e0', 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (3, 'ite_a673e0', 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483646, 'ite_c8404c', '9n8');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483643, 'ite_5bbce0', '4');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483642, 'ite_a673e0', 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483641, 'ite_a9214c', 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483640, 'ite_a673e0', 'ite_06f277');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483639, 'ite_c8404c', 'gu7v');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483638, NULL, 'active');

INSERT INTO "items" ("id", "cat", "status") VALUES (-2147483637, NULL, 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cat FROM items AS a WHERE NOT EXISTS(SELECT 1 FROM items AS b WHERE a.cat = b.cat AND b.status = 'active');

/*
Gold Result:
('ite_c8404c',)
('ite_5bbce0',)
(None,)
*/

-- Prediction Query
SELECT cat FROM items EXCEPT SELECT cat FROM items WHERE status = 'active';

/*
Prediction Result:
('ite_5bbce0',)
('ite_c8404c',)
*/