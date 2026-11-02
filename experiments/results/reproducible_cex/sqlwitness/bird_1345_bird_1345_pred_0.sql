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
INSERT INTO major (major_id, major_name, department, college) VALUES ('College of Humanities and Social Sciences', 'default1', 'College of Humanities and Social Sciences', 'College of Humanities and Social Sciences'), ('default1', NULL, NULL, 'default1'), ('default2', 'College of Humanities and Social Sciences', 'default2', 'default1'), ('unique_3', 'default2', NULL, NULL), ('unique_4', 'default1', 'College of Humanities and Social Sciences', 'default1'), ('unique_5', 'College of Humanities and Social Sciences', 'default1', NULL), ('unique_6', NULL, 'default2', 'College of Humanities and Social Sciences'), ('unique_7', 'default1', 'default2', 'default1'), ('unique_8', 'College of Humanities and Social Sciences', 'College of Humanities and Social Sciences', 'default1'), ('unique_9', 'default1', 'default2', NULL), ('unique_10', 'default1', 'default2', 'default1'), ('unique_11', NULL, 'College of Humanities and Social Sciences', NULL), ('unique_12', 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(major_name) FROM major WHERE college = 'College of Humanities and Social Sciences';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(major_id) FROM major WHERE college = 'College of Humanities and Social Sciences';

/*
Prediction Result:
(2,)
*/