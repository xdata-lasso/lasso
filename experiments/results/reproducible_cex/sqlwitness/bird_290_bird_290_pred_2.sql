-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('br', 'br'), ('default1', 'pb'), ('te', 'sn'), ('default2', 'pb'), ('i', 'f'), ('f', 'i'), ('pb', 'TR151'), ('cl', 'i'), ('sn', 'sn'), ('TR151', 'default2'), ('unique_10', 'sn'), ('unique_11', 'default2'), ('unique_12', 'i'), ('unique_13', 'i'), ('unique_14', 'sn'), ('unique_15', 'cl'), ('unique_16', 'default2'), ('unique_17', 'default1'), ('unique_18', 'default2'), ('unique_19', 'i'), ('unique_20', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR151', 'br', 'te'), ('f', 'unique_15', 'sn'), ('i', 'unique_18', 'TR151'), ('br', 'default2', 'cl'), ('cl', 'unique_16', 'br'), ('default2', 'i', 'cl'), ('sn', 'unique_16', 'default1'), ('default1', 'default1', 'pb'), ('te', 'unique_12', 'TR151'), ('pb', 'cl', 'i'), ('unique_10', 'i', 'pb'), ('unique_11', 'sn', 'br'), ('unique_12', 'unique_17', 'sn'), ('unique_13', 'pb', 'f'), ('unique_14', 'unique_15', 'pb'), ('unique_15', 'unique_19', NULL), ('unique_16', 'TR151', 'default1'), ('unique_17', 'unique_12', 'f'), ('unique_18', 'br', NULL), ('unique_19', 'br', NULL), ('unique_20', 'unique_10', 'te'), ('unique_21', 'unique_13', 'f'), ('unique_22', 'sn', 'br'), ('unique_23', 'unique_19', 'default1'), ('unique_24', 'unique_18', 'pb'), ('unique_25', 'unique_14', 'te'), ('unique_26', 'pb', NULL), ('unique_27', 'default1', 'TR151'), ('unique_28', 'unique_19', 'TR151');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT "element" FROM "atom" WHERE "molecule_id" = 'TR151' AND "element" IN ('cl', 'br', 'f', 'i', 'sn', 'pb', 'te');

/*
Prediction Result:
*/