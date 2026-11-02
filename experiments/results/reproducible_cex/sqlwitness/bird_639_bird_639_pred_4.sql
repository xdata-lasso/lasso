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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, 0, '2023-01-01 01:00:00.000000', 'r', '2023-01-01 00:00:00.000000', ',', 'default2', NULL, 100, 1, 99, 1, 99, 'default2'), (99, 99, '2023-01-01 00:00:00.000000', 'Community', NULL, '%<r>%', 'default1', 'default2', 0, NULL, -1, 100, 0, 'Community'), (-1, 1, '2023-01-01 00:00:00.000000', 'Community', NULL, NULL, ',', ',', 101, 101, 2, 99, 0, 'default2'), (0, -1, '2023-01-01 00:00:00.000000', 'r', '2023-01-01 00:00:00.000000', '%<r>%', ',', 'default1', -1, 2, NULL, 101, 101, '%<r>%'), (1, 101, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', '%<r>%', 'default2', NULL, 0, -1, 1, 100, 'r');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (99, -1, 0, 99, 101, '2023-01-01 01:00:00.000000', 99, -1, 'Community', '2023-01-01 00:00:00.000000', 'Community', 'r', 99, 1, 100, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', -1, '2023-01-01 01:00:00.000000', NULL, '%<r>%'), (1, 0, 99, 1, -1, NULL, NULL, NULL, 'r', '2023-01-01 01:00:00.000000', '%<r>%', NULL, NULL, 100, 1, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 'r', 'default1'), (101, NULL, -1, 1, 0, '2023-01-01 00:00:00.000000', NULL, 1, ',', '2023-01-01 01:00:00.000000', NULL, 'Community', -1, -1, 99, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 101, NULL, ',', 'default1'), (0, 2, -1, -1, 0, NULL, NULL, -1, NULL, '2023-01-01 00:00:00.000000', 'default1', '%<r>%', 2, NULL, 99, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 100, '2023-01-01 00:00:00.000000', 'default1', 'Community');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (-1, NULL, ',', 0, 1), (100, 1, 'default1', 99, 99), (1, 101, 'r', 2, 101), (2, 1, 'default2', 0, 100), (0, 1, 'Community', 101, 0), (99, 0, 'default1', 2, 101), (101, 1, '%<r>%', 100, 99), (3, 99, NULL, 1, 99);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (99, 101, 0, 101, 'default1', NULL, 'default2', 'default2', 'default2'), (1, 99, 2, 0, ',', '2023-01-01 00:00:00.000000', '%<r>%', 'Community', 'r');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (100.0 * CAST(SUM(CASE WHEN ',' || posts.Tags || ',' LIKE '%<r>%' THEN 1 ELSE 0 END) AS REAL) / CAST(COUNT(posts.Id) AS REAL)) AS percentage FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'Community';

/*
Prediction Result:
(33.333333333333336,)
*/