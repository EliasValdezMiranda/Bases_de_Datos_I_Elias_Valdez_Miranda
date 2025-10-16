/*
Actividad 19 - Integridad Referencial: ON DELETE
Valdez Miranda Elias
Ingeniería en Sistemas de Información, Universidad de Sonora
Clave 4116: Bases de Datos I
Profesor Navarro Hernández Rene Francisco
16 de octubre de 2025
*/

-- Se eliminan las tablas si existen para
-- asegurar una creación limpia de estas
DROP TABLE IF EXISTS  zipcodes CASCADE ;
DROP TABLE IF EXISTS  employees CASCADE ;
DROP TABLE IF EXISTS  books CASCADE ;
DROP TABLE IF EXISTS  customers CASCADE ;
DROP TABLE IF EXISTS  orders CASCADE ;
DROP TABLE IF EXISTS  odetails CASCADE ;

-- Se le agrega a zipcodes una llave primaria
-- en 'zip' para referenciarla en las tablas
-- de 'customers' y 'employees'
create table zipcodes (
  zip integer primary key,
  city  varchar(30),
  State varchar(20)
  );

-- Se le agrega a employees una llave primaria
-- en 'emp_no' para referenciarla en la tabla
-- de 'orders'.

-- También se agrega la clave foránea 'zip'
-- con restricción de configuración a NULL en
-- eliminación y restricción de cascada en
-- actualización.
create table employees (
  emp_no  varchar(10) primary key,
  emp_name  varchar(30),
  zip  integer references zipcodes ON DELETE SET NULL ON UPDATE CASCADE,
  hire_date date
  );

-- Se le agrega a books una llave primaria
-- en 'book_no' para referenciarla en la tabla
-- de 'odetails'.
create table books (
  book_no  integer primary key,
  book_name  varchar(30),
  qoh  integer not null,
  price  dec(6,2) not null
  );

-- Se le agrega a customers una llave primaria
-- en 'cust_no' para referenciarla en la tabla
-- de 'orders'.

-- También se agrega la clave foránea 'zip'
-- con restricción de configuración a NULL en
-- eliminación y restricción de cascada en
-- actualización.
create table customers (
  cust_no   integer primary key,
  cust_name  varchar(30),
  street varchar(30),
  zip  integer references zipcodes ON DELETE SET NULL ON UPDATE CASCADE,
  phone  char(12)
  );

-- Se le agrega a orders una llave primaria
-- en 'order_no' para referenciarla en la tabla
-- de 'odetails'.

-- También se agrega la clave foránea 'cust_no'
-- con restricción de prohibición de eliminación
-- y restricción de cascada en actualización.

-- De la misma forma, se agrega la clave foránea 'emp_no'
-- con restricción de prohibición de eliminación
-- y restricción de cascada en actualización.
create table orders (
  order_no  integer  primary key,
  cust_no  integer  references customers ON DELETE RESTRICT ON UPDATE CASCADE,
  emp_no  varchar(10)  references employees ON DELETE RESTRICT ON UPDATE CASCADE,
  received date,
  shipped date
  );

-- Se le agrega a odetails una llave primaria compuesta
-- de las claves foraneas 'order_no' y 'book_no'

-- La clave foránea 'order_no' cuenta
-- con restricción de prohibición de eliminación
-- y restricción de prohibición en actualización.

-- La clave foránea 'book_no' cuenta
-- con restricción de prohibición de eliminación
-- y restricción de prohibición en actualización.
create table odetails (
  order_no  integer  references orders ON DELETE RESTRICT ON UPDATE RESTRICT,
  book_no  integer  references books ON DELETE RESTRICT ON UPDATE RESTRICT,
  quantity integer not null,
  primary key (order_no, book_no)
  );