-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'since');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('brother', 'blue');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ago', 'require');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('site', 'sit');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('face', 'wait');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('election', 'offer');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('dog', 'begin');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('chair', 'performance');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('knowledge', 'purpose', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('almost', 'brother', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('all', 'ago', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('better', 'site', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('discover', 'face', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('early', 'election', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('mouth', 'dog', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('play', 'chair', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('ago',)
('brother',)
('chair',)
('dog',)
('election',)
*/

-- Prediction Query
SELECT T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' ORDER BY T2.label, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 5;

/*
Prediction Result:
('begin',)
('blue',)
('offer',)
('performance',)
('require',)
*/