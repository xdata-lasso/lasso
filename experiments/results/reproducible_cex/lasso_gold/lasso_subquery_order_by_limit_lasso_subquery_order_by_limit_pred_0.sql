-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val_a INTEGER, val_b INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1017, 2048.0, 1037, 'Ryan Munoz');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1018, 2028.0, 1032.0, 'Abigail Shaffer');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1019, 2018.0, 1039.0, 'Gina Moore');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1020, 2008.0, 1046.0, 'Gabrielle Davis');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1029, 2048.0, 1025, 'Connie Lawrence');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1030, 1938.0, 1044.0, 'Monica Herrera');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1031, 1928.0, 1051.0, 'Jamie Arnold');
INSERT INTO "items" ("id", "val_a", "val_b", "name") VALUES (1032, 1918.0, 1058.0, 'Lisa Hensley');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM items ORDER BY val_a DESC, items.id NULLS LAST LIMIT 1);

/*
Gold Result:
('Ryan Munoz',)
*/

-- Prediction Query
SELECT name FROM (SELECT * FROM items ORDER BY val_b DESC, items.id NULLS LAST LIMIT 1);

/*
Prediction Result:
('Lisa Hensley',)
*/