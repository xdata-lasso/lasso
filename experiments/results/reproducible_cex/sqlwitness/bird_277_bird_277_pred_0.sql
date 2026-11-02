-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('c', 'pb'), ('te', 'sn'), ('f', 'te'), ('sn', 'f'), ('ca', 'default1'), ('br', 'br'), ('default1', 'sn'), ('p', 'sn'), ('s', 'f'), ('pb', 'default1'), ('o', 'na'), ('n', 'n'), ('na', 'ca'), ('i', 'na'), ('h', 'n'), ('TR005_16_26', 'default1'), ('cl', 'te'), ('default2', NULL), ('unique_18', 'sn'), ('unique_19', 'h'), ('unique_20', 'h'), ('unique_21', 'cl');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('te', 'default1', 's'), ('p', 'TR005_16_26', 'cl'), ('TR005_16_26', 'unique_18', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('na', 'pb', 'p'), ('c', 'i', 'h'), ('h', 'te', 'default1'), ('sn', 'unique_20', 'n'), ('default2', 'ca', 'TR005_16_26'), ('pb', 'cl', 'br'), ('s', 'cl', 'br'), ('i', 'i', 'default1'), ('ca', 'h', 'n'), ('n', 'pb', 'h'), ('f', 'br', 'te'), ('p', 'br', 'ca'), ('te', 'c', 'TR005_16_26'), ('TR005_16_26', 'o', 'TR005_16_26'), ('cl', 'unique_18', 'c'), ('o', 'default1', 'f'), ('br', 'br', 'na'), ('default1', NULL, 'te');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('n', 'na', 'te'), ('s', 'default2', NULL), ('f', 'na', NULL), ('ca', 'sn', 'TR005_16_26'), ('sn', 'na', 'te'), ('te', 'na', 'TR005_16_26'), ('na', 'br', 'te'), ('i', 'default1', 'TR005_16_26'), ('na', 'cl', NULL), ('default2', 'o', 'te'), ('default2', 'c', 'TR005_16_26'), ('default1', 'pb', 'TR005_16_26'), ('na', 'f', 'TR005_16_26'), ('cl', 's', 'p'), ('i', 's', 'te'), ('sn', 'default2', NULL), ('br', 'te', 'p'), ('pb', 'c', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('n',)
('TR005_16_26',)
('default1',)
('TR005_16_26',)
('te',)
('p',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26' AND T1.element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
('n',)
('te',)
('p',)
*/