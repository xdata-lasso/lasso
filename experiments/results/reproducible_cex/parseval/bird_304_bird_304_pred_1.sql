-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__177efe', 't1__9e6e7f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't2__177efe', 't1__9e6e7f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', '?', 't1__9e6e7f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '?', 't1__9e6e7f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', '?', 't1__9e6e7f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'B', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'H', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', '@', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'B', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', '@', 'Q');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', '@', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'Q', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', '@', 'A');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__177efe', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'n8c4pgu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'hria2ypu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
('t2__177efe', 't1__9e6e7f')
('H', None)
('@', 'G')
('@', 'Q')
('@', 'A')
*/

-- Prediction Query
SELECT molecule.molecule_id, atom.element FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
('t2__177efe', 't1__9e6e7f')
('t2__177efe', 't1__9e6e7f')
('H', None)
('@', 'G')
('@', 'Q')
('@', 'A')
('@', 'A')
*/