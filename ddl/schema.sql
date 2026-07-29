DROP DATABASE IF EXISTS pizza_del_campus;
CREATE DATABASE pizza_del_campus;
USE pizza_del_campus;

-- 1. crear tabla clientes

CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (100),
dieccion VARCHAR (150) NOT NULL,
telefono VARCHAR(20) NOT NULL
);

CREATE INDEX idx_clientes_telefono ON clientes(telefono);

-- 2. TABLA: pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    tipo_servicio VARCHAR(30) NOT NULL, -- 'En local' o 'Para recoger'
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE INDEX idx_pedidos_fecha ON pedidos(fecha_hora);

-- 3. TABLA: detalle_pedido_productos (Productos normales en un pedido)
CREATE TABLE detalle_pedido_productos (
    id_detalle_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- 4. TABLA: productos (Gestión del menú y productos elaborados/no elaborados)
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL, -- 'Pizzas', 'Panzarottis', 'Bebidas', 'Postres'
    precio DECIMAL(10,2) NOT NULL,
    es_elaborado BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_productos_categoria ON productos(categoria);

-- 5. TABLA: detalle_adiciones (Adiciones aplicadas a los productos del pedido)
CREATE TABLE detalle_adiciones (
    id_detalle_adicion INT AUTO_INCREMENT PRIMARY KEY,
    id_detalle_producto INT NOT NULL,
    id_adicion INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_pedido_productos(id_detalle_producto),
    FOREIGN KEY (id_adicion) REFERENCES adiciones(id_adicion)
);

-- 6. TABLA: adiciones (Gestión de adiciones: queso extra, salsas, etc.)
CREATE TABLE adiciones (
    id_adicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- 7. TABLA: detalle_pedido_combos (Combos comprados en un pedido)
CREATE TABLE detalle_pedido_combos (
    id_detalle_combo INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_combo INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_combo) REFERENCES combos(id_combo)
);

-- 8. TABLA: combos (Gestión de combos a precio especial)
CREATE TABLE combos (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);