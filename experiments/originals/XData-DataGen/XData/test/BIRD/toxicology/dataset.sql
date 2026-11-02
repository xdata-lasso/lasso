CREATE TABLE molecule (
    molecule_id varchar NOT NULL,
    label varchar,
    PRIMARY KEY (molecule_id)
);
CREATE TABLE atom (
    atom_id varchar NOT NULL,
    molecule_id varchar,
    element varchar,
    PRIMARY KEY (atom_id),
    FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id)
);
CREATE TABLE bond (
    bond_id varchar NOT NULL,
    molecule_id varchar not null,
    bond_type varchar,
    PRIMARY KEY (bond_id),
    FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id)
);
CREATE TABLE connected (
    atom_id varchar NOT NULL,
    atom_id2 varchar NOT NULL,
    bond_id varchar,
    PRIMARY KEY (atom_id, atom_id2),
    FOREIGN KEY (atom_id2) REFERENCES atom (atom_id),
    FOREIGN KEY (atom_id) REFERENCES atom (atom_id),
    FOREIGN KEY (bond_id) REFERENCES bond (bond_id)
);