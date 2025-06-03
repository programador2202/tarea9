<?php
require_once 'config/Database.php';

class Examen {
    private $db;

    public function __construct() {
        $this->db = Database::getConexion();
    }

    public function getExamenes() {
        $query = "SELECT * FROM examen";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getExamenById($id) {    
        $query = "SELECT * FROM examen WHERE idexamen = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function addExamen($titulo, $fecha, $duracion, $estado, $idexamen_asignado) {
        $query = "INSERT INTO examen (titulo, fecha, duracion, estado, idexamen_asignado)
                  VALUES (:titulo, :fecha, :duracion, :estado, :idexamen_asignado)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':titulo', $titulo, PDO::PARAM_STR);
        $stmt->bindParam(':fecha', $fecha, PDO::PARAM_STR); // DATETIME formato: 'YYYY-MM-DD HH:MM:SS'
        $stmt->bindParam(':duracion', $duracion, PDO::PARAM_STR); // TIME formato: 'HH:MM:SS'
        $stmt->bindParam(':estado', $estado, PDO::PARAM_STR); // 'ACTIVO' o 'PENDIENTE'
        $stmt->bindParam(':idexamen_asignado', $idexamen_asignado, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function updateExamen($id, $titulo, $fecha, $duracion, $estado, $idexamen_asignado) {
        $query = "UPDATE examen
                  SET titulo = :titulo,
                      fecha = :fecha,
                      duracion = :duracion,
                      estado = :estado,
                      idexamen_asignado = :idexamen_asignado
                  WHERE idexamen = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->bindParam(':titulo', $titulo, PDO::PARAM_STR);
        $stmt->bindParam(':fecha', $fecha, PDO::PARAM_STR);
        $stmt->bindParam(':duracion', $duracion, PDO::PARAM_STR);
        $stmt->bindParam(':estado', $estado, PDO::PARAM_STR);
        $stmt->bindParam(':idexamen_asignado', $idexamen_asignado, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function deleteExamen($id) {
        $query = "DELETE FROM examen WHERE idexamen = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }
}
?>
