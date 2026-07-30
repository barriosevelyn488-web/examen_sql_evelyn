USE pizza_del_campus;

-- 1. Insertar Clientes
INSERT INTO clientes (nombre, dieccion, telefono) VALUES
('Carlos Pérez', 'Calle 10 # 45-20', '555-1234'),
('Ana Gómez', 'Carrera 15 # 80-12', '555-5678'),
('Luis Martínez', 'Avenida Central # 3-45', '555-9012'),
('María Rodríguez', 'Calle 50 # 20-30', '555-3456'),
('Jorge Torres', 'Transversal 5 # 12-15', '555-7890');

-- 2. Insertar Productos
INSERT INTO productos (nombre, categoria, precio, es_elaborado) VALUES
('Pizza Hawaiana', 'Pizzas', 12.50, TRUE),
('Pizza Pepperoni', 'Pizzas', 14.00, TRUE),
('Panzarotti Mixto', 'Panzarottis', 8.50, TRUE),
('Coca-Cola 600ml', 'Bebidas', 2.50, FALSE),
('Jugo Natural', 'Bebidas', 3.00, FALSE),
('Brownie de Chocolate', 'Postres', 4.00, TRUE);

-- 3. Insertar Adiciones
INSERT INTO adiciones (nombre, precio) VALUES
('Queso Extra', 1.50),
('Salsa BBQ', 0.75),
('Champiñones', 1.00),
('Tocineta', 1.25);

-- 4. Insertar Combos
INSERT INTO combos (nombre, precio) VALUES
('Combo Personal (Pizza + Bebida)', 14.00),
('Combo Familiar (2 Pizzas + 2 Bebidas + Postre)', 28.00);

-- 5. Insertar Pedidos (Asegurando fechas de junio de 2026 para cumplir con las consultas de rango)
INSERT INTO pedidos (id_cliente, fecha_hora, tipo_servicio, total) VALUES
(1, '2026-06-02 12:30:00', 'En local', 16.50),
(1, '2026-06-03 13:00:00', 'Para recoger', 14.00),
(1, '2026-06-05 19:30:00', 'En local', 15.25),
(1, '2026-06-10 14:20:00', 'Para recoger', 12.50),
(1, '2026-06-15 20:00:00', 'En local', 18.00),
(1, '2026-06-20 18:00:00', 'Para recoger', 28.00),
(2, '2026-06-04 13:15:00', 'En local', 11.50),
(3, '2026-06-06 21:00:00', 'Para recoger', 14.00),
(4, '2026-06-08 15:45:00', 'En local', 8.50),
(5, '2026-06-12 19:10:00', 'Para recoger', 28.00);

-- 6. Insertar Detalle Pedido Productos
INSERT INTO detalle_pedido_productos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 12.50),
(1, 4, 1, 2.50),
(2, 1, 1, 12.50),
(3, 3, 1, 8.50),
(3, 4, 1, 2.50),
(4, 1, 1, 12.50),
(5, 2, 1, 14.00),
(6, 1, 2, 12.50),
(7, 3, 1, 8.50),
(8, 2, 1, 14.00),
(9, 3, 1, 8.50),
(10, 1, 2, 12.50);

-- 7. Insertar Detalle Adiciones (Ej. Panzarottis con Queso Extra y Pizzas con adiciones)
INSERT INTO detalle_adiciones (id_detalle_producto, id_adicion, cantidad, precio_unitario) VALUES
(3, 1, 1, 1.50), -- Panzarotti Mixto (id_detalle_producto 3) con Queso Extra
(1, 3, 1, 1.00), -- Pizza Hawaiana con Champiñones
(7, 1, 1, 1.50); -- Pizza Pepperoni con Queso Extra

-- 8. Insertar Detalle Pedido Combos
INSERT INTO detalle_pedido_combos (id_pedido, id_combo, cantidad, precio_unitario) VALUES
(2, 1, 1, 14.00),
(6, 2, 1, 28.00),
(8, 1, 1, 14.00),
(10, 2, 1, 28.00);