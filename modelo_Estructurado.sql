CREATE DATABASE  examen2;
USE examen2;

DROP DATABASE examen2;

-- Tabla estudiante
CREATE TABLE estudiante (
    idestudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    num_cel VARCHAR(15) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL
) ENGINE=InnoDB;


-- Tabla asignaciones
CREATE TABLE asignaciones (
    idasignaciones INT AUTO_INCREMENT PRIMARY KEY,
    nombre_asignacion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Tabla examen_asignado
CREATE TABLE examen_asignado (
    idexamen_asignado INT AUTO_INCREMENT PRIMARY KEY,
    idasignaciones INT NOT NULL,
    idestudiante INT NOT NULL,
    CONSTRAINT fk_examen_asignado_asignaciones FOREIGN KEY (idasignaciones) REFERENCES asignaciones(idasignaciones),
    CONSTRAINT fk_examen_asignado_estudiante FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante),
    UNIQUE KEY uq_examen_asignado (idasignaciones, idestudiante)
) ENGINE=InnoDB;

-- Tabla examen
CREATE TABLE examen (
    idexamen INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    duracion TIME NOT NULL,
    estado ENUM('ACTIVO', 'PENDIENTE') NOT NULL,
    idexamen_asignado INT NOT NULL,
    FOREIGN KEY (idexamen_asignado) REFERENCES examen_asignado(idexamen_asignado)
) ENGINE=InnoDB;


-- Tabla pregunta
CREATE TABLE pregunta (
    idpregunta INT AUTO_INCREMENT PRIMARY KEY,
    idexamen INT NOT NULL,
    enunciado TEXT NOT NULL,
    FOREIGN KEY (idexamen) REFERENCES examen(idexamen)
) ENGINE=InnoDB;




-- Tabla alternativa
CREATE TABLE alternativa (
    idalternativa INT AUTO_INCREMENT PRIMARY KEY,
    idpregunta INT NOT NULL,
    texto VARCHAR(255) NOT NULL,
    es_correcta BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (idpregunta) REFERENCES pregunta(idpregunta)
) ENGINE=InnoDB;

-- Tabla notas
CREATE TABLE notas (
    idnotas INT AUTO_INCREMENT PRIMARY KEY,
    idexamen INT NOT NULL,
    idestudiante INT NOT NULL,
    estado ENUM('APROBADO', 'DESAPROBADO'),
    nota TINYINT UNSIGNED CHECK (nota BETWEEN 0 AND 20),
    fecha DATETIME NOT NULL,
    CONSTRAINT fk_notas_examen FOREIGN KEY (idexamen) REFERENCES examen(idexamen),
    CONSTRAINT fk_notas_estudiante FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante)
) ENGINE=InnoDB;


-- Tabla historial
CREATE TABLE historial (
    idhistorial INT AUTO_INCREMENT PRIMARY KEY,
    idnotas INT NOT NULL,
    idestudiante INT NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (idnotas) REFERENCES notas(idnotas),
    FOREIGN KEY (idestudiante) REFERENCES estudiante(idestudiante)
) ENGINE=InnoDB;


-- Estudiantes
INSERT INTO estudiante (nombres, apellidos, num_cel, direccion, correo) VALUES
('Juan', 'Pérez', '987654321', 'Av. Los Olivos 123', 'juan.perez@gmail.com'),
('María', 'Gómez', '912345678', 'Calle Ficus 456', 'maria.gomez@hotmail.com'),
('Carlos', 'Ramírez', '998877665', 'Jr. Las Flores 789', 'carlos.ramirez@yahoo.com'),
('Ana', 'Martínez', '911223344', 'Av. Central 321', 'ana.martinez@gmail.com'),
('Luis', 'Fernández', '933112233', 'Pasaje Sol 12', 'luis.fernandez@outlook.com');

-- Asignaciones
INSERT INTO asignaciones (nombre_asignacion) VALUES
('Matemáticas'),
('Comunicación'),
('Historia'),
('Ciencia'),
('Geografía');

-- Examen asignado (1 estudiante con 5 asignaciones)
INSERT INTO examen_asignado (idasignaciones, idestudiante) VALUES
(1, 1),(2, 1),(3, 1),(4, 1),(5, 1);

INSERT INTO examen_asignado (idasignaciones, idestudiante) VALUES
(1, 2),(2, 2),(3, 2),(4, 3),(5, 3);


-- Exámenes (uno por asignación para el estudiante 1)
INSERT INTO examen (titulo, fecha, duracion, estado, idexamen_asignado) VALUES
('Examen de Matemáticas', '2025-06-05 10:00:00', '01:00:00', 'ACTIVO', 1),
('Examen de Comunicación', '2025-06-06 11:00:00', '01:00:00', 'ACTIVO', 2),
('Examen de Historia', '2025-06-07 09:00:00', '01:00:00', 'PENDIENTE', 3),
('Examen de Ciencia', '2025-06-08 13:00:00', '01:00:00', 'ACTIVO', 4),
('Examen de Geografía', '2025-06-09 14:00:00', '01:00:00', 'PENDIENTE', 5);

-- Preguntas (una por examen)
INSERT INTO pregunta (idexamen, enunciado) VALUES
(1, '¿Cuánto es 5 + 5?'),
(2, '¿Qué es un sustantivo?'),
(3, '¿En qué año fue la independencia del Perú?'),
(4, '¿Qué es una célula?'),
(5, '¿Cuál es el río más largo del mundo?');

-- Alternativas (4 por pregunta)
INSERT INTO alternativa (idpregunta, texto, es_correcta) VALUES
-- Pregunta 1
(1, '8', 0), (1, '10', 1), (1, '9', 0), (1, '7', 0),
-- Pregunta 2
(2, 'Una acción', 0), (2, 'Un nombre', 1), (2, 'Una emoción', 0), (2, 'Un color', 0),
-- Pregunta 3
(3, '1821', 1), (3, '1776', 0), (3, '1492', 0), (3, '1810', 0),
-- Pregunta 4
(4, 'Unidad básica de la vida', 1), (4, 'Molécula', 0), (4, 'Átomo', 0), (4, 'Órgano', 0),
-- Pregunta 5
(5, 'Amazonas', 1), (5, 'Nilo', 0), (5, 'Yangtsé', 0), (5, 'Misisipi', 0);

-- Notas (para estudiante 1 en 5 exámenes)
INSERT INTO notas (idexamen, idestudiante, estado, nota, fecha) VALUES
(1, 1, 'APROBADO', 18, '2025-06-10 10:00:00'),
(2, 1, 'APROBADO', 17, '2025-06-11 11:00:00'),
(3, 1, 'DESAPROBADO', 10, '2025-06-12 09:00:00'),
(4, 1, 'APROBADO', 19, '2025-06-13 13:00:00'),
(5, 1, 'DESAPROBADO', 8, '2025-06-14 14:00:00');

-- Historial de notas
INSERT INTO historial (idnotas, idestudiante, fecha) VALUES
(1, 1, '2025-06-15 08:00:00'),
(2, 1, '2025-06-15 08:30:00'),
(3, 1, '2025-06-15 09:00:00'),
(4, 1, '2025-06-15 09:30:00'),
(5, 1, '2025-06-15 10:00:00');



-- 1. ¿Cuántos estudiantes desaprobaron algún examen?
SELECT COUNT(DISTINCT idestudiante) AS total_desaprobados
FROM notas
WHERE estado = 'DESAPROBADO';


-- 2. ¿Cuántos aprobaron el curso de HISTORIA?
SELECT COUNT(DISTINCT n.idestudiante) AS aprobados_en_historia
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
JOIN examen_asignado ea ON ex.idexamen_asignado = ea.idexamen_asignado
JOIN asignaciones a ON ea.idasignaciones = a.idasignaciones
WHERE n.estado = 'APROBADO'
  AND a.nombre_asignacion = 'Historia';



-- 3. Mostrar cantidad de exámenes por estudiante, resueltos y pendientes
SELECT 
    e.idestudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    COUNT(ex.idexamen) AS total_examenes,
    SUM(CASE WHEN ex.estado = 'ACTIVO' THEN 1 ELSE 0 END) AS resueltos,
    SUM(CASE WHEN ex.estado = 'PENDIENTE' THEN 1 ELSE 0 END) AS pendientes
FROM estudiante e
JOIN examen_asignado ea ON e.idestudiante = ea.idestudiante
JOIN examen ex ON ex.idexamen_asignado = ea.idexamen_asignado
GROUP BY e.idestudiante, e.nombres, e.apellidos;



-- 4. ¿Cuál fue la mejor y peor nota del examen de Matemáticas?
SELECT 
    ex.titulo AS examen,
    MAX(n.nota) AS mejor_nota,
    MIN(n.nota) AS peor_nota
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
WHERE ex.titulo = 'Examen de Historia'
GROUP BY ex.titulo;



-- 5. ¿Cuál es el promedio de notas del estudiante con ID = 2?
SELECT 
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    AVG(n.nota) AS promedio
FROM notas n
JOIN estudiante e ON n.idestudiante = e.idestudiante
WHERE e.idestudiante = 1
GROUP BY e.idestudiante, e.nombres, e.apellidos;



-- 6. ¿Qué alumnos tienen asignaciones pero no han rendido ningún examen?
SELECT 
    e.idestudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    a.nombre_asignacion
FROM estudiante e
JOIN examen_asignado ea ON e.idestudiante = ea.idestudiante
JOIN asignaciones a ON ea.idasignaciones = a.idasignaciones
WHERE NOT EXISTS (
    SELECT 1
    FROM examen ex
    JOIN notas n ON ex.idexamen = n.idexamen
    WHERE ex.idexamen_asignado = ea.idexamen_asignado
      AND n.idestudiante = e.idestudiante
)
ORDER BY e.idestudiante, a.nombre_asignacion;



-- 7. ¿Qué alumnos rindieron examen y qué notas obtuvieron?
SELECT 
    ex.titulo AS examen,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    n.nota,
    n.estado
FROM notas n
JOIN examen ex ON n.idexamen = ex.idexamen
JOIN estudiante e ON n.idestudiante = e.idestudiante
ORDER BY ex.titulo, estudiante;


