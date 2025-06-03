<?php
require_once 'config/Database.php';

class Preguntas {
    private $db;

    public function __construct() {
        $this->db = Database::getConexion();
    }

    public function getPreguntas() {
        $query = "SELECT * FROM pregunta";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getPreguntaById($id) {
        $query = "SELECT * FROM pregunta WHERE idpregunta = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function addPregunta($idexamen, $enunciado, $imagen = null) {
        $query = "INSERT INTO pregunta (idexamen, enunciado, imagen) VALUES (:idexamen, :enunciado, :imagen)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':idexamen', $idexamen, PDO::PARAM_INT);
        $stmt->bindParam(':enunciado', $enunciado, PDO::PARAM_STR);
        $stmt->bindParam(':imagen', $imagen, PDO::PARAM_STR);
        return $stmt->execute();
    }

    public function updatePregunta($id, $enunciado, $imagen = null) {
        $query = "UPDATE pregunta SET enunciado = :enunciado, imagen = :imagen WHERE idpregunta = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->bindParam(':enunciado', $enunciado, PDO::PARAM_STR);
        $stmt->bindParam(':imagen', $imagen, PDO::PARAM_STR);
        return $stmt->execute();
    }

    public function deletePregunta($id) {
        $query = "DELETE FROM pregunta WHERE idpregunta = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }
}
?>
