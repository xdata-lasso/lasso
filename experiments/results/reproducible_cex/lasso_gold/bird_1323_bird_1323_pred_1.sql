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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('present', 'Elizabeth Ramirez', 'speak', 'land', 'No order executive range loss from.', 'USCGC Smith
FPO AE 95812', 'result');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('politics', 'Michael Garcia PhD', 'rest', 'want', 'Political technology end represent throughout.', 'Unit 3098 Box 2150
DPO AA 84429', 'enough');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('responsibility', 'William Ramos', 'act', 'however', 'Could military drive arm tax.', '010 Hannah Mall
Jamesside, KS 62681', 'child');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('rule', 'Debra Butler', 'matter', 'together', 'Identify floor cause agent market fast trade identify.', '046 Elaine Groves
South Maria, CT 67555', 'assume');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('interest', 'Chelsea Lewis', 'which', 'happy', 'On yes staff.', '1173 Kimberly Village
West Jade, LA 21521', 'still');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('American', 'Natalie Malone', 'cause', 'machine', 'Risk develop movement size trade public.', '75300 Rebecca Village Suite 218
Lake Jenniferview, SD 30799', 'find');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('individual', 'Samantha Robertson', 'radio', 'discover', 'Feel color price next family likely scientist.', '7012 Melissa Lake Suite 611
North Melissaburgh, MA 47362', 'Democrat');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('visit', 'Eric Hunter', 'consumer', 'man', 'Several consumer quite friend become great season.', 'PSC 9415, Box 5216
APO AA 60340', 'some');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('until', 'Samuel Suarez', 'plant', 'five', 'Inside thought he one less.', '762 David Stream Apt. 216
Phammouth, HI 80628', 'number');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('glass', 'Corey Whitaker', 'suddenly', 'research', 'Like term on want.', '027 Rodriguez Loop Suite 014
Alexanderhaven, WI 97969', 'alone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('rock', 'Danielle Bryant', 'across', 'near', 'Line create build quite.', '588 Ryan Stream
South Michael, TX 84571', 'her');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('economy', 'Michele Hill', 'door', 'thank', 'Fear approach take case customer important notice.', '28772 Karen Islands
West Tara, AR 66945', 'teach');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('appear', 'Kathy Reid', 'entire', 'price', 'Century television Congress ball forward would finish.', '3177 Miller Parks Suite 517
North Richardton, OH 72472', 'local');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('skill', 'Andre Watson', 'political', 'industry', 'Above event seven collection.', '948 Diamond Motorway
Michaelton, GU 29719', 'power');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('may', 'Cassandra Harrell', 'support', 'pattern', 'Majority shake because pass.', '997 Baldwin Crescent Apt. 305
Mariaport, OH 68918', 'trip');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('wife', 'Hannah Martin', 'yes', 'blue', 'Idea whole himself also current health.', '27261 Carr Field
Port Philipmouth, GU 25480', 'Republican');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('exist', 'Nicole Barker', 'focus', 'account', 'Throughout series most.', '0917 Barrett Parkways
South Adam, WA 06867', 'sister');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('watch', 'James Martin', 'seem', 'much', 'Quality phone eat.', '782 Jessica Crossroad Apt. 699
Williamfurt, MT 80323', 'or');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('hotel', 'Traci Vincent', 'security', 'recognize', 'Fine bill me fill assume animal.', 'PSC 3465, Box 4722
APO AA 79475', 'treatment');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('again', 'Megan Adams', 'question', 'threat', 'Lay minute model its rather.', '858 James Road Suite 522
Jenniferstad, OH 63464', 'situation');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('green', 'Alejandro Deleon', 'face', 'those', 'Garden top grow could.', '846 Alexandra Burg Suite 200
West Karen, GA 38068', 'option');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('where', 'Aaron Vincent DVM', 'four', 'onto', 'Simple land bad party less what than.', '7303 Moss Court
South Paul, ME 42845', 'reveal');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('customer', 'Jacqueline Stewart', 'stock', 'work', 'Instead partner if trade bad gas.', '881 Olson Hills
West Paige, VI 87886', 'hour');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('moment', 'Sierra Andrews', 'message', 'take', 'First fact environment popular even know.', '65024 Randy Gardens
North Biancafort, UT 78647', 'should');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('since', 'Clayton Duran', 'first', 'even', 'Security minute late cold take by.', '27195 Brian Rue
Lake Amanda, CT 16993', 'tonight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('decision', 'Jennifer Christensen', 'town', 'guy', 'Product wait red bag cold.', '573 Hannah Knolls Apt. 407
Hansenside, UT 64738', 'bed');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('easy', 'Joseph Henderson', 'out', 'its', 'Believe view list approach.', '557 Dillon Rapid
North Amanda, NV 39255', 'budget');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('effort', 'Amanda Reed', 'anyone', 'campaign', 'Model you billion peace base use.', '0862 Christine Lakes Apt. 518
Leefort, WI 72782', 'arm');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('evidence', 'Patty Bryant', 'information', 'have', 'Finally easy exist phone capital stuff.', '6511 Bradley Curve Apt. 031
Leeton, OK 84616', 'eight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('drop', 'Joseph Stewart', 'bit', 'respond', 'Along ground trip.', '994 Michael Rest Apt. 037
South Laurieton, MN 73641', 'pressure');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('degree', 'Michael Gray', 'common', 'police', 'Level that various nature career way much.', '0948 Jessica Village Suite 138
North Jessicaside, MS 25333', 'with');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('they', 'Isaiah Hensley', 'as', 'decide', 'Our piece player nor model police finally girl.', '288 Reese Trafficway
Emilychester, FM 14145', 'choose');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('enjoy', 'Dennis Adams', 'dinner', 'part', 'Dinner become film include choose action model.', '685 Amanda Rapid
Mahoneymouth, OH 43054', 'trouble');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('think', 'Grace White', 'environmental', 'parent', 'Gas light across two.', '659 Anna Forest Suite 845
Westfurt, AL 95700', 'there');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('heart', 'Jason Goodwin', 'professional', 'rate', 'Federal she something others someone nature country.', '082 Smith Forges Apt. 504
North Benjamin, MI 20962', 'ten');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('clearly', 'James Hayes', 'big', 'nothing', 'Join economic resource position stock determine bad.', '334 Davis Locks Apt. 157
South Margaret, UT 92624', 'address');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('start', 'Veronica Parks', 'listen', 'contain', 'Dream share travel space range expect sea speak.', '409 Miller Centers
Michaelchester, MT 16300', 'gun');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('both', 'Michelle Brock', 'size', 'statement', 'Could attention carry book lay laugh.', '906 Kevin Canyon
Amberberg, MD 66351', 'summer');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('call', 'Selena Gonzalez', 'good', 'feel', 'Man fly charge wide against win example by.', '67998 Jeffrey Highway
Hernandezmouth, CO 62872', 'bring');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bar', 'Nancy Kennedy', 'ever', 'hear', 'Road do character management game find.', '641 Shaw Trail
Port Dennis, OH 26467', 'market');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('require', 'Javier Taylor', 'here', 'garden', 'Your less social form such weight argue.', '983 Charles Trail
Morrisshire, CO 15250', 'agency');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('record', 'Lydia Ferguson', 'opportunity', 'Mrs', 'Author like court success stage stock.', '5355 Kayla Extension Suite 979
South Brady, GU 31104', 'determine');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('improve', 'Richard Lindsey', 'field', 'room');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('note', 'Joshua Christensen', 'official', 'meeting');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1064, 'red', 'South Paulmouth', 'old', 'Arkansas', 'Alabama');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1085, 'prevent', 'Lake Holly', 'affect', 'Missouri', 'Pennsylvania');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.melton.com/', 'Daniel', 'Herring', 'yorksarah@example.net', 'return', 'everything', '844.598.9266x59184', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.brandt.com/', 'Kristin', 'Spencer', 'enewman@example.com', 'company', 'hope', '665.557.7908x27231', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.palmer.net/', 'Kevin', 'Peters', 'kingjames@example.net', 'sometimes', 'east', '(322)959-1365', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.silva.com/', 'Christopher', 'Martinez', 'wlynn@example.org', 'my', 'and', '+1-477-239-2603x02992', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://pineda.org/', 'Kathy', 'Smith', 'craigharvey@example.org', 'challenge', 'relate', '001-220-624-2869', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://tyler-pierce.com/', 'Samuel', 'Carlson', 'todd59@example.net', 'like', 'design', '437-497-7236', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.meyer.com/', 'Randall', 'Medina', 'heather29@example.net', 'collection', 'national', '+1-484-325-7991x366', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://bailey.com/', 'Donna', 'Arroyo', 'lindsey62@example.org', 'country', 'whatever', '9382862912', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://robinson-goodwin.net/', 'Thomas', 'Torres', 'john36@example.com', 'others', 'strong', '+1-881-817-2980', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.caldwell.com/', 'Amanda', 'Goodman', 'dennis57@example.com', 'receive', 'herself', '(408)663-7659x916', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.blackwell.com/', 'Derek', 'Berger', 'thoward@example.com', 'turn', 'important', '331.249.8643x0098', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://ramsey.com/', 'Peter', 'Cooper', 'thompsoncatherine@example.com', 'simply', 'manager', '(735)665-1269x4486', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://phillips.com/', 'Lauren', 'Gutierrez', 'patriciagonzalez@example.net', 'sign', 'whose', '+1-763-868-8725x88744', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.jackson.net/', 'Amy', 'Brewer', 'lunapatricia@example.net', 'member', 'look', '001-221-437-2138x6589', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.santiago.biz/', 'Susan', 'Hunt', 'hessbeth@example.net', 'wrong', 'upon', '(201)827-9611x4351', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.poole.biz/', 'Douglas', 'Martin', 'rebeccaarnold@example.net', 'amount', 'any', '(598)249-0277x0384', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.stevens.com/', 'Erica', 'Walker', 'jvaldez@example.com', 'discuss', 'among', '+1-688-839-2053x021', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.thompson.net/', 'Robin', 'Davenport', 'xwalker@example.net', 'sort', 'range', '(766)793-8011x848', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.russell-hayes.biz/', 'Laura', 'Lee', 'dennis88@example.org', 'method', 'game', '339-337-6904x268', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://price.net/', 'Jessica', 'White', 'acox@example.net', 'each', 'board', '745.918.4894x76973', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.richards.net/', 'Nathan', 'Marsh', 'melaniedrake@example.net', 'at', 'score', '+1-279-607-1416x33565', 1064, 'improve');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://brown.org/', 'Carl', 'Williams', 'phillipmorris@example.org', 'cost', 'new', '001-995-429-9787', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.pena-smith.biz/', 'Sara', 'Forbes', 'shawnmosley@example.org', 'lose', 'job', '+1-834-230-1071x396', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://smith.biz/', 'Valerie', 'Stone', 'udavis@example.net', 'so', 'network', '258-330-3441x44885', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://bray.org/', 'Michelle', 'Foster', 'jennifermartinez@example.org', 'particular', 'safe', '+1-455-969-9023x55770', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.mason.net/', 'Tracy', 'Moss', 'fwalters@example.net', 'also', 'population', '(778)257-6084', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.nielsen.com/', 'Mark', 'Grant', 'gacosta@example.net', 'special', 'article', '895.451.2405', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://moore.com/', 'Stephen', 'Black', 'nicholasjames@example.org', 'firm', 'boy', '001-696-829-1450', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://garrett.com/', 'John', 'Mccoy', 'ariana22@example.org', 'future', 'owner', '473-357-4384', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.peterson.com/', 'Richard', 'Carter', 'kaylawilliams@example.com', 'home', 'show', '(903)617-8078x235', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://yu.com/', 'Bobby', 'Sanders', 'jessica74@example.net', 'water', 'newspaper', '001-252-318-2307x68104', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.hernandez.com/', 'Jill', 'Carey', 'davidanderson@example.org', 'hundred', 'begin', '670-718-4094x35334', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.delgado.net/', 'Omar', 'Murray', 'deanjohnny@example.com', 'author', 'shake', '001-771-742-2410x98813', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.barker-roach.com/', 'Lawrence', 'Henderson', 'ifoley@example.org', 'son', 'risk', '224-493-2149x587', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.fitzpatrick.net/', 'Cheryl', 'Austin', 'lyoung@example.net', 'late', 'point', '4709160166', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.franco-thomas.com/', 'Julia', 'Brown', 'cchavez@example.org', 'oil', 'world', '+1-354-953-8179x217', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://turner-reese.com/', 'Brittney', 'Thomas', 'sanchezamy@example.net', 'attention', 'story', '977-933-2945x6255', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.anderson.org/', 'Alicia', 'Gallegos', 'brandonhernandez@example.net', 'final', 'seat', '7174157724', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.hall.info/', 'Nancy', 'Hayes', 'benjamin09@example.net', 'center', 'thus', '516.415.8148x76963', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://banks.info/', 'Abigail', 'Sharp', 'mark10@example.org', 'run', 'free', '361.953.9669x5832', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.perez.com/', 'Shannon', 'Wilson', 'kchaney@example.net', 'trade', 'event', '699-875-8172', 1085, 'note');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://newton.com/', 'Margaret', 'Osborne', 'cheryl99@example.net', 'girl', 'never', '591-496-5701', 1085, 'note');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.melton.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.brandt.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.palmer.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.silva.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://pineda.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://tyler-pierce.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.meyer.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://bailey.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://robinson-goodwin.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.caldwell.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.blackwell.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://ramsey.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://phillips.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://www.jackson.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.santiago.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.poole.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.stevens.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.thompson.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.russell-hayes.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'https://price.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('present', 'http://www.richards.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('where', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Elizabeth Ramirez',)
('Aaron Vincent DVM',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event LEFT JOIN income AS i ON e.event_id = i.link_to_member GROUP BY e.event_id, e.event_name HAVING COUNT(a.link_to_member) > 20 AND i.income_id IS NULL;

/*
Prediction Result:
('Elizabeth Ramirez',)
*/