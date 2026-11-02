-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('benefit', 'break');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('someone', 'break');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('anyone', 'break');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('traditional', 'break');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', 'I');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('pick', 'I');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('attack', 'I');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('image', 'I');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('claim', 'benefit', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('product', 'benefit', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('collection', 'benefit', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('structure', 'benefit', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('management', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('newspaper', 'knowledge', 'response');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('enter', 'knowledge', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('on', 'knowledge', 'response');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('break',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca') GROUP BY label ORDER BY COUNT(label) DESC, label NULLS LAST LIMIT 1;

/*
Prediction Result:
('I',)
*/