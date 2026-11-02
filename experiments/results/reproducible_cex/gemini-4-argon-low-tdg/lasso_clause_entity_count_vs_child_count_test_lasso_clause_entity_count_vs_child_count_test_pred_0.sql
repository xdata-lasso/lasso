-- Schema DDL
CREATE TABLE molecules (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE atoms (id INTEGER PRIMARY KEY, molecule_id INTEGER, element TEXT, FOREIGN KEY (molecule_id) REFERENCES molecules (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT m.id) vs COUNT(m.id) or COUNT(a.id) (multiple 'Carbon' atoms for one molecule).
-- 2. WHERE clause filtering (presence of non-'Carbon' atoms).
-- 3. Molecule with no 'Carbon' atoms.
-- 4. Molecule with no atoms at all (catches LEFT JOIN without proper filtering).
-- 5. COUNT(DISTINCT m.name) vs COUNT(DISTINCT m.id) (two different molecules having the same name).
-- 6. NULL values in molecule_id and element.
-- 7. Incorrect join condition (e.g., m.id = a.id where IDs are offset).
INSERT INTO molecules (id, name) VALUES (1, 'Methane');
INSERT INTO molecules (id, name) VALUES (2, 'Ethane');
INSERT INTO molecules (id, name) VALUES (3, 'Ethane');
INSERT INTO molecules (id, name) VALUES (4, 'Water');
INSERT INTO molecules (id, name) VALUES (5, 'EmptyMolecule');
INSERT INTO atoms (id, molecule_id, element) VALUES (10, 1, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (11, 1, 'Hydrogen');
INSERT INTO atoms (id, molecule_id, element) VALUES (12, 2, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (13, 2, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (14, 3, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (15, 4, 'Oxygen');
INSERT INTO atoms (id, molecule_id, element) VALUES (16, 4, 'Hydrogen');
INSERT INTO atoms (id, molecule_id, element) VALUES (17, NULL, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (18, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT m.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(a.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Prediction Result:
(4,)
*/