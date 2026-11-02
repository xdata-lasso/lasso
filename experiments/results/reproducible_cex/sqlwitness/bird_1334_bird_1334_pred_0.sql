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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Student_Club', 'Student_Club', 'Student_Club', 'Illinois', NULL), (0, NULL, 'Student_Club', 'default1', 'Illinois', 'Student_Club'), (2, 'Student_Club', 'Student_Club', 'Illinois', 'default2', 'Illinois'), (3, 'Student_Club', NULL, NULL, 'default2', 'Illinois'), (4, NULL, NULL, 'Illinois', 'default1', 'Student_Club');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'Illinois', 'default1', 'default2'), ('Student_Club', NULL, 'Student_Club', 'default1'), ('default2', 'Illinois', 'Student_Club', 'default2'), ('Illinois', 'default2', 'Student_Club', NULL), ('unique_4', NULL, 'default1', 'Student_Club'), ('unique_5', 'Illinois', 'default2', 'Student_Club'), ('unique_6', 'default1', 'default1', 'default2'), ('unique_7', 'default2', 'Student_Club', NULL), ('unique_8', 'Student_Club', 'default1', 'Student_Club'), ('unique_9', 'default1', 'Illinois', 'Illinois'), ('unique_10', 'default1', 'Illinois', 'Student_Club'), ('unique_11', 'Student_Club', 'default2', 'default1'), ('unique_12', 'Student_Club', 'default1', 'Illinois'), ('unique_13', 'default2', 'default2', 'default2'), ('unique_14', 'Illinois', NULL, 'default2'), ('unique_15', 'default2', 'default2', 'default1'), ('unique_16', NULL, 'default2', 'Student_Club'), ('unique_17', NULL, 'default2', 'default2'), ('unique_18', 'default1', 'default1', NULL), ('unique_19', NULL, 'Illinois', NULL), ('unique_20', 'Illinois', 'default2', 'Student_Club'), ('unique_21', NULL, 'Student_Club', 'Illinois');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_9', 3, 'Illinois', 'Illinois', NULL, 'Student_Club', NULL, NULL), ('Illinois', 'unique_8', NULL, 'default2', 'Student_Club', 'Illinois', 'default1', 'Student_Club', NULL), ('Student_Club', 'unique_8', 3, 'Student_Club', 'Illinois', 'Illinois', 'default2', 'default1', 'Student_Club'), ('default2', 'unique_14', NULL, 'Student_Club', NULL, NULL, 'default2', 'default2', 'default2'), ('unique_4', 'unique_16', 1, 'Illinois', NULL, 'Student_Club', 'default1', NULL, NULL), ('unique_5', 'unique_15', 1, 'Student_Club', NULL, 'Student_Club', NULL, 'default2', 'default1'), ('unique_6', 'unique_9', 1, 'Student_Club', 'default2', NULL, 'default1', NULL, 'Illinois'), ('unique_7', 'Illinois', NULL, NULL, NULL, 'default2', 'default2', 'default1', 'default2'), ('unique_8', 'unique_9', 1, 'Illinois', 'Student_Club', 'Student_Club', 'default2', 'default2', NULL), ('unique_9', 'unique_7', NULL, 'default1', 'default1', 'default2', 'Illinois', 'Illinois', 'default1'), ('unique_10', 'Student_Club', 2, 'Illinois', 'default1', NULL, 'default2', 'Illinois', 'Student_Club'), ('unique_11', 'unique_21', 0, 'default1', NULL, 'Student_Club', 'Illinois', 'Student_Club', 'Student_Club'), ('unique_12', 'unique_8', 2, 'default1', 'default1', 'Student_Club', 'Student_Club', 'Illinois', 'default1'), ('unique_13', 'unique_19', NULL, 'default2', 'default2', NULL, 'default2', 'Student_Club', 'default1'), ('unique_14', 'unique_16', NULL, NULL, 'Illinois', 'default2', 'Student_Club', 'default2', 'default2'), ('unique_15', 'unique_14', 3, NULL, 'default2', 'Student_Club', 'Student_Club', 'Student_Club', 'default1'), ('unique_16', 'Student_Club', 3, NULL, 'default1', NULL, 'default1', 'Illinois', 'default1'), ('unique_17', 'Student_Club', 0, 'Student_Club', 'Illinois', 'default1', 'default2', 'Student_Club', 'Illinois'), ('unique_18', 'unique_8', 0, NULL, 'default1', 'Illinois', 'Student_Club', NULL, 'Illinois'), ('unique_19', 'unique_17', 1, 'Illinois', NULL, 'Student_Club', NULL, 'default2', 'Student_Club'), ('unique_20', 'unique_21', 2, 'Student_Club', NULL, 'default2', 'default1', NULL, 'default1'), ('unique_21', 'Student_Club', NULL, 'Illinois', 'Illinois', NULL, 'default2', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN zip_code AS T2 ON T1.zip = T2.zip_code WHERE T2.state = 'Illinois';

/*
Gold Result:
('Illinois', None)
('Student_Club', None)
('Student_Club', 'default2')
('Illinois', 'Student_Club')
('default1', None)
('Student_Club', 'Illinois')
(None, 'default1')
('Illinois', None)
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN zip_code ON member.zip = zip_code.zip_code WHERE zip_code.state = 'Illinois' AND member.position = 'Student_Club';

/*
Prediction Result:
(None, 'default1')
*/