-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('-', 'default1'), ('default1', NULL), ('unique_3', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default2', NULL), ('-', '-', '-'), ('default2', NULL, 'default2'), ('unique_3', 'default2', 'default1'), ('unique_4', 'default2', 'default2'), ('unique_5', 'unique_3', 'default2'), ('unique_6', 'unique_3', 'default2'), ('unique_7', '-', 'default1'), ('unique_8', 'default2', 'default1'), ('unique_9', 'unique_3', NULL), ('unique_10', 'unique_3', NULL), ('unique_11', 'default2', 'default1'), ('unique_12', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('default2',)
(None,)
*/

-- Prediction Query
SELECT element FROM (SELECT element, COUNT(*) AS element_count FROM (SELECT * FROM molecule WHERE label = '-') AS m JOIN atom ON m.molecule_id = atom.molecule_id GROUP BY element) AS element_counts ORDER BY element_count ASC, element NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/