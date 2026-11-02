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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('pull', 'Ashley Hall', 'ago', 'president', 'Foreign particular positive play less red power.', '47113 Paul Land
Matthewsberg, FM 54880', 'real');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('bit', 'Lisa Crosby', 'far', 'alone');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1062, 'road', 'Jeffmouth', 'eat', 'Mississippi', 'Connecticut');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('rich', 'hold', 1063.5, 1064.5, 1065, 'off', 'pull');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('week', 'Tiffany', 'Howard', 'hhill@example.com', 'benefit', 'recognize', '390.505.3293', 1062, 'bit');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('town', 'Tiffany', 'Howard', 'hhill@example.com', 'benefit', 'recognize', '390.505.3293', 1062, 'bit');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('peace', 'Spend do similar small other.', '2019-10-15', 21.0, 'factor', 'week', 'rich');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('check', 'Spend do similar small other.', '2019-10-151', 22.0, 'factor', 'town', 'rich');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.email FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE DATE(SUBSTRING(T2.expense_date, 1, 10)) BETWEEN '2019-09-10' AND '2019-11-19' AND T2.cost > 20;

/*
Gold Result:
('hhill@example.com',)
*/

-- Prediction Query
SELECT m.email FROM expense AS e JOIN member AS m ON e.link_to_member = m.member_id WHERE e.expense_date BETWEEN '2019-09-10' AND '2019-11-19' AND e.cost > 20;

/*
Prediction Result:
('hhill@example.com',)
('hhill@example.com',)
*/