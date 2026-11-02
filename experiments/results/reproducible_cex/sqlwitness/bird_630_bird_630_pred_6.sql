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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, '2023-01-01 00:00:00.000000', 'John Salvatier', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 1, 1, NULL, 1, 1, 'John Salvatier'), (0, NULL, '2023-01-01 01:00:00.000000', 'John Salvatier', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', 1, 1, 0, 1, 1, 'default1'), (2, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1', 'default2', 'John Salvatier', 1, 1, NULL, 1, NULL, 'default2'), (3, NULL, NULL, 'default1', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1', NULL, 0, NULL, 0, 1, 'default1'), (4, NULL, NULL, NULL, NULL, 'John Salvatier', 'default1', NULL, 0, 0, 0, NULL, NULL, 'John Salvatier'), (5, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', 'default1', 'John Salvatier', 1, NULL, 1, 1, 0, 'default1'), (6, 1, NULL, 'default1', '2023-01-01 00:00:00.000000', 'John Salvatier', 'John Salvatier', NULL, 0, 1, NULL, 1, 1, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 3, NULL, 0, NULL, '2023-01-01 00:00:00.000000', 1, 0, 'John Salvatier', NULL, 'default2', NULL, 1, 0, 1, NULL, '2023-01-01 01:00:00.000000', 0, NULL, 'John Salvatier', NULL), (1, NULL, 4, 0, 1, '2023-01-01 01:00:00.000000', 1, 0, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default1', NULL, NULL, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default2', 'default2'), (2, 4, 4, NULL, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', NULL, NULL, 'default2', 1, 1, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, 'John Salvatier'), (3, 0, 0, NULL, NULL, NULL, NULL, NULL, 'default2', '2023-01-01 00:00:00.000000', 'John Salvatier', 'default1', NULL, 0, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 'default1'), (4, 4, 1, 1, 1, '2023-01-01 00:00:00.000000', NULL, 1, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 1, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', NULL, 'default2');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (0, 3, 'default1', 0, 0), (1, 4, NULL, 1, NULL), (2, 4, 'default1', 0, 1), (3, 4, 'John Salvatier', NULL, 0), (4, 0, 'default1', NULL, 1), (5, NULL, 'John Salvatier', 1, 1), (6, 0, 'default2', NULL, NULL);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, 3, 4, 0, 'John Salvatier', '2023-01-01 01:00:00.000000', 'default2', NULL, 'John Salvatier'), (0, 2, 5, 1, 'John Salvatier', '2023-01-01 01:00:00.000000', NULL, 'John Salvatier', 'default1'), (2, 2, 1, NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'John Salvatier', 'default2'), (3, 3, 0, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'John Salvatier';

/*
Gold Result:
('default2',)
('default1',)
*/

-- Prediction Query
SELECT tags.TagName FROM users INNER JOIN posts ON users.Id = posts.OwnerUserId INNER JOIN tags ON posts.PostTypeId = tags.Id WHERE users.DisplayName = 'John Salvatier';

/*
Prediction Result:
(None,)
*/