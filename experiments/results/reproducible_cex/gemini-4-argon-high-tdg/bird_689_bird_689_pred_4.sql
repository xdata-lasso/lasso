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
-- DATASET 1
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (10, 183, '2019-01-01 00:00:00', 'DecoyUser10', '2020-01-01 00:00:00', 'http://decoy10.com', 'DecoyCity10', 'About10', 183, 183, 183, 183, 183, 'img10.png');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (183, 500, '2019-02-01 00:00:00', 'TargetUser183', '2020-02-01 00:00:00', 'http://target183.com', 'TargetLocation183', 'About183', 50, 20, 5, 999, 30, 'img183.png');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (200, 100, '2019-03-01 00:00:00', 'EditorUser200', '2020-03-01 00:00:00', 'http://editor200.com', 'EditorCity200', 'About200', 10, 1, 0, 200, 25, 'img200.png');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (183, 1, 183, '2020-01-01 00:00:00', 183, 183, 'Decoy body', 10, '2021-01-01 00:00:00', 'Decoy Title', '<tag>', 183, 183, 183, 183, '2022-01-01 00:00:00', 183, 'FakeOwner183', 'FakeEditor183');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (1, 1, NULL, '2020-02-01 00:00:00', 10, 100, 'Post 1 by 183', 183, '2020-05-01 00:00:00', 'Title 1', '<sql>', 2, 1, 0, 200, '2020-05-01 00:00:00', NULL, 'WrongDisplay1', 'Editor200');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (2, 1, NULL, '2020-03-01 00:00:00', 20, 200, 'Post 2 by 183', 183, '2021-06-01 00:00:00', 'Title 2', '<sql>', 3, 2, 1, 200, '2021-06-01 00:00:00', NULL, 'WrongDisplay2', 'Editor200');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (3, 2, NULL, '2020-04-01 00:00:00', 30, 300, 'Post 3 by 183', 183, '2020-04-01 00:00:00', 'Title 3', NULL, 0, 0, 0, NULL, NULL, 1, 'WrongDisplay3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.Id = 183 ORDER BY T1.LastEditDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('TargetUser183', 'TargetLocation183')
*/

-- Prediction Query
SELECT p.LastEditorDisplayName, u.Location FROM posts AS p LEFT JOIN users AS u ON p.LastEditorUserId = u.Id WHERE p.Id = 183 ORDER BY p.LastEditDate DESC, p.id NULLS LAST, u.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('FakeEditor183', 'TargetLocation183')
*/