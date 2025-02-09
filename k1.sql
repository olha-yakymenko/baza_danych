-- Шаг 1: Создание таблицы Klient
CREATE TABLE Klient (
    idKlient SERIAL PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50)
);

-- Шаг 2: Вставка данных в таблицу Klient
INSERT INTO Klient (imie, nazwisko) VALUES
('Jan', 'Kowalski'),
('Anna', 'Nowak'),
('Piotr', 'Wiśniewski');

-- Шаг 3: Создание функции clients_cursor для извлечения данных с использованием курсора
CREATE OR REPLACE FUNCTION clients_cursor()
RETURNS TABLE (idKlient INT, imie VARCHAR, nazwisko VARCHAR) AS $$
DECLARE
    rec Klient;  -- Используем тип данных из таблицы Klient
    cur CURSOR FOR SELECT * FROM Klient;  -- Курсор для выборки всех полей из таблицы Klient
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;
        -- Возвращаем данные текущей записи
        idKlient := rec.idKlient;
        imie := rec.imie;
        nazwisko := rec.nazwisko;
        RETURN NEXT;
    END LOOP;
    CLOSE cur;
END;
$$ LANGUAGE plpgsql;

-- Шаг 4: Вызов функции clients_cursor для извлечения данных из таблицы Klient
SELECT * FROM clients_cursor();
