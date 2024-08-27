create database company;
use company;
show tables;

CREATE TABLE Employe (
    order_id INT PRIMARY KEY,
    customer_id INT,
    Customer_name varchar(200),
    product VARCHAR(255),
    order_date DATE,
    quantity INT,
    price DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    status_ VARCHAR(50)
);

INSERT INTO Employe (order_id, customer_id, customer_name, product, order_date, quantity, price, total_amount, status_)
VALUES
(1, 101, 'John Doe', 'Laptop', '2023-01-15', 1, 900.00, 900.00, 'Delivered'),
(2, 102, 'Jane Doe', 'Mobile Phone', '2023-02-20', 2, 450.00, 900.00, 'Delivered'),
(3, 103, 'Alice Smith', 'Tablet', '2023-03-05', NULL, 300.00, NULL, 'Pending'),
(4, 104, NULL, 'Headphones', '2023-04-10', 3, 50.00, 150.00, 'Delivered'),
(5, 101, 'John Doe', 'Laptop', '2023-01-15', 1, 900.00, 900.00, 'Delivered'),
(6, 105, 'Bob Johnson', NULL, '2023-05-25', 2, 75.00, 150.00, 'Returned'),
(7, 106, 'Chris Brown', 'Mouse', '2023-06-30', 5, 20.00, 100.00, 'Cancelled'),
(8, 107, 'Emily Davis', 'Keyboard', '2023-07-15', -1, 30.00, -30.00, 'Delivered'),
(9, 108, NULL, 'Moniter', '2023-08-20', 1, 200.00, 200.00, 'Delivered'),
(10, 102, 'Jane Doe', 'Mobile Phone', '2023-09-25', 2, 450.00, 900.00, 'Returned');


select customer_id,
customer_id=customer_name
from employe;

select * from employe;

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id, customer_name, product, order_date, quantity, price, total_amount, status_ ORDER BY order_id) AS rn
    FROM Employe
)
DELETE FROM Employe
WHERE order_id IN (
    SELECT order_id
    FROM CTE
    WHERE rn > 1
);

update employe
set customer_name=case
when customer_name is null then 'Tony Stark'
end
where customer_id=104
;

update employe
set customer_name=case
when customer_name is null then 'Thor'
end
where customer_id=108;

update employe
set quantity=case
when quantity is null then 1
end,
total_amount=case
when total_amount is null then 600
end
where order_id=3;

update employe
set product=case
when product is null then "Phone Cover"
end
where order_id=6;

update employe
set quantity=case
when quantity <0 then 0
end,
total_amount=case
when total_amount<0 then 0
end
where order_id=8;

update employe
set quantity=case
when quantity is null then 1
end,
total_amount=case
when total_amount is null then 30
end
where order_id=8;

select customer_id,count(order_id) from employe
group by  customer_id
having count(customer_id)>1;


SELECT customer_name,count(*)
FROM employe
GROUP BY customer_name
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT order_id,
           ROW_NUMBER() OVER (PARTITION BY customer_id order by order_id) as row_num
		
    FROM employe
)
DELETE FROM employe
WHERE order_id in(
    SELECT order_id
    FROM CTE
    WHERE row_num > 1
);




select * from employe;
