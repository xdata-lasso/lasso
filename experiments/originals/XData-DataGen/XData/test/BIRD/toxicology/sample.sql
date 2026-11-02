INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR009', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR011', '-');

INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_2', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_3', 'TR000', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_4', 'TR000', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_5', 'TR000', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_10', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_11', 'TR001', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_12', 'TR001', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_13', 'TR001', 'cl');

INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_1_2', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_2_3', 'TR000', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_2_4', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_2_5', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_10_11', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_12', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_7', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_8', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_14', 'TR001', '-');

INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1', 'TR000_2', 'TR000_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_1', 'TR000_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_3', 'TR000_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_3', 'TR000_2', 'TR000_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_4', 'TR000_2_4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_4', 'TR000_2', 'TR000_2_4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_5', 'TR000_2_5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_5', 'TR000_2', 'TR000_2_5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_10', 'TR001_11', 'TR001_10_11');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_11', 'TR001_10', 'TR001_10_11');

