CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(101, 1, '123 Main St, City Center', '9876543210'),
(102, 2, '45 West St, Uptown', '9876543220'),
(103, 3, '78 East St, Downtown', '9876543230');


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('9780131101630', 'C Programming Language', 'Programming', 35.00, 'yes', 'Brian Kernighan, Dennis Ritchie', 'Prentice Hall'),
('9780596009205', 'Head First Java', 'Programming', 45.00, 'no', 'Kathy Sierra, Bert Bates', 'OReilly Media'),
('9780262033848', 'Introduction to Algorithms', 'Algorithms', 55.00, 'yes', 'Thomas H. Cormen', 'MIT Press'),
('9781451673319', 'The History of Ancient Rome', 'History', 40.00, 'yes', 'Mary Beard', 'Liveright Publishing'),
('9780439139601', 'Harry Potter and the Goblet of Fire', 'Fiction', 30.00, 'no', 'J.K. Rowling', 'Scholastic'),
('9780307275558', 'The History of the World', 'History', 50.00, 'yes', 'J.M. Roberts', 'Oxford University Press');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'John Doe', 'Manager', 75000, 101),
(2, 'Jane Smith', 'Manager', 70000, 102),
(3, 'Tom Brown', 'Manager', 68000, 103),
(4, 'Emily Davis', 'Librarian', 45000, 101),
(5, 'Michael Wilson', 'Librarian', 46000, 102),
(6, 'Olivia Johnson', 'Assistant', 30000, 103);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1001, 'Alice Walker', '22 Maple St, Springfield', '2021-05-15'),
(1002, 'Bob Johnson', '85 River Rd, Springfield', '2020-11-30'),
(1003, 'Charlie Davis', '16 Oak Ave, Greenville', '2022-03-21'),
(1004, 'Diana King', '102 Cedar St, Greenville', '2023-06-01'),
(1005, 'Evan White', '49 Pine Ln, Springfield', '2021-12-19');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(2001, 1001, 'The History of Ancient Rome', '2023-06-15', '9781451673319'),
(2002, 1003, 'C Programming Language', '2023-06-10', '9780131101630'),
(2003, 1004, 'Introduction to Algorithms', '2023-06-12', '9780262033848');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(3001, 1001, 'The History of Ancient Rome', '2023-06-25', '9781451673319'),
(3002, 1003, 'C Programming Language', '2023-06-20', '9780131101630');



#Queries
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT B.Book_title, C.Customer_name
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

SELECT Category, COUNT(*) AS Total_books
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT C.Customer_name
FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issued_cust IS NULL;

SELECT Branch_no, COUNT(*) AS Total_employees
FROM Employee
GROUP BY Branch_no;

SELECT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Employee_count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

SELECT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;












