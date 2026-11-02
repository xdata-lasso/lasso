-- Schema DDL
CREATE TABLE nation (n_id INTEGER PRIMARY KEY, n_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO nation (n_id, n_name) VALUES (1, 'FRANCE'), (0, 'default1'), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA';

/*
Gold Result:
*/

-- Prediction Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'FRANCE';

/*
Prediction Result:
('FRANCE', 'FRANCE')
*/