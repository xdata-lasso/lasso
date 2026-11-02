CREATE TABLE Breeds (
breed_code VARCHAR(50) PRIMARY KEY ,
breed_name VARCHAR(50)
);
CREATE TABLE Charges (
charge_id INTEGER PRIMARY KEY ,
charge_type VARCHAR(50),
charge_amount NUMERIC(19,4)
);
CREATE TABLE Sizes (
size_code VARCHAR(50) PRIMARY KEY ,
size_description VARCHAR(50)
);
CREATE TABLE Treatment_Types (
treatment_type_code VARCHAR(50) PRIMARY KEY ,
treatment_type_description VARCHAR(50)
);
CREATE TABLE Owners (
owner_id INTEGER PRIMARY KEY ,
first_name VARCHAR(50),
last_name VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code VARCHAR(50),
email_address VARCHAR(50),
home_phone VARCHAR(50),
cell_number VARCHAR(50)
);
CREATE TABLE Dogs (
dog_id INTEGER PRIMARY KEY ,
owner_id INTEGER NOT NULL,
abandoned_yn VARCHAR(1),
breed_code VARCHAR(50) NOT NULL,
size_code VARCHAR(50) NOT NULL,
name VARCHAR(50),
age VARCHAR(50),
date_of_birth TIMESTAMP,
gender VARCHAR(1),
weight VARCHAR(50),
date_arrived TIMESTAMP,
date_adopted TIMESTAMP,
date_departed TIMESTAMP,
FOREIGN KEY (breed_code ) REFERENCES Breeds(breed_code ),
FOREIGN KEY (size_code ) REFERENCES Sizes(size_code ),
FOREIGN KEY (owner_id ) REFERENCES Owners(owner_id ),
FOREIGN KEY (owner_id ) REFERENCES Owners(owner_id )
);
CREATE TABLE Professionals (
professional_id INTEGER PRIMARY KEY ,
role_code VARCHAR(50) NOT NULL,
first_name VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code VARCHAR(50),
last_name VARCHAR(50),
email_address VARCHAR(50),
home_phone VARCHAR(50),
cell_number VARCHAR(50)
);
CREATE TABLE Treatments (
treatment_id INTEGER PRIMARY KEY ,
dog_id INTEGER NOT NULL,
professional_id INTEGER NOT NULL,
treatment_type_code VARCHAR(50) NOT NULL,
date_of_treatment TIMESTAMP,
cost_of_treatment NUMERIC(19,4),
FOREIGN KEY (treatment_type_code ) REFERENCES Treatment_Types(treatment_type_code ),
FOREIGN KEY (professional_id ) REFERENCES Professionals(professional_id ),
FOREIGN KEY (dog_id ) REFERENCES Dogs(dog_id )
);
