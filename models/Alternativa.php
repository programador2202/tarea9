<?php
require_once 'config/Database.php'; // Se importa la conexión a la base de datos

class Alternativa {
    private $db;

    // Constructor: se conecta a la base de datos usando PDO
    public function __construct() {
        $this->db = Database::getConexion();
    }

    // Obtener todas las alternativas
    public function getAlternativas() {
        $query = "SELECT * FROM alternativa";
        $stmt = $this->db->prepare($query); // Se prepara la consulta
        $stmt->execute();                   // Se ejecuta
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // Se obtienen todas las filas como arreglo asociativo
    }

    // Obtener una alternativa por su ID
    public function getAlternativaById($id) {
        $query = "SELECT * FROM alternativa WHERE idalternativa = :id";
        $stmt = $this->db->prepare($query); // Consulta preparada para evitar SQL Injection
        $stmt->bindParam(':id', $id, PDO::PARAM_INT); // Enlaza el parámetro :id con el valor $id
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC); // Devuelve una sola fila
    }

    // Agregar una nueva alternativa
    public function addAlternativa($idpregunta, $texto, $correcta) {
        $query = "INSERT INTO alternativa (idpregunta, texto, correcta)
                  VALUES (:idpregunta, :texto, :correcta)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':idpregunta', $idpregunta, PDO::PARAM_INT); // ID de la pregunta a la que pertenece
        $stmt->bindParam(':texto', $texto, PDO::PARAM_STR);           // Texto de la alternativa
        $stmt->bindParam(':correcta', $correcta, PDO::PARAM_BOOL);    // true o false si es correcta
        return $stmt->execute(); // Retorna true si se insertó correctamente
    }

    // Actualizar una alternativa existente
    public function updateAlternativa($id, $texto, $correcta) {
        $query = "UPDATE alternativa
                  SET texto = :texto, correcta = :correcta
                  WHERE idalternativa = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);        // ID de la alternativa a modificar
        $stmt->bindParam(':texto', $texto, PDO::PARAM_STR);  // Nuevo texto
        $stmt->bindParam(':correcta', $correcta, PDO::PARAM_BOOL); // Nueva condición de correctitud
        return $stmt->execute(); // Retorna true si se actualizó
    }

    // Eliminar una alternativa por su ID
    public function deleteAlternativa($id) {
        $query = "DELETE FROM alternativa WHERE idalternativa = :id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT); // ID de la alternativa a eliminar
        return $stmt->execute(); // Retorna true si se eliminó
    }
}
?>

