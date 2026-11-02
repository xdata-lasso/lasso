-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', 'knowledge');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sure', 'grow');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('collection', 'fall');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('save', 'clearly');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('participant', 'throw');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('husband', 'guy');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bill', 'PM');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('her', 'everything');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('dark', 'old');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('win', 'finally');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('human', 'themselves');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bar', 'production');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('dinner', 'TR018', 'best');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('source', 'TR018', 'best');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('great', 'TR018', 'best');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'TR018', 'best');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('surface', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('animal', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('show', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('machine', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('present', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('value', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('training', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('high', 'TR018', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.bond_type, T1.label FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR018' GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_type) DESC, T2.bond_type NULLS LAST, T1.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('best', 'knowledge')
*/