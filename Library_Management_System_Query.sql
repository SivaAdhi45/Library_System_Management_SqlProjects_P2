-- SQL Library Management System Project 2

-- Creating database

Create database p2_library_db;

-- Creating branch table

Create table branch 
	(
	 branch_id varchar(5),
     Manager_id varchar(5),
     Branch_address varchar(100),
     Contact_no varchar(20),
     primary key(branch_id)
	);

-- Creating employees table

Create table employees
	(
	 Emp_id varchar(10),
     Emp_name varchar(25),
     Position varchar(20),
     salary float,
     branch_id varchar(10),
     primary key(emp_id)
	);

-- Creating books table

Create table books
	(
     isbn Varchar(25),
     book_title varchar(75),
     category varchar(25),
     rental_price float,
     status	varchar(10),
     author varchar(30),
     publisher varchar(50),
     primary key(isbn)
	);

-- Creating Issued_status table

create table issued_status 
	(
     issued_id varchar(10),
     issued_member_id varchar(10),
     issued_book_name varchar(75),
     issued_date date,
     issued_book_isbn varchar(25),
     issued_emp_id varchar(10),
     primary key(issued_id)
	);

-- Creating members table

Create table members
	(
     member_id varchar(10),
     member_name Varchar(50),
     member_address varchar(75),
     reg_date date,
     primary key(member_id)
	);

-- creating table return_status

Create table return_status
	(
     return_id varchar(10),
     issued_id varchar(10),
     return_book_name varchar(75),
     return_date date,
     return_book_isbn varchar(25),
     primary key(return_id)
	);

-- Adding foreign keys

Alter table issued_status
add constraint fk_memberid
foreign key(issued_member_id) references members(member_id);

Alter table issued_status
add constraint fk_book_isbn
foreign key(issued_book_isbn) references books(isbn);

alter table issued_status
add constraint fk_emp_id
foreign key(issued_emp_id) references employees(emp_id);

alter table return_status
add constraint fk_issued_id
foreign key(issued_id) references issued_status(issued_id);

alter table return_status
add constraint fk_return_isbn
foreign key(return_book_isbn) references books(isbn);

alter table employees
add constraint fk_branch_id
foreign key(branch_id) references branch(branch_id);

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

-- Project Task

-- Task 1: Create a New Book Record "('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

Insert into books
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

select * from books;

-- Task 2: Update an Existing Member's Address

update members
set member_address='45 Pool St'
where member_id='c102';

select * from members;

-- Task 3: Delete a Record from the Issued Status Table. Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id ='is121';

select * from issued_status;

-- Task 4: Retrieve All Books Issued by a Specific Employee. Objective: Select all books issued by the employee with emp_id = 'E101'.

select issued_book_name from issued_status
where issued_emp_id='E101';

-- Task 5: List Members Who Have Issued More Than One Book. Objective: Use GROUP BY to find members who have issued more than one book.

select issued_member_id, count(*) as Issued_count
from issued_status
group by issued_member_id
having count(*)>1;

-- Task 6: Create Summary Tables: Use CTAS to generate new tables based on query results - each book and total book_issued_cnt**

create table Book_issued_cnt as
(select b.isbn,b.book_title,count(iss.issued_book_isbn) as Issued_count
from books as b
left join issued_status as iss
on b.isbn=iss.issued_book_isbn
group by b.isbn,b.book_title
order by issued_count desc,1 asc);

select * from book_issued_cnt;

-- Task 7. Retrieve All Books in a Specific Category:

select * from books
where category='Mystery';

-- Task 8: Find Total Rental Income by Category:

select b.category, sum(b.rental_price) as Total_Rental_Price
from books b
inner join issued_status iss
on b.isbn=iss.issued_book_isbn
group by b.category
order by Total_Rental_Price desc;

-- Task 9: List Members Who Registered in the Last 700 Days:

Select * from members
where reg_date >= (curdate() - interval 700 day);

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:

Select e.emp_id,e.emp_name,b.branch_id,b.Manager_id, b.branch_address, b.contact_no,e1.emp_name as Manager
from employees e
inner join branch b on e.branch_id=b.branch_id
inner join employees e1 on b.manager_id=e1.emp_id
order by e.Emp_id;

-- Task 11: Create a Table of Books with Rental Price Above a Certain Threshold:

Create table Expensive_books as 
select * from books
where rental_price>=8;

select * from expensive_books;

-- Task 12: Retrieve the List of Books Not Yet Returned:

SELECT * FROM issued_status as ist
LEFT JOIN return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

-- Advanced SQL Operations:

-- Task 13: Identify Members with Overdue Books. 
-- Write a query to identify members who have overdue books (assume a 90 days return period). Display the member's_id, member's name, book title, issue date, and days overdue.

Select m.member_id,m.member_name, iss.issued_book_name, iss.issued_date,r.return_date, datediff(Curdate(),iss.Issued_date) as Overdue_days
from members m
inner join issued_status iss
on m.member_id=iss.issued_member_id
left join return_status r
on iss.issued_id=r.issued_id
where r.return_date is null
and datediff(curdate(),iss.Issued_date) > 90
order by 1;

-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

Delimiter $$
Create procedure Add_returned_books ( in returns_id varchar(10), in issueds_id varchar(10), in returns_book_isbn varchar(25))
begin 

declare v_isbn varchar(25);
declare v_title varchar(75);

-- insering values into return_status table

insert into return_status(return_id,issued_id,return_date,return_book_isbn)
values (returns_id,issueds_id,curdate(),returns_book_isbn);

select issued_book_isbn,issued_book_name
into v_isbn,v_title
from issued_status
where issued_id=issueds_id;

Update books
set status="yes"
where isbn = v_isbn;

select concat('Thank you for returning the book ', v_title);

end $$

delimiter ;

call Add_returned_books('RS120','IS136','978-0-7432-7357-1');

Select * from return_status;
select * from issued_status;
Select * from books;

call add_returned_books('Rs121','IS134','978-0-375-41398-8');

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

Select br.branch_id, count(iss.issued_id),count(r.return_id), Sum(b.rental_price)
from branch br
left join employees e
on br.branch_id=e.branch_id
left join issued_status iss
on e.emp_id=iss.issued_emp_id
left join books b
on iss.issued_book_isbn=b.isbn
left join return_status r
on b.isbn=r.return_book_isbn
group by br.branch_id;

select sum(rental_Price)
from books b
join issued_status iss
on b.isbn=iss.issued_book_isbn;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued more than 3 books.

Create table Active_members as (Select * from members
where member_id in (Select issued_member_id
from issued_status
group by issued_member_id
having count(*) >3));

Select * from active_members;

-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

Select * from issued_status;
select * from employees;

Select e.emp_name,count(iss.issued_id) as Total_issued,e.branch_id
from employees e
inner join issued_status iss
on e.Emp_id=iss.issued_emp_id
group by e.Emp_name,e.branch_id
order by total_issued desc
limit 3;

-- Task 18: Identify Members renting more horror Books
-- Write a query to identify members who have renting horror books more than one. Display the member name and the number of horror books they have rented.

Select m.member_name, count(iss.issued_book_isbn) as horror_books_count
from members m
join issued_status iss
on m.member_id=iss.issued_member_id
join books b
on iss.issued_book_isbn=b.isbn
where b.category="Horror"
group by m.member_name;

/* Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). 
If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available. */

Drop procedure if exists Issuing_books;
Delimiter $$

Create procedure Issuing_books(in Iss_id varchar(10),in iss_mem_id varchar(10), in Iss_book_name varchar(75), in iss_book_isbn varchar(25), in iss_emp_id varchar(10))
begin

declare V_status varchar(10);
declare V_book_name varchar(75);

-- all the codes
Select b.status,b.book_title
into V_status,V_book_name
from books b
where isbn=iss_book_isbn;

If v_status='Yes' Then
     insert into issued_status (Issued_id,Issued_member_id,issued_book_name,issued_date,Issued_book_isbn,Issued_emp_id)
	 values (iss_id,iss_mem_id,iss_book_name,curdate(),iss_book_isbn,iss_emp_id);
     Update books 
     set status ='No' 
     where isbn=iss_book_isbn;
     Select concat('The book \'',v_book_name,'\' is succesfully issued.') as Issue_status;
Else
	Select concat('The book \'',v_book_name,'\' is currently not available.') as Issue_status;
End if;  

END $$

Delimiter ;

Call issuing_books('IS145','C108','Dune','978-0-345-39180-3','E103');
call Issuing_books('IS147','C107','The Alchemist','978-0-307-37840-1','E104');

Select * from issued_status;
Select * from books;

/* Task 20: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days.
The resulting table should show: Member ID, Number of overdue books, Total fines. The total fines, with each day's fine calculated at $0.50.*/

Create table Member_Overdues as
(Select iss.issued_member_id as Member_ID, count(iss.issued_id) as No_of_Books, sum((datediff(curdate(),iss.issued_date)-30)*0.5) as Total_fines
from issued_status iss
join return_status r
on iss.issued_id=r.issued_id
where datediff(r.return_date,iss.issued_date) >30
group by Member_ID
order by Total_fines desc);

Select * from Member_Overdues;

-- THE END
