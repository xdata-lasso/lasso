-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', '='), ('default1', 'default1'), ('=', 'default1'), ('unique_3', '='), ('unique_4', '='), ('unique_5', '='), ('unique_6', 'default1'), ('unique_7', '='), ('unique_8', '='), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', 'unique_3', '='), ('default2', 'unique_5', 'default2'), ('default1', 'unique_12', 'default2'), ('unique_3', 'unique_10', 'default2'), ('unique_4', 'unique_8', NULL), ('unique_5', 'unique_9', 'default2'), ('unique_6', NULL, '='), ('unique_7', 'unique_10', '='), ('unique_8', 'unique_12', '='), ('unique_9', 'unique_3', NULL), ('unique_10', 'unique_4', 'default2'), ('unique_11', 'default2', 'default1'), ('unique_12', 'unique_7', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT "molecule"."label" FROM "molecule" INNER JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "bond"."bond_type" = '=' GROUP BY "molecule"."molecule_id" ORDER BY COUNT("bond"."bond_id") DESC, "molecule"."label" NULLS LAST LIMIT 1;

/*
Prediction Result:
('=',)
*/