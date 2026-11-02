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
-- DATASET 3
INSERT INTO posts (Id, Title) VALUES (1, 'How to tell if something happened in a data set which monitors a value over time');
INSERT INTO posts (Id, Title) VALUES (2, 'How to tell if something happened in a data set which monitors a value over time');
INSERT INTO posts (Id, Title) VALUES (3, 'Target Linked From First Match');
INSERT INTO posts (Id, Title) VALUES (4, 'Target Linked From Second Match');
INSERT INTO posts (Id, Title) VALUES (5, 'how to tell if something happened in a data set which monitors a value over time');
INSERT INTO posts (Id, Title) VALUES (6, 'Prefix How to tell if something happened in a data set which monitors a value over time Suffix');
INSERT INTO posts (Id, Title) VALUES (7, 'Should Not Be Returned');
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (10, 1, 3, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (11, 2, 4, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (12, 5, 7, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (13, 6, 7, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (14, 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Title FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN posts AS T3 ON T1.RelatedPostId = T3.Id WHERE T2.Title = 'How to tell if something happened in a data set which monitors a value over time';

/*
Gold Result:
('Target Linked From First Match',)
('Target Linked From Second Match',)
('How to tell if something happened in a data set which monitors a value over time',)
*/

-- Prediction Query
SELECT T2.Title FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.RelatedPostId = T2.Id WHERE T1.PostId = (SELECT Id FROM posts WHERE Title = 'How to tell if something happened in a data set which monitors a value over time');

/*
Prediction Result:
('Target Linked From First Match',)
('How to tell if something happened in a data set which monitors a value over time',)
*/