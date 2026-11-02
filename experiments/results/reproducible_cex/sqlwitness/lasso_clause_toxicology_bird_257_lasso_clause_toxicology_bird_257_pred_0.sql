-- Schema DDL
CREATE TABLE atom (atom_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, element TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE bond (bond_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, bond_type TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE connected (atom_id TEXT NOT NULL, atom_id2 TEXT NOT NULL, bond_id TEXT DEFAULT NULL, PRIMARY KEY (atom_id, atom_id2), FOREIGN KEY (atom_id) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (atom_id2) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (bond_id) REFERENCES bond (bond_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE molecule (molecule_id TEXT NOT NULL PRIMARY KEY, label TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('default2', 's'), ('s', NULL), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 's'), ('unique_9', 'default2'), ('unique_10', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_6', 'default1'), ('s', 'unique_7', 'default1'), ('default2', 'unique_9', 'default2'), ('unique_3', 's', 's'), ('unique_4', 'unique_3', 'default2'), ('unique_5', 'unique_9', NULL), ('unique_6', 'unique_6', 'default1'), ('unique_7', 'unique_4', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_8', 'default1'), ('s', 'unique_9', 'default1'), ('default2', 'default1', 's'), ('unique_3', 'unique_10', NULL), ('unique_4', 'unique_10', 'default1'), ('unique_5', 'unique_9', 'default1'), ('unique_6', 's', 'default1'), ('unique_7', 'default2', NULL), ('unique_8', 'default2', 'default2'), ('unique_9', 'unique_7', 'default1'), ('unique_10', 'unique_6', 's'), ('unique_11', 'unique_4', 'default1'), ('unique_12', 'default1', 's'), ('unique_13', 'default2', 's'), ('unique_14', NULL, 'default1'), ('unique_15', 'unique_5', 'default1'), ('unique_16', 'default2', 'default2'), ('unique_17', 's', NULL), ('unique_18', 'unique_5', NULL), ('unique_19', 'default2', NULL), ('unique_20', 'unique_4', 'default2'), ('unique_21', 'unique_4', 's'), ('unique_22', 'unique_8', 'default2'), ('unique_23', 'unique_9', 'default1'), ('unique_24', 'unique_4', 's'), ('unique_25', 'unique_7', 's'), ('unique_26', 'unique_4', 'default1'), ('unique_27', 'unique_4', 's'), ('unique_28', 'unique_9', NULL), ('unique_29', 'unique_4', 'default2'), ('unique_30', 'unique_5', 'default1'), ('unique_31', 'unique_7', NULL), ('unique_32', 'unique_4', 's'), ('unique_33', 'unique_8', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_28', 'unique_9', 'default1'), ('unique_31', 's', 'unique_4'), ('unique_26', 'unique_33', 'unique_6'), ('unique_7', 'unique_23', 'default1'), ('unique_29', 'unique_16', 'default1'), ('unique_25', 'unique_6', 'unique_6'), ('unique_30', 'unique_12', 'unique_7'), ('s', 'unique_26', 'default1'), ('s', 'unique_32', 'default2'), ('unique_33', 'unique_21', 'default1'), ('unique_21', 'unique_19', 'default2'), ('unique_24', 'unique_15', 'unique_4'), ('unique_21', 'unique_27', 'unique_6'), ('unique_20', 'unique_16', 'unique_5'), ('unique_30', 'unique_16', 'unique_4'), ('unique_11', 'unique_13', 'default1'), ('unique_6', 'unique_23', 'unique_4'), ('unique_28', 'default2', NULL), ('unique_29', 'unique_26', 'unique_5'), ('unique_25', 'unique_27', 'default1'), ('s', 'unique_18', 'unique_3'), ('unique_27', 'unique_21', 'unique_6'), ('unique_22', 'unique_6', 'unique_7'), ('unique_22', 'unique_17', 'unique_4'), ('unique_18', 'unique_17', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('unique_19',)
('unique_27',)
('unique_15',)
('unique_6',)
('unique_21',)
*/

-- Prediction Query
SELECT atom_id2 FROM connected JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.element = 's';

/*
Prediction Result:
('unique_19',)
('unique_27',)
('unique_15',)
('unique_27',)
('unique_6',)
('unique_21',)
*/