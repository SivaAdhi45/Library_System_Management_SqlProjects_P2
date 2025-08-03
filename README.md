# 📚 SQL Project 2: Library Management System

Welcome to Project 2 of my SQL portfolio! This project showcases a comprehensive **Library Management System** built using MySQL. It demonstrates database design, relational integrity, CRUD operations, stored procedures, and advanced SQL queries—all with a real-world library use case in mind.

---

## 🧩 Project Structure

The project includes the creation of the following key database tables:

- `branch` — Stores branch info like address, contact, and manager.
- `employees` — Stores employee details mapped to branches.
- `books` — Contains book metadata and rental status.
- `members` — Information on library members.
- `issued_status` — Tracks books that have been issued.
- `return_status` — Tracks book returns.

These tables are linked using **foreign keys** to maintain referential integrity and ensure relational accuracy.

---

## 🛠️ Technologies Used

- **Database**: MySQL
- **SQL Concepts**: DDL, DML, Joins, Group By, Subqueries, Stored Procedures, CTAS (Create Table As Select), Aggregate Functions
- **Tools**: MySQL Workbench / phpMyAdmin / VS Code + SQL extensions

---

## 🗃️ How to Use

1. **Create the Database**  
   Run the following:
   ```sql
   CREATE DATABASE p2_library_db;
   USE p2_library_db;
   ```

2. **Execute Table Scripts**  
   Run all table creation queries in the given `.sql` file to initialize the schema.

3. **Insert Test Data**  
   You can insert your own sample data or use insert queries to simulate records.

4. **Run SQL Tasks**  
   All project tasks can be run sequentially to explore different features of the system.

---

## 🎯 Project Tasks Overview

Here are the key SQL tasks performed in the project:

### 🧱 Basic CRUD
- ✅ Create a new book record
- ✅ Update a member’s address
- ✅ Delete an issued record

### 🔍 Data Retrieval
- 📘 Retrieve all books issued by a specific employee
- 👥 Find members who issued more than one book
- 📚 Get all books in a specific category
- 🧾 Generate total rental income by category
- 🕵️ Identify overdue members and their fine amount

### 🧠 Advanced Operations
- ⚙️ Create views and summary tables using `CTAS`
- 🔁 Track books not yet returned using joins
- 🧑‍🏫 Show employees with their manager’s name and branch details
- 🔐 Create stored procedures to handle issuing and returning books
- 🔥 Generate branch performance report
- 🌟 Highlight active members based on activity
- 🥇 List employees who processed the most book issues
- 👻 Find members who rented horror books more than once

---

## 📜 Stored Procedures Implemented

### 🔄 `Add_returned_books`
Automates the process of marking a book as returned and updates the book's status back to "Yes".

### 📕 `Issuing_books`
Handles the logic for issuing a book only if it's currently available.

These procedures enhance **data integrity** and **reusability**, and they simulate real-world automation in library systems.

---

## 📊 Highlight: Analytics Tables

| Table Name         | Description                                      |
|--------------------|--------------------------------------------------|
| `Book_issued_cnt`  | Shows how often each book has been issued        |
| `Active_members`   | Lists members who issued more than 3 books       |
| `Member_Overdues`  | Lists members with overdue books and fine amount |

---

## 📅 Assumptions

- A book must be returned within 90 days.
- Fines for overdue books are calculated at **$0.50/day after 30 days**.
- Each employee belongs to one branch; each branch has one manager.

---

## 🔚 Conclusion

This project not only reinforces **core SQL concepts** but also mimics how a real-world library might use relational databases for efficient operations. It’s perfect for showcasing **intermediate to advanced SQL proficiency**.

---

## 🤝 Let's Connect!

If you have any questions, feedback, or want to collaborate, feel free to connect with me on [LinkedIn](#) or [GitHub](#).

---

> **Note**: This project is for educational/demo purposes. It can be enhanced by integrating a front-end interface, triggers for automation, and transaction handling for concurrency control.
