-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sure', 'grow');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('collection', 'fall');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('save', 'clearly');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', 'dinner');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('husband', 'guy');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bill', 'PM');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('her', 'everything');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('throw', 'surface');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('high', 'bar');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('capital', 'old');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('win', 'finally');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('human', 'themselves');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('source', 'sure', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('great', 'sure', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'sure', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('best', 'sure', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('animal', 'husband', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('show', 'husband', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('machine', 'husband', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('not', 'husband', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('production', 'husband', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('present', 'husband', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('value', 'husband', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('training', 'husband', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('guy',)
*/

-- Prediction Query
SELECT T2.label FROM bond AS T1 LEFT JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' GROUP BY T1.molecule_id ORDER BY COUNT(*) DESC, T2.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('grow',)
*/