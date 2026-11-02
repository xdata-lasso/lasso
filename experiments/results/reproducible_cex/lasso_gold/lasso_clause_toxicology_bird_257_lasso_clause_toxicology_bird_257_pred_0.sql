-- Schema DDL
CREATE TABLE atom (atom_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, element TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE bond (bond_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, bond_type TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE connected (atom_id TEXT NOT NULL, atom_id2 TEXT NOT NULL, bond_id TEXT DEFAULT NULL, PRIMARY KEY (atom_id, atom_id2), FOREIGN KEY (atom_id) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (atom_id2) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (bond_id) REFERENCES bond (bond_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE molecule (molecule_id TEXT NOT NULL PRIMARY KEY, label TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('according', 'song');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sure', 'according', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('grow', 'according', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('knowledge', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('collection', 'according', 'save');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('sure', 'knowledge', 'collection');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('grow', 'knowledge', 'collection');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('knowledge',)
*/

-- Prediction Query
SELECT atom_id2 FROM connected JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.element = 's';

/*
Prediction Result:
('knowledge',)
('knowledge',)
*/