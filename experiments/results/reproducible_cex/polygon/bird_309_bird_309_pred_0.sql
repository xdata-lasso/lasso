-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR34644', 'TR346', 'TR34645');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR34646', 'TR346', 'TR34647');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR34619', 'TR346', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR34618', 'TR346', 'TR34625');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR34644', 'TR34644', 'TR34618');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR34644', 'TR34646', 'TR34619');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR34617', 'TR346');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR346', 'TR346');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('TR34644', 0)
('TR34644', 1)
('TR34646', 0)
('TR34646', 1)
*/

-- Prediction Query
SELECT T1.atom_id, COUNT(T3.bond_type) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.label = 'TR346' GROUP BY T1.atom_id;

/*
Prediction Result:
('TR34644', 1)
('TR34646', 1)
*/