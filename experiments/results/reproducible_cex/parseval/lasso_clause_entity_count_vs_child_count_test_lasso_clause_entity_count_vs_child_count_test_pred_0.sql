-- Schema DDL
CREATE TABLE molecules (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE atoms (id INTEGER PRIMARY KEY, molecule_id INTEGER, element TEXT, FOREIGN KEY (molecule_id) REFERENCES molecules (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecules --
INSERT INTO "molecules" ("id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "molecules" ("id", "name") VALUES (3, '9n8');

INSERT INTO "molecules" ("id", "name") VALUES (4, '4');

-- Inserting into table: atoms --
INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483648, 1, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483647, 4, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483646, 4, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483645, 4, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483644, 4, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (2, 1, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (3, 1, 'Carbon');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483641, 1, 'a_s_6f9336');

INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (-2147483640, 1, 'Carbon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT m.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(a.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Prediction Result:
(8,)
*/