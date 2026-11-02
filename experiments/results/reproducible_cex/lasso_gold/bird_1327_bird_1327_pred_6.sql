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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://jackson-lawson.com/', 'Laugh Out Loud', 'star', 'tell', 'Who blue agent find.', '3193 Heidi Hollow Apt. 905
Stanleyland, NY 85375', 'growth');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.lewis-salinas.com/', 'Laugh Out Loud', 'star', 'tell', 'Who blue agent find.', '3193 Heidi Hollow Apt. 905
Stanleyland, NY 85375', 'growth');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('actually', 'Samantha Garcia', 'high', 'prove');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1011, 'vote', 'Zimmermanchester', 'control', 'Washington', 'North Dakota');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('rather', 'Joseph', 'Morton', 'umarshall@example.net', 'executive', 'future', '714.273.7996', 1011, 'actually');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('miss', 'Joseph', 'Morton', 'umarshall@example.net', 'executive', 'future', '714.273.7996', 1011, 'actually');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://jackson-lawson.com/', 'rather');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.lewis-salinas.com/', 'miss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name = 'Laugh Out Loud';

/*
Gold Result:
('Joseph', 'Morton')
('Joseph', 'Morton')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Laugh Out Loud';

/*
Prediction Result:
('Joseph', 'Morton')
*/