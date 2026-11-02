-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sn22', 'sn20', 'sn21');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sn27', 'sn28', 'sn');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn25', 'sn28', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn26', 'sn28', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('sn22', 'sn27', 'sn25');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('sn27', 'sn22', 'sn26');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sn20', 'sn28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sn28', 'sn28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT bond.bond_type FROM bond INNER JOIN atom ON bond.molecule_id = atom.molecule_id WHERE atom.element = 'sn';

/*
Prediction Result:
(None,)
(None,)
*/