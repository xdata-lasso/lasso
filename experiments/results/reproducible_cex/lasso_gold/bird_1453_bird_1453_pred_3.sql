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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('soldier', 'Laura Harrison', 'institution', 'part', 'Charge specific we.', '34123 Andrea Estate
South Shannonfort, LA 04779', 'left');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('military', 'Cody Williams', 'million', 'professional', 'Yes budget share paper.', '713 French Road Apt. 618
Lake Edward, KY 19144', 'be');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('board', 'Karen Short', 'back', 'rich', 'Difficult mission late kind team wrong figure perform.', '9947 Taylor Hollow
Benderhaven, ND 65223', 'piece');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('believe', 'Michele Garcia', 'lawyer', 'nice', 'Color bad that people.', '5946 Bryant Hollow
South Melissa, CT 31592', 'stop');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('leader', 'Elijah Johnson', 'child', 'its', 'Marriage on discussion point least.', '440 Hill Port Apt. 974
New Laurie, IN 83943', 'notice');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('billion', 'Anthony Howard', 'election', 'others', 'Together let explain.', '210 Kramer Bypass Suite 214
Julieburgh, ID 17823', 'under');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('among', 'Lindsey Johnson', 'term', 'source');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('visit', 'Michael Valencia', 'exist', 'something');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('lay', 'Alicia Hubbard', 'amount', 'continue');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('history', 'Christopher Sloan', 'bag', 'draw');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('more', 'Tracy Phillips', 'chance', 'trade');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('white', 'Regina Mcdonald', 'somebody', 'require');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1055, 'many', 'Moonburgh', 'full', 'Hawaii', 'Vermont');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1056, 'natural', 'Waltersfort', 'religious', 'Michigan', 'New York');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1057, 'reach', 'South Michaelmouth', 'book', 'Nebraska', 'Maine');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1073, 'shake', 'Christopherfurt', 'pattern', 'South Dakota', 'Utah');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1074, 'represent', 'West Amandamouth', 'I', 'Mississippi', 'Iowa');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1075, 'industry', 'Emilyview', 'test', 'Connecticut', 'New Mexico');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('recognize', 'Parking', 1058.5, 1061.5, 1064, 'soon', 'soldier');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('you', 'Parking', 1065.5, 1070.5, 1075.0, 'oil', 'soldier');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('teach', 'Parking', 1072.5, 1079.5, 1086.0, 'although', 'soldier');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('ago', 'Parking', 1076.5, 1079.5, 1082, 'yes', 'believe');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('president', 'Parking', 1083.5, 1088.5, 1093.0, 'option', 'believe');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('usually', 'Parking', 1090.5, 1097.5, 1104.0, 'generation', 'believe');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('look', 'Johnny', 'Hancock', 'mgutierrez@example.net', 'up', 'campaign', '+1-332-448-0861x317', 1055, 'among');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('behavior', 'Darrell', 'Bryan', 'cindy77@example.org', 'say', 'air', '448.346.7737x8263', 1055, 'among');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('forward', 'Kendra', 'Smith', 'josephanderson@example.com', 'memory', 'professor', '965-984-0449x972', 1055, 'among');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('whole', 'Deborah', 'Haynes', 'shahkevin@example.com', 'same', 'kind', '001-526-717-9640x5377', 1073, 'history');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('poor', 'Cynthia', 'Banks', 'davispaige@example.org', 'young', 'people', '958-350-6431', 1073, 'history');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('do', 'Steven', 'Wilson', 'qchavez@example.net', 'now', 'situation', '+1-539-500-5329x31839', 1073, 'history');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('hair', 'Help usually thank wonder draw him task.', 'true', 1074.5, 'through', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('go', 'Analysis seat relate specific history professional.', 'black', 1076.5, 'less', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('old', 'Manager already maybe opportunity.', 'two', 1078.5, 'never', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('whether', 'Improve pressure child light.', 'program', 1070.5, 'field', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('loss', 'Full realize power system system.', 'return', 1079.5, 'dream', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('administration', 'Here first responsibility service their along attention.', 'will', 1088.5, 'skin', 'look', 'recognize');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('get', 'Able teach certain candidate economy company produce ago.', 'build', NULL, 'maybe', 'whole', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('staff', 'Group small open.', 'skill', NULL, 'list', 'whole', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('choose', 'Company appear score.', 'attack', NULL, 'star', 'whole', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('high', 'Later develop past road.', 'official', NULL, 'picture', 'whole', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('must', 'Feeling poor all your suggest international blue.', 'seem', NULL, 'financial', 'whole', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('personal', 'Available ball part assume every plan.', 'garden', NULL, 'long', 'whole', 'ago');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Laura Harrison',)
('Laura Harrison',)
('Laura Harrison',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN expense AS ex ON b.budget_id = ex.link_to_budget WHERE b.category = 'Parking' AND ex.cost < (SELECT CAST(SUM(ex2.cost) AS REAL) / COUNT(ex2.expense_id) FROM expense AS ex2 JOIN budget AS b2 ON ex2.link_to_budget = b2.budget_id WHERE b2.category = 'Parking');

/*
Prediction Result:
*/