USE pizza_del_campus;

-- 1. Productos más vendidos (pizzas, panzarottis, bebidas, etc.)
SELECT p.nombre, SUM(dpp.cantidad) AS total_vendido
FROM detalle_pedido_productos dpp
JOIN productos p ON dpp.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_vendido DESC;

-- 2. Total de ingresos generados por cada combo
SELECT c.nombre, SUM(dpc.cantidad * dpc.precio_unitario) AS ingresos_totales
FROM detalle_pedido_combos dpc
JOIN combos c ON dpc.id_combo = c.id_combo
GROUP BY c.id_combo, c.nombre;

-- 3. Pedidos realizados para recoger vs. comer en la pizzería
SELECT tipo_servicio, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY tipo_servicio;

-- 4. Adiciones más solicitadas en pedidos personalizados
SELECT a.nombre, SUM(da.cantidad) AS total_solicitado
FROM detalle_adiciones da
JOIN adiciones a ON da.id_adicion = a.id_adicion
GROUP BY a.id_adicion, a.nombre
ORDER BY total_solicitado DESC;

-- 5. Cantidad total de productos vendidos por categoría
SELECT categoria, SUM(dpp.cantidad) AS total_productos
FROM detalle_pedido_productos dpp
JOIN productos p ON dpp.id_producto = p.id_producto
GROUP BY categoria;

-- 6. Promedio de pizzas pedidas por cliente
SELECT cl.nombre, AVG(dpp.cantidad) AS promedio_pizzas
FROM pedidos p
JOIN clientes cl ON p.id_cliente = cl.id_cliente
JOIN detalle_pedido_productos dpp ON p.id_pedido = dpp.id_pedido
JOIN productos pr ON dpp.id_producto = pr.id_producto
WHERE pr.categoria = 'Pizzas'
GROUP BY cl.id_cliente, cl.nombre;

-- 7. Total de ventas por día de la semana
SELECT DAYNAME(fecha_hora) AS dia_semana, SUM(total) AS total_ventas
FROM pedidos
GROUP BY dia_semana;

-- 8. Cantidad de panzarottis vendidos con extra queso
SELECT COUNT(DISTINCT dpp.id_detalle_producto) AS panzarottis_con_queso_extra
FROM detalle_pedido_productos dpp
JOIN productos p ON dpp.id_producto = p.id_producto
JOIN detalle_adiciones da ON dpp.id_detalle_producto = da.id_detalle_producto
JOIN adiciones a ON da.id_adicion = a.id_adicion
WHERE p.categoria = 'Panzarottis' AND a.nombre = 'Queso Extra';

-- 9. Pedidos que incluyen bebidas como parte de un combo
SELECT DISTINCT p.id_pedido, c.nombre AS combo
FROM pedidos p
JOIN detalle_pedido_combos dpc ON p.id_pedido = dpc.id_pedido
JOIN combos c ON dpc.id_combo = c.id_combo;

-- 10. Clientes que han realizado más de 5 pedidos en el último mes
SELECT cl.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM pedidos p
JOIN clientes cl ON p.id_cliente = cl.id_cliente
WHERE p.fecha_hora >= '2026-06-01'
GROUP BY cl.id_cliente, cl.nombre
HAVING COUNT(p.id_pedido) > 5;

-- 11. Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)
SELECT SUM(dpp.cantidad * dpp.precio_unitario) AS ingresos_no_elaborados
FROM detalle_pedido_productos dpp
JOIN productos p ON dpp.id_producto = p.id_producto
WHERE p.es_elaborado = FALSE;

-- 12. Promedio de adiciones por pedido
SELECT AVG(conteo_adiciones) AS promedio_adiciones
FROM (
    SELECT p.id_pedido, COUNT(da.id_detalle_adicion) AS conteo_adiciones
    FROM pedidos p
    LEFT JOIN detalle_pedido_productos dpp ON p.id_pedido = dpp.id_pedido
    LEFT JOIN detalle_adiciones da ON dpp.id_detalle_producto = da.id_detalle_producto
    GROUP BY p.id_pedido
) AS sub;

-- 13. Total de combos vendidos en el último mes
SELECT c.nombre, SUM(dpc.cantidad) AS total_vendidos
FROM detalle_pedido_combos dpc
JOIN combos c ON dpc.id_combo = c.id_combo
JOIN pedidos p ON dpc.id_pedido = p.id_pedido
WHERE p.fecha_hora >= '2026-06-01'
GROUP BY c.id_combo, c.nombre;

-- 14. Clientes con pedidos tanto para recoger como para consumir en el lugar
SELECT cl.nombre
FROM pedidos p
JOIN clientes cl ON p.id_cliente = cl.id_cliente
GROUP BY cl.id_cliente, cl.nombre
HAVING SUM(p.tipo_servicio = 'En local') > 0 AND SUM(p.tipo_servicio = 'Para recoger') > 0;

-- 15. Total de productos personalizados con adiciones
SELECT COUNT(DISTINCT dpp.id_detalle_producto) AS productos_personalizados
FROM detalle_pedido_productos dpp
JOIN detalle_adiciones da ON dpp.id_detalle_producto = da.id_detalle_producto;

-- 16. Pedidos con más de 3 productos diferentes
SELECT p.id_pedido, COUNT(dpp.id_producto) AS productos_diferentes
FROM pedidos p
JOIN detalle_pedido_productos dpp ON p.id_pedido = dpp.id_pedido
GROUP BY p.id_pedido
HAVING COUNT(dpp.id_producto) > 3;

-- 17. Promedio de ingresos generados por día
SELECT DATE(fecha_hora) AS fecha, SUM(total) AS ingreso_dia
FROM pedidos
GROUP BY fecha;

-- 18. Clientes que han pedido pizzas con adiciones
SELECT cl.nombre
FROM pedidos p
JOIN clientes cl ON p.id_cliente = cl.id_cliente
JOIN detalle_pedido_productos dpp ON p.id_pedido = dpp.id_pedido
JOIN productos pr ON dpp.id_producto = pr.id_producto
JOIN detalle_adiciones da ON dpp.id_detalle_producto = da.id_detalle_producto
WHERE pr.categoria = 'Pizzas'
GROUP BY cl.id_cliente, cl.nombre;

-- 19. Porcentaje de ventas provenientes de productos no elaborados
SELECT 
    (SUM(CASE WHEN p.es_elaborado = FALSE THEN dpp.cantidad * dpp.precio_unitario ELSE 0 END) / SUM(dpp.cantidad * dpp.precio_unitario)) * 100 AS porcentaje_no_elaborados
FROM detalle_pedido_productos dpp
JOIN productos p ON dpp.id_producto = p.id_producto;

-- 20. Día de la semana con mayor número de pedidos para recoger
SELECT DAYNAME(fecha_hora) AS dia_semana, COUNT(*) AS total_recoger
FROM pedidos
WHERE tipo_servicio = 'Para recoger'
GROUP BY dia_semana
ORDER BY total_recoger DESC
LIMIT 1;