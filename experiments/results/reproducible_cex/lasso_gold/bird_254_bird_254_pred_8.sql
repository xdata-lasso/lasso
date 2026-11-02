-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'face');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('brother', 'election');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ago', 'dog');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('site', 'chair');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('since', 'purpose', 'wait');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('blue', 'purpose', 'offer');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('require', 'purpose', 'begin');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sit', 'purpose', 'performance');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('early', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('mouth', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('play', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('agreement', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('option', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('decide', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sense', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('rate', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('knowledge', 'purpose', 'discover');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('almost', 'purpose', 'discover');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('all', 'purpose', 'discover');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('better', 'purpose', 'discover');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'early', 'knowledge');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'mouth', 'almost');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'play', 'all');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'agreement', 'better');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'option', 'knowledge');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'decide', 'almost');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'sense', 'all');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('since', 'rate', 'better');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN element1 <> element2 THEN bond_id ELSE NULL END) AS REAL) * 100 / COUNT(bond_id) FROM (SELECT T2.bond_id, T1.element AS element1, T3.element AS element2 FROM atom AS T1 JOIN connected AS T4 ON T1.atom_id = T4.atom_id JOIN atom AS T3 ON T3.atom_id = T4.atom_id2 JOIN bond AS T2 ON T2.bond_id = T4.bond_id) WHERE element1 <> element2;

/*
Prediction Result:
(None,)
*/