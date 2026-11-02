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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, NULL, '2010-10-27 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, '2010', NULL, 1, 1, 1, 2, 1, '2010'), (0, 2, '2023-01-01 01:00:00.000000', '2010', '2010-10-27 00:00:00.000000', 'default2', NULL, NULL, NULL, 0, NULL, 1, 0, 'default1'), (1, NULL, '2010-10-27 00:00:00.000000', 'default2', NULL, '%Y', 'default1', NULL, 2, 2, 1, NULL, 2, '2010'), (3, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', '2010', 0, 1, 2, 1, 0, 'default1'), (4, 0, '2023-01-01 00:00:00.000000', '2010', NULL, '%Y', '2010', 'default2', 2, NULL, 1, 1, 2, '2010'), (5, 2, '2023-01-01 00:00:00.000000', 'default1', '2010-10-27 00:00:00.000000', '%Y', '2010', '%Y', 0, 1, NULL, 1, 0, '%Y'), (6, 0, '2010-10-27 00:00:00.000000', '2010', NULL, '2010', 'default1', '%Y', 0, NULL, NULL, 0, 2, NULL), (7, NULL, '2023-01-01 00:00:00.000000', '%Y', '2010-10-27 00:00:00.000000', 'default1', '2010', '%Y', 1, 1, 2, 1, 0, 'default1'), (8, 1, '2023-01-01 01:00:00.000000', '2010', '2023-01-01 01:00:00.000000', '%Y', '2010', '%Y', 2, NULL, 0, 1, 0, 'default2'), (9, NULL, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, '%Y', NULL, 2, 2, 2, 1, 2, '%Y');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 3, 2, 1, 2, '2010-10-27 00:00:00.000000', NULL, 2, '%Y', '2023-01-01 00:00:00.000000', '%Y', NULL, NULL, 0, NULL, '2010-10-27 00:00:00.000000', NULL, 2, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (0, 4, 6, 1, 0, NULL, 2, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 2, 1, 1, '2023-01-01 00:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', '%Y', '%Y'), (2, 2, 5, 1, 2, '2010-10-27 00:00:00.000000', NULL, NULL, '2010', NULL, NULL, 'default1', 1, 2, 2, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2010-10-27 00:00:00.000000', 'default2', '%Y'), (3, 1, 7, 0, NULL, '2010-10-27 00:00:00.000000', 2, 0, 'default1', '2010-10-27 00:00:00.000000', 'default1', 'default1', 1, 2, 2, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2010-10-27 00:00:00.000000', '2010', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.OwnerUserId, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T1.CreationDate) = '2010' ORDER BY T2.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(6, '2010')
*/

-- Prediction Query
SELECT posts.id, users.displayname FROM posts JOIN users ON posts.owneruserid = users.id ORDER BY posts.favoritecount DESC, posts.id NULLS LAST, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 'default1')
*/