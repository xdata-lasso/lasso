-- Schema DDL
CREATE TABLE molecules (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE atoms (id INTEGER PRIMARY KEY, molecule_id INTEGER, element TEXT, FOREIGN KEY (molecule_id) REFERENCES molecules (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecules (id, name) VALUES (1, 'default1');
INSERT INTO atoms (id, molecule_id, element) VALUES (0, NULL, 'default1'), (1, 1, NULL), (2, 1, 'default1'), (3, NULL, 'default2'), (4, NULL, 'default1'), (5, NULL, NULL), (6, NULL, 'default2'), (7, 1, 'default1'), (8, NULL, 'default1'), (9, 1, 'Carbon'), (10, NULL, 'default2'), (11, 1, 'Carbon'), (12, 1, NULL), (13, 1, 'default2');
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