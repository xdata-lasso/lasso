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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 1, '2023-01-01 01:00:00.000000', 'hypothesis-testing', NULL, 'hypothesis-testing', NULL, 'default2', 1, NULL, 0, NULL, 1, 'hypothesis-testing'), (1, 1, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', 'default2', NULL, 1, 1, 1, 0, 'hypothesis-testing'), (2, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'hypothesis-testing', 'default2', 1, NULL, 0, 1, 1, 'default2'), (3, NULL, NULL, NULL, NULL, 'default1', NULL, 'default1', 1, 0, NULL, 0, 0, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 3, 1, 1, 0, NULL, 1, NULL, 'default2', '2023-01-01 00:00:00.000000', 'hypothesis-testing', 'default2', 1, NULL, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (1, 0, 3, 0, 0, '2023-01-01 00:00:00.000000', 1, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 1, 0, 0, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', NULL), (2, 0, 3, 0, NULL, NULL, 0, NULL, NULL, NULL, 'hypothesis-testing', 'default2', NULL, 0, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (3, NULL, NULL, NULL, 0, '2023-01-01 00:00:00.000000', 0, NULL, 'hypothesis-testing', NULL, 'default2', NULL, 0, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 'hypothesis-testing'), (4, 0, 3, 0, 0, NULL, 1, 0, 'hypothesis-testing', '2023-01-01 01:00:00.000000', 'hypothesis-testing', 'default2', NULL, 0, 1, '2023-01-01 00:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (5, 2, 3, 1, 0, '2023-01-01 00:00:00.000000', 0, NULL, 'hypothesis-testing', NULL, 'default2', 'hypothesis-testing', NULL, 0, 0, '2023-01-01 01:00:00.000000', NULL, NULL, '2023-01-01 00:00:00.000000', 'hypothesis-testing', 'default2'), (6, 1, 3, 1, 0, '2023-01-01 00:00:00.000000', 0, 0, 'hypothesis-testing', '2023-01-01 00:00:00.000000', 'default2', 'default1', 0, 0, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (7, 3, NULL, 0, NULL, '2023-01-01 00:00:00.000000', 0, 0, 'default1', '2023-01-01 00:00:00.000000', 'hypothesis-testing', 'default1', NULL, 0, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL), (8, NULL, 3, 1, 1, '2023-01-01 01:00:00.000000', 0, 1, 'hypothesis-testing', NULL, 'default1', 'hypothesis-testing', 1, NULL, 1, '2023-01-01 01:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', 'default1', NULL), (9, NULL, 3, 1, 0, '2023-01-01 01:00:00.000000', NULL, 1, 'default2', NULL, NULL, NULL, 1, 0, 0, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'hypothesis-testing', 'default1');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (0, 3, 'default1', 1, 1), (1, 2, NULL, 1, 0), (2, 0, NULL, 1, 1), (3, 6, 'default2', 1, NULL), (4, 1, NULL, NULL, NULL), (5, 7, 'default2', 0, NULL), (6, 5, 'hypothesis-testing', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.DisplayName, T3.Location FROM tags AS T1 INNER JOIN posts AS T2 ON T1.ExcerptPostId = T2.Id INNER JOIN users AS T3 ON T3.Id = T2.OwnerUserId WHERE T1.TagName = 'hypothesis-testing';

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Location FROM tags AS T1 INNER JOIN users AS T2 ON T1.ExcerptPostId = T2.Id WHERE T1.TagName = 'hypothesis-testing';

/*
Prediction Result:
*/