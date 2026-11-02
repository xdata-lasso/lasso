-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('perform', 'according');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('fall', 'according');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('table', 'according');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('true', 'according');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('grow', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('clearly', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('dinner', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bill', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('her', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('throw', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('guy', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('song', 'perform', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sure', 'perform', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('collection', 'perform', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('save', 'perform', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('great', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('blue', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('best', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('husband', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('PM', 'bill', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('everything', 'bill', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('surface', 'bill', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('animal', 'bill', 'ca');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('according',)
*/

-- Prediction Query
SELECT molecule.label FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE atom.element = 'ca' GROUP BY molecule.label ORDER BY COUNT(*) DESC, molecule.label NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/