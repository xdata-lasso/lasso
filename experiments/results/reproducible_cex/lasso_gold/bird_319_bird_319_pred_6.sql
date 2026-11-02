-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('performance', 'knowledge');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('early', 'mouth');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('almost', 'performance', 'all');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('play', 'early', 'all');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('discover', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('option', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_4', 'performance', 'better');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('decide', 'early', 'agreement');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('almost', 'discover', 'TR001_3_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('play', 'option', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(atom_id) FROM connected WHERE bond_id = 'TR001_3_4';

/*
Prediction Result:
(2,)
*/