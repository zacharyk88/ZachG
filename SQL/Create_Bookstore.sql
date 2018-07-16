CREATE DATABASE Bookstore;

USE Bookstore;

CREATE TABLE Subject (
SubjectCode	nvarchar(3) PRIMARY KEY NOT NULL,
Subject	nvarchar(15) NULL);

CREATE TABLE Book (
ISBN 		nvarchar(13)	PRIMARY KEY NOT NULL,
Title		nvarchar(50)	NULL,
Author		nvarchar(30)	NULL,
Publisher	nvarchar(30)	NULL,
Subject_Code nvarchar(3)	REFERENCES Subject (SubjectCode),
Shelf_Location nvarchar(7)	NULL,
Fiction		bit				NULL);


INSERT INTO Subject VALUES
('ART', 'Art'),
('BSN', 'Business'),
('BSS', 'Best Seller'),
('EDC', 'Education'),
('FNT', 'Fantasy'),
('HMR', 'Humor'),
('MST', 'Mystery'),
('PHL', 'Philosophy'),
('RLG', 'Religion'),
('RMN', 'Romance'),
('SCF', 'Science Fiction'),
('SLH', 'Self Help');



INSERT INTO Book VALUES
('0-111-11111-1', '89 Years in a Sand Trapxx', 'Beck, Fred', 'Hill and Wang', 'HMR', 'RC-1111', 0),
('0-15-500139-6', 'Business Programming in C', 'Millspaugh, A. C.', 'The Dryden Press', 'BSN', 'RC-1111', 0),
('0-394-75843-9', 'Cultural Literacy', 'Hirsch, E. D. Jr.', 'Vintage', 'BSS', 'RC-1115', 0),
('0-440-22284-2', 'Five Days in Paris', 'Steel, Daniells', 'Dell Publishing', 'RMN', 'RC-1114', 1),
('0-446-51251-6', 'Megatrends', 'Naisbitt, John', 'Warner Books', 'PHL', 'RC-1114', 0),
('0-446-51652-X', 'Bridges of Madison County', 'Waller, Robert James', 'Warner Books', 'BSS', 'RC-1114', 1),
('0-446-60274-4', 'The Rules', 'Fein/Schneider', 'Warner Books', 'SLH', 'RC-1111', 0),
('0-451-16095-9', 'The Stand', 'King, Stephen', 'Signet', 'MST', 'RC-1113', 1),
('0-452-26011-6', 'Song of Solomon', 'Morrison, Toni', 'Plume/Penguin', 'BSS', 'RC-1114', 1),
('0-517-59905-8', 'How to Talk to Anyone, Anytime, Anywhere', 'King, Larry', 'Crown', 'SLH', 'RC-1113', 0),
('0-534-26076-4', 'A Quick Guide to the Internet', 'Bradley, Julia Case', 'Integrated Media Group', 'BSN', 'RC-1111', 0),
('0-553-24484-X', 'Prospering Woman', 'Ross, Ruth', 'Bantam Books', 'SLH', 'RC-1111', 0),
('0-670-85332-1', 'How to be Hap-Hap-Happy Like Me', 'Markoe, Merrill', 'Viking', 'HMR', 'RC-1113', 1),
('0-671-66398-4', 'Seven Habits of Highly Effective People', 'Covey, Stepehn R.', 'Fireside', 'BSN', 'RC-1111', 0),
('0-671-67158-8', 'Time Wars', 'Rifkin, Jeremy', 'Simon and Schuster', 'PHL', 'RC-1115', 0),
('0-697-12897-0', 'QuickBasic and QBasic Using Modular Structure', 'Bradley, Julia Case', 'B & E Tech', 'BSN', 'RC-1112', 0),
('0-697-21361-7', 'Desktop Publishing Using PageMaker 5.0', 'Bradley, Julia Case', 'B & E Tech', 'BSN', 'RC-1111', 0),
('0-8007-1213-7', 'Secrets of Closing the Sale', 'Ziglar, Zig', 'Revell', 'BSN', 'RC-1112', 0),
('0-8041-0753-X', 'The Kitchen God''s Wife', 'Tan, Amy', 'Ivy Books', 'BSS', 'RC-1113', 1),
('0-8109-3158-3', 'Thomas Cole', 'Powell, Earl A.', 'Abrams', 'ART', 'RC-1112', 0),
('0-8109-8052-5', 'The Art of Walt Disney', 'Finch, Christopher', 'Abradale', 'ART', 'RC-1112', 0),
('0-8487-0504', 'Erica Wilson''s Quilts of America', 'Wilson, Erica', 'Oxmoor House', 'ART', 'RC-1112', 0),
('0-87826-2', 'Know Your Lhaso Apso', 'Schneider, Earl', 'The Pet Library LTD', 'SLH', 'RC-1112', 0),
('0-89997=087-7', 'Afoot and Afield in Orange County', 'Schad, Jerry', 'Wilderness Press', 'SLH', 'RC-1112', 0),
('0-915391-40-6', 'Designing User Interfaces', 'Powell, James E.', 'Microtrend', 'BSN', 'RC-1114', 0),
('0-917849-25-6', 'I am enough', 'Stortz, Margaret', 'Science of Mind', 'PHL', 'RC-1115', 0),
('0-934136-27-0', 'Wine Makers Guide', 'Nury/Fugelsang', 'Western Tanager', 'MST', 'RC-1112', 0),
('0-9616878-6-X', 'Classics, US Aircraft of World War II', 'Meyer, Mark', 'Howell Press', 'ART', 'RC-1112', 0),
('1-55615-484-4', 'Code Complete', 'Mc Connell, Steve', 'Microsoft Press', 'BSN', 'RC-1115', 0),
('1-8423-2218-3', 'The Way', 'Chaney, Elana', 'Tyndale', 'RLG', 'RC-1111', 0);














