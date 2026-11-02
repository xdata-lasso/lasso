-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math Dept', 'Sciences');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV_OCT_2022', 'October Meeting', '2022-10-10', 'Meeting', '2022 session', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV_OCT_2023', 'October Meeting', '2023-10-10', 'Meeting', '2023 session', 'Hall B', 'Open');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_BOTH', 'Diana', 'Prince', 'diana@example.com', 'Secretary', 'M', '555-0201', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_SINGLE', 'Evan', 'Wright', 'evan@example.com', 'Member', 'XL', '555-0202', 20001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_OCT_2022', 'MEM_BOTH');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_OCT_2023', 'MEM_BOTH');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_OCT_2022', 'MEM_SINGLE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.member_id FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('MEM_BOTH',)
('MEM_SINGLE',)
*/

-- Prediction Query
SELECT m.* FROM member AS m JOIN attendance AS a ON m.member_id = a.link_to_member JOIN event AS e ON a.link_to_event = e.event_id WHERE e.event_name = 'October Meeting';

/*
Prediction Result:
('MEM_BOTH', 'Diana', 'Prince', 'diana@example.com', 'Secretary', 'M', '555-0201', 20001, 'MAJ1')
('MEM_BOTH', 'Diana', 'Prince', 'diana@example.com', 'Secretary', 'M', '555-0201', 20001, 'MAJ1')
('MEM_SINGLE', 'Evan', 'Wright', 'evan@example.com', 'Member', 'XL', '555-0202', 20001, 'MAJ1')
*/