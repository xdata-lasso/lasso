-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('list', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sure', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('perform', 'list', 'fall');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('according', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('song', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('table', 'list', 'true');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('perform', 'according', 'table');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('perform', 'song', 'table');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
('perform',)
*/

-- Prediction Query
SELECT T3.atom_id, T3.atom_id2 FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T2.bond_id = T3.bond_id WHERE T1.label = '-';

/*
Prediction Result:
('perform', 'according')
('perform', 'song')
*/