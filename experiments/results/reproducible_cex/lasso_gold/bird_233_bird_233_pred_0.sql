-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', 'face');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'election');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('brother', 'dog');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ago', 'chair');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('site', 'since');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('blue', 'TR006', 'begin');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('require', 'purpose', 'performance');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sit', 'brother', 'knowledge');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('wait', 'ago', 'almost');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('offer', 'site', 'all');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('science', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('kind', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('discussion', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('list', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('perform', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('better', 'TR006', 'agreement');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('discover', 'purpose', 'option');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('early', 'brother', 'decide');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('mouth', 'ago', 'sense');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('play', 'site', 'rate');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('blue', 'science', 'better');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('require', 'kind', 'discover');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('sit', 'discussion', 'early');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('wait', 'list', 'mouth');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('offer', 'perform', 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
('better',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006' ORDER BY T1.bond_type ASC, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 2;

/*
Prediction Result:
('agreement',)
*/