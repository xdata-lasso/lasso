-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('show', 'machine');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('value', 'training');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('not', 'show', 'capital');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('high', 'value', 'participant');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('human', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('finally', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('present', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sea', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('win', 'show', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('dark', 'value', '#');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('not', 'human', 'win');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('finally', 'present', 'win');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('high', 'sea', 'dark');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '#';

/*
Gold Result:
('not', 'human')
('finally', 'present')
('high', 'sea')
*/

-- Prediction Query
SELECT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.bond_type = '#' LIMIT 2;

/*
Prediction Result:
('not', 'human')
('finally', 'present')
*/