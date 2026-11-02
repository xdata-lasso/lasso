-- Schema DDL
CREATE TABLE molecules (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE atoms (id INTEGER PRIMARY KEY, molecule_id INTEGER, element TEXT, FOREIGN KEY (molecule_id) REFERENCES molecules (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecules" ("id", "name") VALUES (18, 'Carbon16');
INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (17, 18, 'Carbon');
INSERT INTO "atoms" ("id", "molecule_id", "element") VALUES (23, 18, 'Carbon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT m.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(a.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Prediction Result:
(2,)
*/