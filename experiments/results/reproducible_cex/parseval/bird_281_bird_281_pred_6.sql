-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA4A', 'ato_97ca5a', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'ato_97ca5a', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'ato_3315b3', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?AAAAA4A', 'A', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'ato_97ca5a', 'ato_4e9ed2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAA4A', 'ato_97ca5a', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!AAAAAAA', 'ato_97ca5a', 'ato_403309');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4A', '@', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E@@AAAAA', 'D', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O@@OAA4A', '$', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_97ca5a', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_3315b3', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_c4600f', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('$', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
*/

-- Prediction Query
SELECT element FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND SUBSTRING(atom.atom_id, 7, 1) = '4';

/*
Prediction Result:
('ato_403309',)
('ato_403309',)
(None,)
*/