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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1396673167, 412199481, '2022-08-25 00:08:33+00:00', 1083479253, 0, '9oaawg', 5, '2024-09-22 16:04:20+00:00', 'aqb0tbind', '39tajz9', -841516418, 152478847, -625404808, -2147483641, '2020-11-23 15:43:29+00:00', '2022-09-05 12:39:02+00:00', -1275298282, '2020-04-18 15:13:13+00:00', '3tdu6bd0w960', 'vzxw1rxe');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 312804300, -246257698, '2020-12-13 20:46:34+00:00', 956819642, 774922170, '3dohvu0', 4, '2024-04-24 18:29:26+00:00', 'z', '3', 1595632888, 2072023304, 789756515, -2147483647, '2021-12-14 20:39:54+00:00', '2023-08-06 06:41:23+00:00', 769234989, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', 'njabym');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -2001463367, -2003500453, '2024-11-14 09:09:26+00:00', 1280646590, -568125159, '1sjv8nv3d', 5, '2020-07-04 02:54:37+00:00', 'okuez', 'ctehia3cmvb', -1077762203, -1798310553, -1174073066, 7, '2023-09-05 15:16:07+00:00', '2020-07-31 19:24:59+00:00', -1424758178, '2020-09-16 02:48:31+00:00', 'q82qg01hu', 'j7f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1390245819, 1055976837, '2023-08-25 07:55:29+00:00', -74849714, 2, '7zw', 5, '2025-03-16 12:14:02+00:00', 'u', '2dwyrq13pyu7', 244829661, -1362461264, -904834265, 9, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1196308825, 910894705, '2023-11-06 04:09:03+00:00', 1675430660, 3, 'y9uxj4', -2147483647, '2021-01-22 00:53:52+00:00', 'bdvlph', 'gndqwnqc', 555413010, 722884590, 580968159, 4, '2021-10-14 14:41:11+00:00', '2020-05-10 07:36:02+00:00', 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', 5, '2020-09-25 19:25:33+00:00', '4h', 'ia2yp', -1670923962, 700293388, 906324270, -2147483633, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 1072996612, '2024-04-12 00:38:47+00:00', 'uhv', 'l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1620389964, 546571701, '2024-10-26 11:04:11+00:00', 947159877, 1990080517, 'c4ecigce', 11, '2023-12-22 03:17:01+00:00', '6nium52zb', 'uo4nrqrofqy', -1106983592, 1884179925, 902551284, 1, '2020-03-11 14:09:37+00:00', '2022-01-05 17:19:47+00:00', 882961052, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', -2147483640, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, 11, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -1762857309, 806170397, '2025-08-02 02:30:29+00:00', -1056308489, -1454058168, 'bilyrkn', 9, '2025-11-22 09:05:23+00:00', 'vck6ah0f8', 'sww', -1388029300, -566887085, 602161869, 6, '2020-09-05 12:25:49+00:00', '2023-03-07 13:22:39+00:00', -961217731, '2020-09-26 17:28:32+00:00', 'r', 'z16nijjai5d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1972233925, 1792827279, '2025-05-18 14:45:15+00:00', -106471771, 1235416111, 'jh3den8', -2147483641, '2025-01-28 02:00:27+00:00', 'c68x8vacx7', 'f', -47052816, 645287482, 765724008, -2147483637, '2024-06-30 03:42:59+00:00', '2024-05-28 03:27:01+00:00', -1099855564, '2021-11-28 21:12:32+00:00', '72ctdctmfg62', '0v');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Noah Snyder', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1666765085, '2025-11-19 11:50:18+00:00', 'Noah Snyder', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -705985602, '2025-02-21 13:28:29+00:00', 'Noah Snyder', '2025-05-10 04:07:07+00:00', '58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', -261132974, -1264842910, -1052964641, -1245682094, -1660358170, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1744557630, '2022-11-14 02:03:20+00:00', 'A', '2024-03-11 08:01:44+00:00', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, 1923659053, -1950324754, '7z2zezj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1448731351, '2024-06-13 19:21:11+00:00', 'A', '2024-11-08 11:45:59+00:00', 'gxd5ys', 'cmr0oz', 'dgj5i', -176606723, -15162884, 1339733032, -1556979799, -55240145, '8qs27p2r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -95808609, '2022-08-10 04:39:07+00:00', 'A', '2020-12-28 23:17:24+00:00', '2mnajjla3o', 'v8u', 'tmu2n', -1817527403, -1402164108, 2123471885, -526633767, 448935289, 'be8yvkv');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 79330142, '2023-02-22 13:15:37+00:00', '58b4pmaus3a', '2022-09-08 09:11:51+00:00', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843, -441521858, 2015094998, 1010672881, -1197954156, '0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 1483450542, '2025-04-08 19:28:10+00:00', '!', '2021-12-10 10:51:29+00:00', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', -2076274980, 1731324803, -1159083009, -1589605308, -268740517, 'nxih662q');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 1291298007, '2021-10-14 06:43:25+00:00', '"', '2022-07-31 02:11:06+00:00', 'q', 'hm5wl', 'c7d', 594760660, 833568923, -384749431, -934098178, -827883679, 'lc');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -609840352, '2023-02-19 09:49:51+00:00', '!', '2025-03-20 08:27:04+00:00', 'vri', 'surz0kaqtncg', 'c8s3b7v88k', -622923312, 1789767331, 1633584225, 1671062261, -1924635316, '6j47n');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, -1664440372, '2021-06-07 11:18:19+00:00', '$', '2025-07-22 19:07:46+00:00', '2gir31', 'wq51oa', 'sb3uoi1p', -1971610898, 2095277250, 1971816668, -1067465394, 1491006943, 'lrpou');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483637, -460035045, '2025-08-10 10:30:27+00:00', '@', '2023-12-15 10:06:38+00:00', 'rjkwns47j2ja', '8dccy3vjwq49', 'yrnxs6dvdx', -1900450199, -232312083, 1805923837, -699779308, -1368221491, 'fjvuun7k1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1557266002, '2022-09-19 07:34:59+00:00', 'Harvey Motulsky', '2020-07-25 22:23:30+00:00', 'khllbwvdpu', '5v0eduy9v2z', '29835xo', 765955451, 1372042958, 1147974039, -220327705, -344881050, '96xiyet8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -55602865, '2024-02-19 01:18:26+00:00', 'Noah Snyder', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1019800248, '2022-11-06 10:19:41+00:00', 'Noah Snyder', '2020-06-20 11:35:06+00:00', 'tti', 'bnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483633, -1683203397, '2025-04-19 21:11:20+00:00', 'use_394c9e', '2020-08-15 08:54:31+00:00', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 'ytoo3o9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -7597509, 1, 'h5ogrgjd8yz', '2022-08-16 10:09:33+00:00', 2, '1afgogritsj', 'ayxp1q43', '1jh3den');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 357330522, 1, '68x8vacx7a', '2020-10-05 17:58:46+00:00', 2, '5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 375841374, 1, '32o', '2020-06-28 23:31:51+00:00', 6, 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, 1528227252, 5, 'fx7h', '2023-12-11 11:19:14+00:00', 1, 'p6sto1cj', 'sh5knzys7', 'y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -1502591405, 1, 'h', '2024-07-16 00:46:06+00:00', 6, 'qta8y3a17v4y', 'ma', 'q3qdpua');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -1750715330, 5, 'ccukjq1qui', '2021-05-13 00:35:54+00:00', 1, 'yhb08hl', 't1pqo', 'iztv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -1558272216, 1, '78aqqlud8ft', '2020-03-09 05:15:04+00:00', 6, 'r9114qbre', '6bjeuuwsj8k', 'h85');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 1981548099, 5, 'sj', '2020-12-24 03:00:15+00:00', 1, 'n', 'xdpunmw', 'wx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, -641927001, 1, '14r5dqt', '2022-06-12 18:10:40+00:00', 6, 'g97a', 'z2o20', 'pj6ddlysu6ip');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483638, 1589523321, 5, 'yfvmjwpp26m', '2020-03-03 12:34:10+00:00', 1, 'aj0ju0h3', '133ir', 'axyyhpl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, -873300912, 1, '8pgc', '2021-05-17 17:21:42+00:00', 6, 'wtsr5', '4o6qjektb1', '2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, -251621840, 5, 'y1ogyv1rgeza', '2025-02-02 10:57:02+00:00', 1, 'c1clup', 'ly', '8oitxeilp');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -1839279753, 1, '19cy7od033d', '2021-07-04 09:24:41+00:00', 1, 'hdsvnhed29lq', '26u331', 'spxpw30bgwkx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 1693638235, 1, 'nlj', '2024-10-16 19:48:26+00:00', 1, 'idmp61l2o', 'ak162oca', 'je');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1663813652, 3, 'u5gm8gxb5qj', '2021-07-20 06:37:41+00:00', 7, 'awsp4', 'wi3', 'l7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1485777725, 3, '8n2f3', '2025-11-06 14:42:57+00:00', -2147483647, 'q', '0gcb98', 'zk3z');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 1686459626, 1, 'lyr', '2021-06-12 16:42:05+00:00', 8, 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, -845863578, 7, 'lbn', '2022-01-18 15:57:55+00:00', 10, 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1666765085, 8, '72klex14ji7z', '2023-01-02 05:47:29+00:00', 11, 'au2dwyrq13', 'yu78', '9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 1968874827, 9, 'nqcx5h', '2021-10-14 14:41:11+00:00', 12, 'p', 'jtu0d', '79fjgq8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, -1625552518, 10, 'grgj', '2020-06-19 19:37:13+00:00', 13, 'yzt1afgog', 'itsj3', 'y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (11, 820970595, 11, 'qdjpe1io2', '2023-10-17 13:49:58+00:00', 14, '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Noah Snyder',)
*/

-- Prediction Query
SELECT T2.DisplayName, SUM(T1.ViewCount) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Harvey Motulsky' OR T2.DisplayName = 'Noah Snyder' GROUP BY T2.DisplayName ORDER BY SUM(T1.ViewCount) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Prediction Result:
('Noah Snyder', -130108290)
*/