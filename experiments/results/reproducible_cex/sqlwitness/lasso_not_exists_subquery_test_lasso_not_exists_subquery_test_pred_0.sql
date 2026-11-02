-- Schema DDL
CREATE TABLE instructor (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE teaches (id INTEGER, year INTEGER, PRIMARY KEY (id, year), FOREIGN KEY (id) REFERENCES instructor (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO instructor (id, name) VALUES (2008, 'default2'), (2010, 'default1'), (2009, NULL), (0, 'default1'), (1, NULL);
INSERT INTO teaches (id, year) VALUES (1, 2008), (0, 2009), (2010, 2010), (2008, 2009), (2009, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE NOT EXISTS(SELECT * FROM teaches WHERE year = 2009);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM instructor;

/*
Prediction Result:
('default1',)
(None,)
('default2',)
(None,)
('default1',)
*/