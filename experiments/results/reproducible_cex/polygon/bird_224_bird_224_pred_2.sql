-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_216', NULL, 'TR000_2');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 'TR000_213', 'TR000_2');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_217', 'TR000_212', 'TR000_2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_216', 'TR000_2', 'TR000_217');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'TR000_2', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000_212', 'TR000_2');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000_213', 'TR000_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_id FROM connected AS T WHERE T.atom_id2 = 'TR000_2';

/*
Gold Result:
('TR000_217',)
(None,)
*/

-- Prediction Query
SELECT T1.bond_id FROM connected AS T1 INNER JOIN connected AS T2 ON T1.atom_id2 = T2.atom_id2 WHERE T2.atom_id2 = 'TR000_2';

/*
Prediction Result:
('TR000_217',)
('TR000_217',)
(None,)
(None,)
*/