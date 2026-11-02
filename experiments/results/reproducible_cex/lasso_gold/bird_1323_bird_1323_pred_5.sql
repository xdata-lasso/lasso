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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('available', 'Maria Ferguson', 'event', 'fundraiser', 'Tend magazine college moment compare today.', '5557 Coleman Lock
Smithfurt, AR 54081', 'maintain');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('account', 'John Barber', 'himself', 'fundraiser', 'Protect ask different.', '4033 Phillips Landing
West Ronaldfurt, MD 73648', 'relate');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('smile', 'James Short', 'set', 'fundraiser', 'Difference everything sing smile practice.', '98741 John Islands
Davidshire, NJ 06530', 'performance');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('alone', 'Heidi Moran', 'movie', 'fundraiser', 'Material notice police activity second standard.', '734 Brown Centers Suite 485
Mcleanville, NJ 18101', 'participant');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('rest', 'Marie Patterson', 'skill', 'fundraiser', 'Together scientist hair allow phone weight medical.', '6229 Andrews Points
South Johnshire, ND 87099', 'example');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('research', 'Charles Baker', 'truth', 'fundraiser', 'Network movement scientist their wife.', '021 Krueger Lake Suite 325
Perezstad, MA 26582', 'soon');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('investment', 'Nicole Rodriguez', 'nation', 'fundraiser', 'Land mission each something.', '9021 Simmons Valley Suite 080
Allenchester, AZ 66589', 'catch');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('trial', 'Jason Morgan', 'into', 'fundraiser', 'Ready practice each ready.', '749 Walters Street Apt. 918
New Erichaven, PR 11999', 'generation');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('nature', 'Rebecca Clark', 'me', 'fundraiser', 'Concern without entire everyone sea safe true.', '316 Owens Streets Apt. 512
Shawnchester, FM 03316', 'knowledge');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('many', 'Martin Jones', 'present', 'fundraiser', 'Mission article dinner one.', '96003 Simmons Green Apt. 958
Valdezborough, WI 75793', 'recently');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('training', 'Katherine Sanchez', 'we', 'fundraiser', 'Local better think anything so authority long kind.', 'PSC 9232, Box 3421
APO AE 70417', 'check');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('image', 'Edward Wallace', 'conference', 'fundraiser', 'Culture my Democrat maintain notice ok technology.', '85155 Dominique Flats
Frankview, IN 28974', 'particularly');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('avoid', 'Melissa Carroll', 'guy', 'fundraiser', 'Result kind politics open.', '71607 Omar Mission
Rossborough, WI 50374', 'since');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('stay', 'Pam Hernandez', 'quickly', 'fundraiser', 'Sense yeah edge imagine establish piece forget low.', '28981 Katherine Crest
Yangstad, WA 42035', 'worry');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('key', 'Daniel Wood', 'clearly', 'fundraiser', 'Week federal test eat every.', '85748 Sierra Brook
South Lindafurt, PR 13616', 'today');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ever', 'Eddie Duffy', 'people', 'fundraiser', 'Me personal born series consider according throw.', '64316 Smith Harbor Suite 023
New Albert, NC 20916', 'already');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('use', 'Mark Alvarez', 'tonight', 'fundraiser', 'Like clear assume it fight understand kitchen.', '09345 Morrow Manor Apt. 282
West Natasha, DE 21783', 'small');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('sense', 'Edward Manning', 'more', 'fundraiser', 'State cover board discussion film figure short.', '6549 Johnson Burg
Anthonyfort, AZ 96832', 'western');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('note', 'Bridget Carter', 'former', 'fundraiser', 'Bill feel participant number choice choose short.', '86982 Craig Keys Apt. 161
South Stevenchester, PR 70850', 'successful');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('camera', 'Mark Johnson', 'necessary', 'fundraiser', 'System particular church what.', '7742 Douglas Lakes
South Trevorshire, ID 16994', 'project');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('senior', 'Eric Silva', 'house', 'fundraiser', 'President small sister especially usually line task.', '31164 John Glen
Lake Donna, MA 93622', 'anything');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('study', 'Christopher Thomas', 'along', 'thing');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1232, 'economy', 'South Marcus', 'owner', 'New Mexico', 'Minnesota');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://haney-chavez.com/', 'Nancy', 'Brown', 'qobrien@example.com', 'safe', 'through', '533.237.3204', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.ramirez.com/', 'Stefanie', 'Garcia', 'guzmanbrittany@example.net', 'bag', 'simply', '+1-877-868-8936x289', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://roman-freeman.net/', 'Blake', 'Carrillo', 'johnstondavid@example.org', 'decide', 'teacher', '001-745-546-5535x8512', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.chase.com/', 'Mary', 'Kirby', 'betty96@example.com', 'better', 'very', '+1-592-718-7851', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.martinez.com/', 'Jonathan', 'Oconnor', 'reedkristin@example.com', 'believe', 'success', '001-883-374-9079x779', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://marks.info/', 'Courtney', 'Conway', 'bentleylisa@example.net', 'seek', 'finally', '(308)778-0572', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.white.net/', 'Ronald', 'Bowman', 'bcaldwell@example.org', 'piece', 'positive', '849-540-9762', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.walker.com/', 'Gary', 'Murphy', 'andrewbautista@example.org', 'who', 'over', '+1-274-284-5398x62895', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.cox.net/', 'Jenna', 'Estrada', 'samantha07@example.com', 'under', 'beautiful', '001-459-411-9186x233', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://garcia.org/', 'Michelle', 'King', 'loretta55@example.org', 'record', 'game', '8718511696', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.dunlap.com/', 'Tony', 'Kelly', 'sean05@example.com', 'interview', 'down', '001-372-452-1452x647', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://price-boyd.biz/', 'Kelly', 'Smith', 'kayla23@example.net', 'together', 'level', '263-235-1571x840', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://taylor-hurley.com/', 'Alexandra', 'Marquez', 'joy52@example.com', 'everyone', 'that', '+1-751-320-8005x64099', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://peters.org/', 'Christopher', 'Washington', 'cookchristina@example.net', 'child', 'amount', '(439)772-8351', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.taylor-castillo.com/', 'Jessica', 'Willis', 'leslietorres@example.net', 'grow', 'else', '001-227-328-2709', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://lucas.org/', 'Susan', 'Walker', 'fowlerlawrence@example.com', 'no', 'official', '741-952-9821x7392', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.jones-richmond.com/', 'John', 'Hamilton', 'katherineharris@example.net', 'health', 'clear', '+1-886-271-8153x52373', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://barber.com/', 'Melissa', 'Baker', 'zbell@example.com', 'industry', 'region', '(807)591-8158x998', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://chambers.com/', 'Troy', 'Osborn', 'kari25@example.org', 'cell', 'eye', '952-373-4666x6170', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://garcia.info/', 'Jacqueline', 'Mckenzie', 'lopezlance@example.net', 'will', 'agree', '487-796-4740x80314', 1232, 'study');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.paul.com/', 'Ryan', 'Freeman', 'katherine82@example.com', 'body', 'miss', '001-408-700-4635x8068', 1232, 'study');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://haney-chavez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://www.ramirez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://roman-freeman.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://www.chase.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://www.martinez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://marks.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://www.white.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://www.walker.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://www.cox.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://garcia.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://www.dunlap.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://price-boyd.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://taylor-hurley.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://peters.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://www.taylor-castillo.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://lucas.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://www.jones-richmond.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://barber.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://chambers.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'http://garcia.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('available', 'https://www.paul.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Maria Ferguson',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type <> 'fundraiser' GROUP BY T1.event_id HAVING COUNT(T1.event_id) > 20;

/*
Prediction Result:
*/