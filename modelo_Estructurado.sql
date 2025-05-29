CREATE DATABASE examen;
USE examen;

-- Tabla estudiante
CREATE TABLE estudiante (
    idestudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    num_cel VARCHAR(15) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

INSERT INTO estudiante (nombres, apellidos, num_cel, direccion, correo) VALUES
('Juan', 'Pérez', '987654321', 'Av. Los Olivos 123', 'juan.perez@gmail.com'),
('María', 'Gómez', '912345678', 'Calle Ficus 456', 'maria.gomez@hotmail.com'),
('Carlos', 'Ramírez', '998877665', 'Jr. Las Flores 789', 'carlos.ramirez@yahoo.com'),
('Ana', 'Martínez', '911223344', 'Av. Central 321', 'ana.martinez@gmail.com'),
('Luis', 'Fernández', '933112233', 'Pasaje Sol 12', 'luis.fernandez@outlook.com'),
('Carmen', 'Vargas', '944556677', 'Calle Luna 55', 'carmen.vargas@gmail.com'),
('Diego', 'Salazar', '966778899', 'Av. El Bosque 99', 'diego.salazar@gmail.com'),
('Lucía', 'Torres', '955443322', 'Jr. Las Palmas 88', 'lucia.torres@hotmail.com'),
('Pedro', 'Mendoza', '977665544', 'Calle Río 101', 'pedro.mendoza@yahoo.com'),
('Sofía', 'Navarro', '922334455', 'Av. Primavera 67', 'sofia.navarro@gmail.com');

-- Tabla asignaciones
CREATE TABLE asignaciones (
    idasignaciones INT AUTO_INCREMENT PRIMARY KEY,
    nombre_asignacion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

INSERT INTO asignaciones (nombre_asignacion) VALUES
('Matemáticas'),
('Comunicación'),
('Historia'),
('Ciencias'),
('Inglés'),
('Física'),
('Química');

-- Tabla examen_asignado
CREATE TABLE examen_asignado (
    idexamen_asignado INT AUTO_INCREMENT PRIMARY KEY,
    idasignaciones INT NOT NULL,
    idestudiante INT NOT NULL,
    CONSTRAINT fk_examen_asignado_asignaciones FOREIGN KEY (idasignaciones) REFERENCES asignaciones(idasignaciones),
    CONSTRAINT fk_examen_asignado_estudiante FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante),
    UNIQUE KEY uq_examen_asignado (idasignaciones, idestudiante)
) ENGINE=InnoDB;

-- Insertar asignaciones a estudiantes
INSERT INTO examen_asignado (idasignaciones, idestudiante) VALUES
(1, 1), (2, 1), (3, 1),     
(1, 2), (2, 2), (3, 2),     
(1, 3), (2, 3), (3, 3),     
(1, 4), (2, 4), (3, 4),     
(4, 5), (5, 5),             
(4, 6), (5, 6),            
(4, 7),           

(6, 8), (7, 8),
(6, 9), (7, 9),
(6, 10), (7, 10);

-- Tabla examen
CREATE TABLE examen (
    idexamen INT AUTO_INCREMENT PRIMARY KEY,
    examen VARCHAR(100) NOT NULL,
    respuestas VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    duracion TIME NOT NULL,
    estado ENUM('ACTIVO', 'PENDIENTE') NOT NULL,
    idexamen_asignado INT NOT NULL,
    CONSTRAINT fk_examen_examen_asignado FOREIGN KEY (idexamen_asignado) REFERENCES examen_asignado(idexamen_asignado)
) ENGINE=InnoDB ;

INSERT INTO examen (examen, respuestas, fecha, duracion, estado, idexamen_asignado) VALUES
('Examen de Matemáticas', 'A,B,C,D,E', '2025-05-20 10:00:00', '01:00:00', 'ACTIVO', 1),
('Examen de Comunicación', 'B,C,D,A,B', '2025-05-21 11:00:00', '01:15:00', 'PENDIENTE', 2),
('Examen de Historia', 'C,D,E,A,B', '2025-05-22 09:00:00', '00:45:00', 'ACTIVO', 3),
('Examen de Ciencias', 'D,E,F,G,H', '2025-05-23 08:30:00', '01:30:00', 'ACTIVO', 13),
('Examen de Inglés', 'A,C,E,G,I', '2025-05-24 14:00:00', '01:00:00', 'PENDIENTE', 14);

-- Tabla notas
CREATE TABLE notas (
    idnotas INT AUTO_INCREMENT PRIMARY KEY,
    idexamen INT NOT NULL,
    idestudiante INT NOT NULL,
    estado ENUM('APROBADO', 'DESAPROBADO'),
    nota TINYINT UNSIGNED,
    fecha DATETIME NOT NULL,
    CONSTRAINT fk_notas_examen FOREIGN KEY (idexamen) REFERENCES examen(idexamen),
    CONSTRAINT fk_notas_estudiante FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante)
) ENGINE=InnoDB ;

INSERT INTO notas (idexamen, idestudiante, estado, nota, fecha) VALUES
(1, 1, 'APROBADO', 18, '2025-05-25 10:00:00'),
(2, 2, 'DESAPROBADO', 10, '2025-05-25 11:00:00'),
(3, 3, 'APROBADO', 20, '2025-05-25 12:00:00'),
(4, 4, 'DESAPROBADO', 8,  '2025-05-25 13:00:00'),
(5, 5, 'APROBADO', 19, '2025-05-25 14:00:00'),
(1, 2, 'DESAPROBADO', 9,  '2025-05-26 09:30:00'),
(2, 3, 'APROBADO', 20, '2025-05-26 10:15:00'),
(3, 4, 'DESAPROBADO', 7,  '2025-05-26 11:45:00'),
(4, 5, 'APROBADO', 16, '2025-05-26 12:30:00'),
(5, 1, 'DESAPROBADO', 6,  '2025-05-26 13:00:00');

-- Tabla historial
CREATE TABLE historial (
    idhistorial INT AUTO_INCREMENT PRIMARY KEY,
    idnotas INT NOT NULL,
    idestudiante INT NOT NULL,
    fecha DATETIME NOT NULL,
    CONSTRAINT fk_historial_estudiante FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante),
    CONSTRAINT fk_historial_notas FOREIGN KEY (idnotas) REFERENCES notas(idnotas)
) ENGINE=InnoDB ;

INSERT INTO historial (idnotas, idestudiante, fecha) VALUES
(1, 1, '2025-05-27 09:00:00'),
(2, 2, '2025-05-27 10:00:00'),
(3, 3, '2025-05-27 11:00:00'),
(4, 4, '2025-05-27 12:00:00'),
(5, 5, '2025-05-27 13:00:00');

-- Consultas

-- 1. Total de desaprobados
SELECT COUNT(*) AS total_desaprobados
FROM notas
WHERE estado = 'DESAPROBADO';

-- 2. Total de aprobados en un curso específico 
SELECT COUNT(DISTINCT n.idestudiante) AS aprobados_en_curso
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
JOIN examen_asignado ea ON ex.idexamen_asignado = ea.idexamen_asignado
JOIN asignaciones a ON ea.idasignaciones = a.idasignaciones
WHERE n.estado = 'APROBADO' AND a.nombre_asignacion = 'HISTORIA';

-- 3. Total de exámenes asignados a cada alumno y su estado (resueltos = ACTIVO, pendientes = PENDIENTE)
SELECT 
    e.idestudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    COUNT(ex.idexamen) AS total_examenes,
    SUM(CASE WHEN ex.estado = 'ACTIVO' THEN 1 ELSE 0 END) AS resueltos,
    SUM(CASE WHEN ex.estado = 'PENDIENTE' THEN 1 ELSE 0 END) AS pendientes
FROM estudiante e
JOIN examen_asignado ea ON e.idestudiante = ea.idestudiante
JOIN examen ex ON ex.idexamen_asignado = ea.idexamen_asignado
GROUP BY e.idestudiante;

-- 4. Mejor y peor nota en un curso 
SELECT 
    ex.examen,
    MAX(n.nota) AS mejor_nota,
    MIN(n.nota) AS peor_nota
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
WHERE ex.examen = 'Examen de Matemáticas'
GROUP BY ex.examen;

-- 5. Promedio de notas de un estudiante específico 
SELECT 
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    AVG(n.nota) AS promedio
FROM notas n
JOIN estudiante e ON n.idestudiante = e.idestudiante
WHERE e.idestudiante = 2
GROUP BY e.idestudiante;

-- 6. consulta para saber que alumnos no dieron ningun examen

SELECT 
    e.idestudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    a.nombre_asignacion AS examen_asignado,
    0 AS nota
FROM estudiante e
JOIN examen_asignado ea ON e.idestudiante = ea.idestudiante
JOIN asignaciones a ON ea.idasignaciones = a.idasignaciones
WHERE e.idestudiante NOT IN (
    SELECT DISTINCT idestudiante FROM notas
)
ORDER BY e.idestudiante, a.nombre_asignacion;


-- 7. Consulta para saber cuantos dieron examen y que notas obtuvieron
SELECT 
    ex.examen,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    n.nota,
    n.estado
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
JOIN estudiante e ON n.idestudiante = e.idestudiante
ORDER BY ex.examen, e.apellidos, e.nombres;



