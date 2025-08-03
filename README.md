# 📚 SQL Project 2: Library Management System

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `p2_library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.


## 🧩 Project Structure

The project includes the creation of the following key database tables:

- `branch` — Stores branch info like address, contact, and manager.
- `employees` — Stores employee details mapped to branches.
- `books` — Contains book metadata and rental status.
- `members` — Information on library members.
- `issued_status` — Tracks books that have been issued.
- `return_status` — Tracks book returns.

These tables are linked using **foreign keys** to maintain referential integrity and ensure relational accuracy.


## Database Setup



## 🎯 Project Tasks Overview

Here are the key SQL tasks performed in the project:

### Basic CRUD
- ✅ Create a new book record
- ✅ Update a member’s address
- ✅ Delete an issued record

### Data Retrieval
-  Retrieve all books issued by a specific employee
-  Find members who issued more than one book
-  Get all books in a specific category
-  Generate total rental income by category
-  Identify overdue members and their fine amount

### 🧠 Advanced Operations
-  Create views and summary tables using `CTAS`
-  Track books not yet returned using joins
-  Show employees with their manager’s name and branch details
-  Create stored procedures to handle issuing and returning books
-  Generate branch performance report
-  Highlight active members based on activity
-  List employees who processed the most book issues
-  Find members who rented horror books more than once


## 📜 Stored Procedures Implemented

###  `Add_returned_books`
Automates the process of marking a book as returned and updates the book's status back to "Yes".

###  `Issuing_books`
Handles the logic for issuing a book only if it's currently available.

These procedures enhance **data integrity** and **reusability**, and they simulate real-world automation in library systems.


## 📊 Highlight: Analytics Tables

| Table Name         | Description                                      |
|--------------------|--------------------------------------------------|
| `Book_issued_cnt`  | Shows how often each book has been issued        |
| `Active_members`   | Lists members who rented more than 3 books       |
| `Member_Overdues`  | Lists members with overdue books and fine amount |


## 🔚 Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.
