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
WITH ElementCombination AS (SELECT T1.element AS element1, T2.element AS element2 FROM atom AS T1 INNER JOIN connected AS C ON T1.atom_id = C.atom_id INNER JOIN atom AS T2 ON C.atom_id2 = T2.atom_id), MostCommonCombination AS (SELECT element1, element2, COUNT(*) AS combo_count FROM ElementCombination GROUP BY element1, element2 ORDER BY combo_count DESC, element1 NULLS LAST, element2 NULLS LAST LIMIT 1), TotalBonds AS (SELECT COUNT(*) AS total_bonds FROM bond), BondsInCommonCombination AS (SELECT COUNT(*) AS common_bonds FROM connected AS C INNER JOIN atom AS A1 ON C.atom_id = A1.atom_id INNER JOIN atom AS A2 ON C.atom_id2 = A2.atom_id INNER JOIN MostCommonCombination AS MCC ON A1.element = MCC.element1 AND A2.element = MCC.element2) SELECT CAST(common_bonds AS REAL) * 100 / total_bonds AS percentage FROM TotalBonds CROSS JOIN BondsInCommonCombination;

/*
Prediction Result:
(0.0,)
*/