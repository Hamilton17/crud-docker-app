-- ============================================================================
-- Script de Inicialización de Base de Datos
-- CRUD Application - PostgreSQL
-- ============================================================================

-- Crear tabla de productos si no existe
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    cantidad INTEGER NOT NULL CHECK (cantidad >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Verificar si la tabla está vacía antes de insertar datos
DO $$
BEGIN
    -- Solo insertar datos si la tabla está vacía
    IF NOT EXISTS (SELECT 1 FROM productos LIMIT 1) THEN
        -- Insertar datos iniciales de ejemplo
        INSERT INTO productos (nombre, precio, cantidad) VALUES
            ('Laptop Dell XPS 15', 1299.99, 10),
            ('Mouse Logitech MX Master 3', 99.99, 25),
            ('Teclado Mecánico Corsair K95', 149.99, 15),
            ('Monitor Samsung 27" 4K', 329.99, 8),
            ('Webcam Logitech C920 HD Pro', 79.99, 20),
            ('Auriculares Sony WH-1000XM4', 349.99, 12),
            ('Disco SSD Samsung 1TB NVMe', 119.99, 30),
            ('Memoria RAM Corsair 16GB DDR4', 79.99, 40),
            ('Tarjeta Gráfica NVIDIA RTX 3060', 399.99, 5),
            ('Fuente de Poder EVGA 750W', 129.99, 18),
            ('Router TP-Link AC1750', 89.99, 22),
            ('Impresora HP LaserJet Pro', 249.99, 7),
            ('Scanner Epson Perfection', 199.99, 9),
            ('Micrófono Blue Yeti', 129.99, 14),
            ('Cable HDMI 4K 2m', 19.99, 50),
            ('Hub USB-C 7 puertos', 49.99, 35),
            ('Mousepad Gaming XL', 24.99, 45),
            ('Silla Gamer Ergonómica', 299.99, 6),
            ('Escritorio Ajustable', 449.99, 4),
            ('Lámpara LED Escritorio', 39.99, 28);

        RAISE NOTICE '✓ Se insertaron 20 productos de ejemplo correctamente.';
    ELSE
        RAISE NOTICE '⚠ La tabla ya contiene datos. No se insertaron nuevos productos.';
    END IF;
END $$;

-- Crear índice para mejorar búsquedas por nombre
CREATE INDEX IF NOT EXISTS idx_productos_nombre ON productos(nombre);

-- Mostrar información de la base de datos
DO $$
DECLARE
    total_productos INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_productos FROM productos;
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Base de datos inicializada correctamente';
    RAISE NOTICE 'Total de productos en la base de datos: %', total_productos;
    RAISE NOTICE '========================================';
END $$;
