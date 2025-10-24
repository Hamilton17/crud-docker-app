-- Crear tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos iniciales
INSERT INTO productos (nombre, precio, cantidad) VALUES
    ('Laptop Dell XPS 15', 1299.99, 10),
    ('Mouse Logitech MX Master', 99.99, 25),
    ('Teclado Mecánico Corsair', 149.99, 15),
    ('Monitor Samsung 27"', 329.99, 8),
    ('Webcam Logitech C920', 79.99, 20),
    ('Auriculares Sony WH-1000XM4', 349.99, 12),
    ('Disco SSD Samsung 1TB', 119.99, 30),
    ('Memoria RAM Corsair 16GB', 79.99, 40),
    ('Tarjeta Gráfica NVIDIA RTX 3060', 399.99, 5),
    ('Fuente de Poder EVGA 750W', 129.99, 18);

-- Mostrar los datos insertados
SELECT * FROM productos;
