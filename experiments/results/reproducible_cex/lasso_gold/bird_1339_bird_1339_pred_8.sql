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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('better', 'Sarah Martin', 'mention', 'medical', 'Ten total clearly able hospital.', 'PSC 7468, Box 7234
APO AE 08166', 'particularly');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('these', 'Elizabeth Riggs', 'surface', 'ready', 'Account stage federal professional voice care break.', '4935 Grace Walk
Williamview, MH 07159', 'best');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('doctor', 'Thomas Bailey', 'tend', 'stuff', 'Development process huge everything attorney.', '868 Crosby Crescent Suite 294
North Candacestad, VA 41615', 'least');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('simply', 'Nicole Brown', 'pattern', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('protect', 'Donald Smith', 'spend', 'case');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('police', 'Mrs. Stephanie Lee', 'another', 'section');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1019, 'morning', 'North Susan', 'be', 'Idaho', 'California');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1025, 'public', 'Evanmouth', 'ok', 'Virginia', 'Nevada');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1031, 'ability', 'West Ryan', 'red', 'Michigan', 'South Carolina');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('physical', 'author', 1020.5, 1021.5, 1022, 'Republican', 'better');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('option', 'act', 1026.5, 1027.5, 1028, 'brother', 'these');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('former', 'record', 1032.5, 1033.5, 1034, 'thus', 'doctor');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('training', 'Elijah', 'Allen', 'richarddavid@example.net', 'employee', 'particular', '+1-509-616-9985x435', 1019, 'simply');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('bag', 'Elijah', 'Allen', 'amydavenport@example.net', 'old', 'choose', '(420)545-0533x15869', 1025, 'protect');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('capital', 'Elijah', 'Allen', 'william65@example.com', 'same', 'find', '+1-823-266-2994', 1031, 'police');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('individual', 'Lead upon very act perform.', '_____09', 1023.5, 'hope', 'training', 'physical');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('catch', 'You available defense enter value thing these.', '_____10', 1032.5, 'feel', 'training', 'physical');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('treatment', 'Thing agent say forward.', '_____09', NULL, 'turn', 'bag', 'option');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('commercial', 'Soon ten specific environment skin blue.', '_____10', NULL, 'American', 'bag', 'option');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('fly', 'Involve oil pressure let kind.', '_____09', 1035.5, 'federal', 'capital', 'former');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('few', 'Memory soldier where save probably.', '_____10', 1044.5, 'myself', 'capital', 'former');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('government', 'Lead upon very act perform.', '_____09', NULL, 'hope', 'training', 'physical');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.last_name = 'Allen' AND T1.first_name = 'Elijah' AND (SUBSTRING(T2.expense_date, 6, 2) = '09' OR SUBSTRING(T2.expense_date, 6, 2) = '10');

/*
Gold Result:
(1034.0,)
*/

-- Prediction Query
SELECT SUM(e.cost) / COUNT(e.expense_id) AS average_cost FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member WHERE m.member_id = (SELECT member_id FROM member WHERE first_name = 'Elijah' AND last_name = 'Allen') AND (SUBSTRING(e.expense_date, 6, 2) = '09' OR SUBSTRING(e.expense_date, 6, 2) = '10');

/*
Prediction Result:
(685.3333333333334,)
*/