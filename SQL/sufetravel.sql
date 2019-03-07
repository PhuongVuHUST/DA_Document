USE master
GO

CREATE DATABASE sufetravel
GO

/**cac bang ve account va company**/
CREATE TABLE users(
	id int primary key,
	name NVARCHAR(255) NOT NULL,
	email NVARCHAR(255) NOT NULL,
	phone NVARCHAR(12) NOT NULL,
	token NVARCHAR(255) NULL,
	address NVARCHAR(255) NOT NULL,
	brithday DATE NOT NULL,
	image NVARCHAR(255) NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,

)
GO

CREATE TABLE admins(
	id int primary key,
	name NVARCHAR(255) NOT NULL,
	email NVARCHAR(255) NOT NULL,
	phone NVARCHAR(12) NOT NULL,
	token NVARCHAR(255) NULL,
	address NVARCHAR(255) NOT NULL,
	brithday DATE NOT NULL,
	image NVARCHAR(255) NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
)
GO
CREATE TABLE companies(
	id int primary key,
	name NVARCHAR(255) NOT NULL,
	phone NVARCHAR(12) NOT NULL,
	address NVARCHAR(255) NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
)

GO
CREATE TABLE employees(
	id int primary key,
	company_id int NOT NULL,
	user_id int NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_company_id_employees FOREIGN KEY (company_id) REFERENCES companies(id),
	CONSTRAINT fk_user_id_employees FOREIGN KEY (user_id) REFERENCES users(id)
)

GO
CREATE TABLE payments(
	company_id int,
	user_id int,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_company_id_payments FOREIGN KEY (company_id) REFERENCES companies(id),
	CONSTRAINT fk_user_id_payments FOREIGN KEY (user_id) REFERENCES users(id)
)

GO
CREATE TABLE roles(
	id INT PRIMARY KEY,
	name NVARCHAR(255) NOT NULL,
	display_name NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
)

GO
CREATE TABLE role_admin(
	admin_id int NOT NULL,
	role_id int NOT NULL,
	PRIMARY KEY(admin_id, role_id),
	CONSTRAINT fk_admin_id_role_admin FOREIGN KEY (admin_id) REFERENCES admins(id),
	CONSTRAINT fk_role_id_role_admin FOREIGN KEY (role_id) REFERENCES roles(id),
)

GO
CREATE TABLE role_user(
	admin_id int NOT NULL,
	role_id int NOT NULL,
	PRIMARY KEY(admin_id, role_id),
	CONSTRAINT fk_admin_id_role_user FOREIGN KEY (admin_id) REFERENCES users(id),
	CONSTRAINT fk_role_id_role_user FOREIGN KEY (role_id) REFERENCES roles(id),
)

GO
CREATE TABLE permissions(
	id INT PRIMARY KEY,
	name NVARCHAR(255) NOT NULL,
	display_name NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
)

GO
CREATE TABLE permission_role(
	permission_id int NOT NULL,
	role_id int NOT NULL,
	PRIMARY KEY(permission_id, role_id),
	CONSTRAINT fk_permission_id_permission_role FOREIGN KEY (permission_id) REFERENCES permissions(id),
	CONSTRAINT fk_role_id_permission_role FOREIGN KEY (role_id) REFERENCES roles(id),
)

/**cac bang ve dich vu**/
go 
CREATE TABLE tours(
	id INT PRIMARY KEY,
	image NVARCHAR(255) NOT NULL,
	title NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL,
	price	INT NOT NULL,
	quantity INT NULL DEFAULT 0,
	content NVARCHAR NOT NULL,
	user_id	INT NOT NULL,
	company_id INT NOT NULL,
	status	BIT NOT NULL DEFAULT 1,
	booked	INT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_tours FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_tours FOREIGN KEY (company_id) REFERENCES companies(id),
)

GO
CREATE TABLE cars(
	id INT PRIMARY KEY,
	image NVARCHAR(255) NOT NULL,
	series NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL,
	price	INT NOT NULL,
	seat INT NULL DEFAULT 0,
	content NVARCHAR NOT NULL,
	user_id	INT NOT NULL,
	company_id INT NOT NULL,
	status	BIT NOT NULL DEFAULT 1,
	booked	INT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_cars FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_cars FOREIGN KEY (company_id) REFERENCES companies(id),
)
GO
CREATE TABLE tour_type(
	tour_id int NOT NULL,
	type BIT NOT NULL,
	PRIMARY KEY(tour_id, type),
	CONSTRAINT fk_tour_id_tour_type FOREIGN KEY (tour_id) REFERENCES tours(id)
)

GO
CREATE TABLE bills (
	id INT PRIMARY KEY,
	user_id INT NOT NULL,
	total REAL NOT NULL,
	tax REAL NULL DEFAULT 0,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_bills FOREIGN KEY (user_id) REFERENCES users(id),
)

GO
CREATE TABLE list_bill(
	id INT PRIMARY KEY,
	bill_id INT,
	product_id INT,
	name_services NVARCHAR(255), 
	prices INT,
	tax REAL,
	user_id INT,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_bill_id_list_bill FOREIGN KEY (bill_id) REFERENCES bills(id),
	CONSTRAINT fk_user_id_list_bill FOREIGN KEY (user_id) REFERENCES users(id),
)

GO 
CREATE TABLE hotel_type(
	id INT PRIMARY KEY,
	name NVARCHAR,
	company_id INT,
	user_id INT,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_hotel_type FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_hotel_type FOREIGN KEY (company_id) REFERENCES companies(id),
)
GO
CREATE TABLE hotels(
	id INT PRIMARY KEY,
	image NVARCHAR(255) NOT NULL,
	name NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL,
	content NVARCHAR NOT NULL,
	address NVARCHAR NOT NULL,
	type INT NOT NULL,
	user_id	INT NOT NULL,
	company_id INT NOT NULL,
	status	BIT NOT NULL DEFAULT 1,
	booked	INT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_hotels FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_hotels FOREIGN KEY (company_id) REFERENCES companies(id),
)

GO
CREATE TABLE rooms(
	id INT PRIMARY KEY,
	hotel_id NVARCHAR(255) NOT NULL,
	seat INT NOT NULL,
	content NVARCHAR NOT NULL,
	image NVARCHAR NOT NULL,
	user_id	INT NOT NULL,
	company_id INT NOT NULL,
	status	BIT NOT NULL DEFAULT 1,
	booked	INT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_rooms FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_rooms FOREIGN KEY (company_id) REFERENCES companies(id),
)

GO
CREATE TABLE posts(
	id INT PRIMARY KEY,
	title NVARCHAR(255) NOT NULL,
	content NVARCHAR NOT NULL,
	user_id	INT NOT NULL,
	company_id INT NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_posts FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_company_id_posts FOREIGN KEY (company_id) REFERENCES companies(id),
)

GO
CREATE TABLE comments(
	id INT PRIMARY KEY,
	post_id INT NOT NULL,
	content NVARCHAR NOT NULL,
	user_id	INT NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NULL,
	CONSTRAINT fk_user_id_comments FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_post_id_comments FOREIGN KEY (post_id) REFERENCES posts(id),
)

