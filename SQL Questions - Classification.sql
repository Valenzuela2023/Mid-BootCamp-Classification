-- Quito el modo seguro
SET SQL_SAFE_UPDATES = 0;

-- Crea la base de datos
CREATE DATABASE credit_card_classification;

-- Crear tabla con los tipos de datos adecuados en base al csv del proyecto
CREATE TABLE credit_card_data (
    customer_number INT,
    offer_accepted VARCHAR(3),
    reward VARCHAR(20),
    mailer_type VARCHAR(10),
    income_level VARCHAR(10),
    bank_accounts_open INT,
    overdraft_protection VARCHAR(3),
    credit_rating VARCHAR(10),
    credit_cards_held INT,
    homes_owned INT,
    household_size INT,
    own_your_home VARCHAR(3),
    average_balance DECIMAL(10, 2),
    q1_balance DECIMAL(10, 2),
    q2_balance DECIMAL(10, 2),
    q3_balance DECIMAL(10, 2),
    q4_balance DECIMAL(10, 2)
);


-- Compruebo la importación
SELECT * FROM credit_card_classification.credit_card_data;

-- Eliminar la Columna q4_balance
ALTER TABLE credit_card_data DROP COLUMN q4_balance;

-- Verificar que la columna ha sido eliminada
SELECT * FROM credit_card_data LIMIT 10;

-- contar el número de filas
SELECT COUNT(*) FROM credit_card_data;

-- Encontrar los valores únicos en algunas de las columnas categóricas:
SELECT DISTINCT offer_accepted FROM credit_card_data;
SELECT DISTINCT reward FROM credit_card_data;
SELECT DISTINCT mailer_type FROM credit_card_data;
SELECT DISTINCT credit_cards_held FROM credit_card_data;
SELECT DISTINCT household_size FROM credit_card_data;

-- Organice los datos en orden decreciente según el average_balancedel cliente. Devuelve solo los customer_number10 clientes principales con los average_balancesdatos más altos.
SELECT customer_number, average_balance
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

-- ¿Cuál es el saldo promedio de todos los clientes de tus datos?
SELECT AVG(average_balance) AS saldo_promedio
FROM credit_card_data;

-- ¿Cuál es el saldo promedio de los clientes agrupados por Income Level? El resultado devuelto debe tener solo dos columnas, nivel de ingresos y Average balancede los clientes. Utilice un alias para cambiar el nombre de la segunda columna.
SELECT income_level, AVG(average_balance) AS balance_medio
FROM credit_card_data
GROUP BY income_level;

-- ¿Cuál es el saldo promedio de los clientes agrupados por number_of_bank_accounts_open? El resultado devuelto debe tener solo dos columnas number_of_bank_accounts_openy Average balancela de los clientes. Utilice un alias para cambiar el nombre de la segunda columna.
SELECT bank_accounts_open AS number_of_bank_accounts_open, AVG(average_balance) AS balance_medio
FROM credit_card_data
GROUP BY bank_accounts_open;

-- ¿Cuál es el número promedio de tarjetas de crédito que tienen los clientes para cada una de las calificaciones de tarjetas de crédito? El resultado devuelto debe tener solo dos columnas: calificación y número promedio de tarjetas de crédito poseídas. Utilice un alias para cambiar el nombre de la segunda columna.
SELECT credit_rating AS rating, AVG(credit_cards_held) AS avg_credit_cards_held
FROM credit_card_data
GROUP BY credit_rating;

-- ¿Existe alguna correlación entre las columnas credit_cards_heldy number_of_bank_accounts_open? Puedes analizar esto agrupando los datos por una de las variables y luego agregando los resultados de la otra columna. Verifique visualmente si existe una correlación positiva, una correlación negativa o ninguna correlación entre las variables.
SELECT bank_accounts_open AS number_of_bank_accounts_open, AVG(credit_cards_held) AS avg_credit_cards_held
FROM credit_card_data
GROUP BY bank_accounts_open;

-- Sus gerentes solo están interesados ​​en los clientes con las siguientes propiedades: Calificación crediticia media o alta, Tarjetas de crédito con 2 o menos, Posee su propia casa, Tamaño del hogar 3 o más
-- Por el resto de cosas no les preocupa demasiado. Escriba una consulta sencilla para saber cuáles son las opciones disponibles para ellos. ¿Puedes filtrar los clientes que aceptaron las ofertas aquí?
SELECT *
FROM credit_card_data
WHERE credit_rating IN ('Medium', 'High')
  AND credit_cards_held <= 2
  AND own_your_home = 'Yes'
  AND household_size >= 3
  AND offer_accepted = 'Yes';

-- Sus gerentes quieren conocer la lista de clientes cuyo saldo promedio es menor que el saldo promedio de todos los clientes en la base de datos. Escriba una consulta para mostrarles la lista de dichos clientes. Es posible que necesite utilizar una subconsulta para este problema.
SELECT *
FROM credit_card_data
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);

-- Crear la vista para la consulta anterior
CREATE VIEW customers_below_average_balance AS
SELECT *
FROM credit_card_data
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);

-- ¿Cuál es la cantidad de personas que aceptaron la oferta versus la cantidad de personas que no lo hicieron?
SELECT offer_accepted, COUNT(*) AS count
FROM credit_card_data
GROUP BY offer_accepted;

-- Sus gerentes están más interesados ​​en clientes con una calificación crediticia alta o media. ¿Cuál es la diferencia en los saldos promedio de los clientes con calificación de tarjeta de crédito alta y calificación de tarjeta de crédito baja?
SELECT 
    (SELECT AVG(average_balance) FROM credit_card_data WHERE credit_rating = 'High') AS avg_balance_high,
    (SELECT AVG(average_balance) FROM credit_card_data WHERE credit_rating = 'Low') AS avg_balance_low,
    (SELECT AVG(average_balance) FROM credit_card_data WHERE credit_rating = 'High') -
    (SELECT AVG(average_balance) FROM credit_card_data WHERE credit_rating = 'Low') AS balance_difference;

-- En la base de datos, ¿qué tipos de comunicación ( mailer_type) se utilizaron y con cuántos clientes?
SELECT mailer_type, COUNT(*) AS customer_count
FROM credit_card_data
GROUP BY mailer_type;

-- Proporciona los datos del cliente que ocupa el puesto 11 Q1_balanceen tu base de datos.
SELECT *
FROM credit_card_data
ORDER BY q1_balance DESC
LIMIT 1 OFFSET 10;









