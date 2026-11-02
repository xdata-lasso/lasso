-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -361507387, 401805964, '2021-04-23 15:57:00+00:00', -1742081330, 894242932, 'f3dqv0gc', 2, '2020-04-02 07:45:47+00:00', '8ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, 2, '2024-06-08 00:23:27+00:00', '2023-02-17 08:54:45+00:00', -541746689, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1010672881, -1197954156, '2020-04-02 11:13:10+00:00', -397848196, 0, '0k32odwcl5a', 2, '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, -360096930, 1, '2020-05-28 05:20:14+00:00', '2022-07-28 02:01:37+00:00', -795975227, '2023-04-23 07:11:55+00:00', 'uzkb52', 'gwnlas6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1048147204, -1814875250, '2022-12-20 18:28:11+00:00', -1589605308, -268740517, 'nxih662q', 2, '2023-10-18 11:51:31+00:00', 'lyotow', 'oaawg96aq', -2061634386, -850941333, -1216952047, -2147483643, '2023-05-07 05:01:37+00:00', '2023-12-20 17:13:08+00:00', -2140923099, '2023-05-09 01:10:53+00:00', 'td8n5wcgu', 'bc3t');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -306339789, -177551902, '2021-05-06 13:35:56+00:00', -229524038, -1954048590, 'je', -2147483640, '2020-07-15 02:09:47+00:00', 'vxzxlu49ku', 'o', 833662145, -1943810603, 1557266002, 4, '2022-09-19 07:34:59+00:00', '2020-07-25 22:23:30+00:00', -1417040770, '2025-12-14 07:53:41+00:00', 'lbw', 'dpu5v0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 90119032, -1438850342, '2020-08-18 16:30:34+00:00', 1055976837, 2, '4ji7zwa', 7, '2022-08-31 15:38:50+00:00', '2dwyrq13pyu7', 'd99rljsl0', -2031361952, 1649269347, -1116181514, 7, '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', -227162283, '2021-05-26 08:15:06+00:00', '9v', 'x58pz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1529584866, 1196308825, '2020-06-01 02:38:05+00:00', -283454505, 3, '9uxj4hw', 7, '2020-03-11 08:08:02+00:00', 'v', 'ph2', 1298861365, 1968874827, -664193365, -2147483642, '2022-02-18 09:12:59+00:00', '2020-04-10 05:04:30+00:00', 555413010, '2025-09-07 08:46:54+00:00', 'hncprjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -55602865, -59984348, '2022-12-08 21:38:59+00:00', 1258409369, -1981402255, 'k9n8c', 7, '2024-01-16 07:29:50+00:00', 'gu7v', 'e4', 1160656988, -992890117, 1914020640, -2147483639, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 546571701, 947159877, '2022-07-16 22:41:51+00:00', 1408123494, -1964997180, 'gce376nium52', -2147483635, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, 1, '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', -751275471, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1661181156, -1372125820, '2020-03-25 00:00:06+00:00', 1692174491, -1025564911, 'rkf9vqx5', -2147483643, '2024-08-09 01:13:45+00:00', 'pz0f8jegd21', 'y9uxj4', -1612443122, -2050247126, -736979194, -2147483640, '2022-01-26 11:13:48+00:00', '2020-12-31 11:15:26+00:00', -261132974, '2021-09-30 11:37:26+00:00', 'q', 'nqcx5h');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1606439408, 1443629118, '2023-12-12 02:47:46+00:00', -2078052421, -512640349, 'kn6vck6ah0f8', -2147483641, '2021-03-29 13:18:36+00:00', 'wwlq7', 'xb72fxa7ryfd', 564390026, -1259474148, 2011234363, 12, '2021-04-25 14:26:05+00:00', '2020-01-23 21:20:16+00:00', -7597509, '2025-07-17 09:46:47+00:00', '5o', 'rg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 195720193, 1774087382, '2020-02-13 02:40:04+00:00', 2035306060, 1523825314, 'u5', 13, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, 12, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Noah Snyder', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1666765085, '2025-11-19 11:50:18+00:00', 'Noah Snyder', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -705985602, '2025-02-21 13:28:29+00:00', 'Noah Snyder', '2025-05-10 04:07:07+00:00', '58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', -261132974, -1264842910, -1052964641, -1245682094, -1660358170, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1744557630, '2022-11-14 02:03:20+00:00', 'Noah Snyder', '2024-03-11 08:01:44+00:00', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, 1923659053, -1950324754, '7z2zezj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -57705450, '2022-06-10 06:35:27+00:00', 'cmr0oz', '2022-07-12 13:13:05+00:00', 'g', '5i3', 'q5l', 1339733032, -1556979799, -55240145, 1379859112, 195202164, 's27p2r94gth2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -705922211, '2022-10-30 06:13:33+00:00', 'Noah Snyder', '2024-11-18 17:17:10+00:00', '2q7sx58b', 'pmaus3au', 'mkrpdj', 1105964624, -663234145, -2013213247, 101754718, 628082526, '9n0jxfofwsz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 2013745856, '2020-01-09 12:53:38+00:00', 'Noah Snyder', '2020-02-18 15:32:47+00:00', 'mzn2mfx', 'h33p6sto1', 'j', 1728926031, -63214972, 1106724223, 1966809332, 1487347213, 'yd1jmgj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, -1750715330, '2024-10-20 07:00:22+00:00', 'Noah Snyder', '2020-05-07 15:56:54+00:00', 'cukjq1quik1y', 'hb08hlst1pq', 'mizt', 1793241362, -1304516770, -1558272216, 195316816, 1728201214, 'ud8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 460471995, '2021-04-02 09:07:37+00:00', 'Noah Snyder', '2020-12-24 03:00:15+00:00', 'n', 'xdpunmw', 'wx', -1040088060, -2081798075, -1439417265, -300547632, -967107842, 'dqtsmg97aqz2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, 982289268, '2021-01-20 13:32:04+00:00', 'Noah Snyder', '2023-11-16 19:48:22+00:00', '133ir', 'axyyhpl', 'i9esap8p', 679285124, 1752727653, 1394285393, -1052659852, 1092207544, 'r54o6qjektb1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -392891099, '2023-12-05 00:02:44+00:00', 'Harvey Motulsky', '2025-09-05 21:12:43+00:00', 'l', 'hdsvnhed29lq', '26u331', -894726713, -1089715864, -165171643, -2051120765, -607931326, 'xginlj6idm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -55602865, '2024-02-19 01:18:26+00:00', 'Noah Snyder', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1019800248, '2022-11-06 10:19:41+00:00', 'Noah Snyder', '2020-06-20 11:35:06+00:00', 'tti', 'bnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483635, -1683203397, '2025-04-19 21:11:20+00:00', 'use_394c9e', '2020-08-15 08:54:31+00:00', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 'ytoo3o9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -7597509, 1, 'h5ogrgjd8yz', '2022-08-16 10:09:33+00:00', 2, '1afgogritsj', 'ayxp1q43', '1jh3den');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 357330522, 1, '68x8vacx7a', '2020-10-05 17:58:46+00:00', 2, '5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1162591638, 1, 'ajjla3okv8u', '2022-08-27 04:45:18+00:00', 6, 'tmu2ne578l', 'vy', '7zzbe8y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, 1378873397, 5, 'u6bd0w9603', '2025-01-19 15:40:16+00:00', 1, 'vzxw1rxe9yf', '7qk', '162nh55y3d');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -1934709172, 1, '3', '2024-02-16 12:52:03+00:00', 6, 'rmkio18ri2', 'y0', '8ftp6ewtqx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 973811121, 5, 'ta8y3a17v4', '2025-06-20 19:52:40+00:00', 1, 'gmayq3q', 'dpuap96rnt', 'q');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -648564084, 1, 'c7d', '2025-06-06 16:24:29+00:00', 6, '2np4', '0xdmsqtge', 'cuq');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -312228770, 5, 'qbre6bje', '2024-12-21 23:01:28+00:00', 1, 'uwsj8k', 'h85', 'pxlvri');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, -388527046, 1, 'q', '2022-08-19 06:04:31+00:00', 6, 'ncgc8s3b7v', '88kwdmdbdht6', 'j47nxar50h');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483638, 6224071, 5, 'dlysu6iphd', '2021-06-07 11:18:19+00:00', 1, 'u2gir31vwq5', 'oa2sb3u', 'i1pa');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, -471852873, 1, 'ouirl', '2025-09-06 04:06:16+00:00', 6, 'pouit', '63xyfvmjwpp', '6mb3aj0j');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, -1517965246, 5, 'ns47j2', '2021-03-31 14:17:38+00:00', 1, '8', 'c', 'y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -1015337060, 1, 'yrnxs6dvd', '2023-02-19 12:28:03+00:00', 1, 'o', 'v7t3gvpl', '9fj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -743497747, 1, '7k10', '2025-09-05 08:53:26+00:00', 1, '2my1ogy', '1rgeza', 'xc1clupgly');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1846517698, 3, 'y9v2z1', '2025-04-11 01:43:12+00:00', 5, '9835xoep', 'acxdb2f0c29', 'xiyet8xjh');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, -1255130038, 1, '3d', '2025-08-02 02:30:29+00:00', 7, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1388029300, 2, 'xb72fxa7r', '2023-03-26 06:11:01+00:00', -2147483643, 'dr', 'z16nijjai5d', 'h5ogrgjd8yz');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, -841692980, 7, 'bnp', '2022-04-12 01:47:28+00:00', 9, 'dpos', 'ie5', 'nw6klf');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1666765085, 8, '72klex14ji7z', '2023-01-02 05:47:29+00:00', 10, 'au2dwyrq13', 'yu78', '9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, -1245312912, 9, 'rjtu', '2023-07-15 22:31:56+00:00', 11, 'z', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, -1478247928, 10, 'yzt1afgog', '2022-05-19 02:17:07+00:00', 12, 'tsj', 'ayxp1q43', '1jh3den');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (11, 2004147439, 11, 'tjpttg', '2024-05-07 03:46:17+00:00', 13, 'n', 'u5zi', '6c4bfkfo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Noah Snyder',)
*/

-- Prediction Query
SELECT p.Id AS PostId FROM posts AS p INNER JOIN users AS u ON p.OwnerUserId = u.Id WHERE u.DisplayName IN ('Harvey Motulsky', 'Noah Snyder') GROUP BY p.Id ORDER BY SUM(p.ViewCount) DESC, PostId NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483647,)
*/