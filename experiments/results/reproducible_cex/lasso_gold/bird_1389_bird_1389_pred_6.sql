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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('mission', 'Matthew Barber', 'maybe', 'east', 'Certain that activity until large.', '010 Davis Cove
Bellport, KS 25808', 'could');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('soldier', 'Kenneth Wilkinson', 'skin', 'result', 'Which raise American truth PM what.', '93911 Melissa Curve
Douglasshire, AS 24718', 'quite');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('itself', 'Dennis Weiss', 'win', 'season', 'Particular present evening establish sort effort.', 'PSC 2447, Box 1746
APO AP 88001', 'million');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('speech', 'John Alvarez', 'no', 'matter', 'Hospital significant see same open crime front real.', '2140 Price Circle Suite 427
South Tiffanyborough, RI 51964', 'charge');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('notice', 'Mary Hill', 'feel', 'support', 'Understand compare size.', '5273 Cantrell Flats
Davidshire, AR 37280', 'relationship');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('movement', 'Robert Jennings', 'enter', 'voice', 'Method audience dog know often industry section.', '6253 Munoz Turnpike Apt. 983
South Melodyfort, VI 28870', 'focus');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('discuss', 'Kara Thompson', 'good', 'animal', 'Discover body direction down include customer.', '0633 Hamilton Forges Apt. 906
North Vickiehaven, AZ 56298', 'color');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('majority', 'Amanda Newman', 'practice', 'body', 'Available one approach job democratic.', '177 Christopher Terrace Apt. 632
Kennethland, AK 63387', 'score');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('now', 'Susan Baldwin', 'red', 'girl');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('lawyer', 'Benjamin Duncan', 'exactly', 'west');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('discover', 'Jeremy Mosley', 'civil', 'include');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('positive', 'Martin Fitzpatrick', 'scene', 'paper');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('machine', 'Vanessa Ford', 'rock', 'last');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('toward', 'Michael Lopez', 'go', 'expect');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('own', 'Lori Padilla', 'nice', 'save');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('small', 'Mark Cruz', 'fine', 'young');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1405, 'about', 'Mendozafurt', 'institution', 'Colorado', 'Wisconsin');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1406, 'myself', 'New Jeremiahfurt', 'around', 'Mississippi', 'Wyoming');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1407, 'second', 'Martinezside', 'project', 'Ohio', 'Tennessee');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1408, 'yard', 'Mathewport', 'radio', 'Michigan', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1425, 'occur', 'New Nicoleton', 'audience', 'Florida', 'Massachusetts');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1426, 'parent', 'Pamelaville', 'option', 'New Mexico', 'Louisiana');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1427, 'despite', 'Diazton', 'security', 'Pennsylvania', 'North Carolina');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1428, 'store', 'Michaelside', 'staff', 'Iowa', 'Utah');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('once', 'safe', 1409.5, 1413.5, 1417, 'message', 'mission');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('among', 'both', 1416.5, 1422.5, 1428.0, 'value', 'mission');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('recent', 'professor', 1423.5, 1431.5, 1439.0, 'left', 'mission');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('cut', 'her', 1430.5, 1440.5, 1450.0, 'simple', 'mission');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('land', 'hair', 1429.5, 1433.5, 1437, 'new', 'notice');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('arm', 'local', 1436.5, 1442.5, 1448.0, 'themselves', 'notice');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('at', 'mention', 1443.5, 1451.5, 1459.0, 'can', 'notice');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('hotel', 'more', 1450.5, 1460.5, 1470.0, 'many', 'notice');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('customer', 'Wendy', 'Schneider', 'johnsonbrian@example.net', 'middle', 'why', '+1-320-920-4179x2911', 1405, 'now');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('challenge', 'John', 'Porter', 'sullivanjason@example.net', 'ready', 'present', '+1-493-713-6565x198', 1405, 'now');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('also', 'Paul', 'Hanna', 'ibentley@example.org', 'market', 'eight', '809.425.1142', 1405, 'now');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('service', 'Laura', 'Cain', 'sandyjohnson@example.org', 'what', 'science', '001-458-227-3902x196', 1405, 'now');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('that', 'Christine', 'Everett', 'keithfrye@example.org', 'work', 'life', '903-985-6955', 1425, 'machine');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('we', 'Lauren', 'Mcclain', 'joshuaterry@example.com', 'cause', 'sing', '449.724.2437x540', 1425, 'machine');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('final', 'Sierra', 'Ellis', 'nancymeyer@example.net', 'hand', 'against', '272-792-8422x2231', 1425, 'machine');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('live', 'Lisa', 'Miller', 'cartertara@example.net', 'kitchen', 'current', '001-727-745-2380', 1425, 'machine');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('until', 'Religious order exist really.', 'eat', 1421.5, 'beyond', 'customer', 'once');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('be', 'Realize deal policy mission include visit particular.', 'dark', 1430.5, 'high', 'customer', 'once');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('according', 'Other response partner.', 'buy', 1439.5, 'travel', 'customer', 'once');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('with', 'Physical site girl above.', 'next', 1448.5, 'sort', 'customer', 'once');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('choose', 'Building agent use shoulder way.', 'interest', NULL, 'like', 'that', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('list', 'Choose wife national medical positive far.', 'prepare', 1450.5, 'heavy', 'that', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('commercial', 'Wide senior yes project son.', 'thought', 1459.5, 'best', 'that', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('none', 'Full both look always question bring.', 'discussion', 1468.5, 'general', 'that', 'land');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Mary Hill',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN expense AS ex ON b.budget_id = ex.link_to_budget GROUP BY e.event_name ORDER BY MIN(ex.cost) ASC, e.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Matthew Barber',)
*/