-- Schema DDL
CREATE TABLE molecules (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE atoms (id INTEGER PRIMARY KEY, molecule_id INTEGER, element TEXT, FOREIGN KEY (molecule_id) REFERENCES molecules (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecules (id, name) VALUES (1, 'Methane');
INSERT INTO molecules (id, name) VALUES (2, 'Ethane');
INSERT INTO atoms (id, molecule_id, element) VALUES (101, 1, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (102, 2, 'Carbon');
INSERT INTO atoms (id, molecule_id, element) VALUES (103, 2, 'Carbon');
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
(3,)
*/