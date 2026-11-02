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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, '2023-01-01 00:00:00.000000', '<humor>', '2023-01-01 01:00:00.000000', '<humor>', '<humor>', '<humor>', 0, 0, 1, 1, 0, 'default2'), (0, 0, '2023-01-01 01:00:00.000000', ' < humor > ', '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default2', NULL, 1, NULL, NULL, 0, 'default1'), (2, 1, NULL, '<humor>', NULL, 'default1', 'default2', ' < humor > ', NULL, NULL, NULL, 0, NULL, 'default1'), (3, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', ' < humor > ', 'default1', 0, 0, 1, 1, 0, NULL), (4, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', '<humor>', NULL, ' < humor > ', 0, 1, 1, NULL, 0, 'default1'), (5, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 'default1', NULL, NULL, NULL, 0, NULL, 0, '<humor>'), (6, 0, NULL, ' < humor > ', '2023-01-01 01:00:00.000000', ' < humor > ', 'default1', ' < humor > ', 0, 1, 1, 1, NULL, 'default1'), (7, 1, NULL, ' < humor > ', '2023-01-01 00:00:00.000000', '<humor>', NULL, 'default1', 0, NULL, 1, 0, 0, NULL), (8, 0, '2023-01-01 00:00:00.000000', ' < humor > ', '2023-01-01 01:00:00.000000', NULL, ' < humor > ', NULL, 1, 1, 1, NULL, 1, 'default2'), (9, 0, NULL, ' < humor > ', '2023-01-01 00:00:00.000000', '<humor>', 'default2', ' < humor > ', NULL, NULL, NULL, 0, 1, 'default1'), (10, 1, '2023-01-01 00:00:00.000000', NULL, NULL, ' < humor > ', NULL, ' < humor > ', 1, NULL, 1, NULL, 1, '<humor>');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 2, 10, 0, NULL, NULL, NULL, 0, 'default1', '2023-01-01 01:00:00.000000', '<humor>', 'default1', NULL, 0, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', ' < humor > '), (1, 7, 3, 0, 1, '2023-01-01 01:00:00.000000', 1, 1, ' < humor > ', NULL, 'default2', ' < humor > ', 1, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', ' < humor > ', 'default2'), (2, 9, 6, NULL, NULL, NULL, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', ' < humor > ', 'default1', NULL, 1, 1, NULL, '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', ' < humor > ', ' < humor > '), (3, NULL, 10, NULL, 1, '2023-01-01 00:00:00.000000', NULL, NULL, '<humor>', NULL, NULL, 'default2', 1, NULL, 0, NULL, NULL, 1, NULL, '<humor>', 'default2'), (4, 8, 4, 0, 0, NULL, NULL, 0, NULL, '2023-01-01 00:00:00.000000', '<humor>', ' < humor > ', 0, 0, 1, '2023-01-01 01:00:00.000000', NULL, 1, '2023-01-01 01:00:00.000000', NULL, 'default1'), (5, 0, 1, 0, NULL, '2023-01-01 01:00:00.000000', 0, 0, NULL, '2023-01-01 01:00:00.000000', ' < humor > ', ' < humor > ', 1, 0, 1, NULL, NULL, NULL, NULL, 'default1', ' < humor > '), (6, 10, 0, 1, 1, '2023-01-01 01:00:00.000000', NULL, 0, ' < humor > ', '2023-01-01 00:00:00.000000', '<humor>', '<humor>', NULL, NULL, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 01:00:00.000000', '<humor>', NULL), (7, 8, 5, NULL, 0, NULL, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', ' < humor > ', 0, 1, 1, NULL, NULL, 0, NULL, ' < humor > ', NULL);
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (1, 0, 4, NULL, 'default1', '2023-01-01 01:00:00.000000', NULL), (0, 1, 2, 1, NULL, NULL, 'default2'), (2, 7, 4, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default2'), (3, 5, 7, 0, ' < humor > ', NULL, ' < humor > '), (4, 3, 3, 1, '<humor>', NULL, NULL), (5, 5, NULL, 0, NULL, '2023-01-01 01:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.ViewCount), T2.Title, T1.Text FROM comments AS T1 INNER JOIN posts AS T2 ON T1.Id = T1.PostId WHERE T2.Tags = '<humor>';

/*
Gold Result:
(0.0, '<humor>', None)
*/

-- Prediction Query
SELECT AVG(posts.ViewCount) AS AverageViewCount, posts.Title, comments.Text FROM tags INNER JOIN posts ON tags.Id = posts.PostTypeId INNER JOIN comments ON posts.Id = comments.PostId WHERE tags.TagName = ' < humor > ';

/*
Prediction Result:
(None, None, None)
*/