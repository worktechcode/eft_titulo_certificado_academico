// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// [IE2 - Criptografía Aplicada]
// Importación de contratos estándares de la industria desde OpenZeppelin.
// El uso de Ownable permite establecer un sistema de control de acceso jerárquico.
// ReentrancyGuard previene ataques de reentrada (muy recomendado para la seguridad transaccional).
// Remix IDE resolverá estas dependencias descargándolas directamente de NPM de manera nativa.
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Registro Inmutable de Certificados Académicos
 * @author Plantilla base para EFT - Asignatura BCY0010 (DUOC UC)
 * @dev Contrato diseñado con fines estrictamente pedagógicos. Define una arquitectura
 * para que una institución de educación superior administre e invalide credenciales.
 */
contract AcademicCertificates is Ownable, ReentrancyGuard {

    // Estructura que define un Certificado
    // [IE4 - Inmutabilidad y Libro Contable]
    // La definición de este struct especifica la forma del registro que será persistido inmutablemente.
    struct Certificado {
        uint256 idCertificado;      // Identificador o Folio único de la credencial
        string nombreGraduado;      // Nombre completo del alumno titulado
        bytes32 hashContenido;      // [IE2 - Criptografía Aplicada] Hash criptográfico representativo del diploma o RUT+Carrera
        bool activo;                // Flag lógico de validez de la credencial académica
    }

    // [IE4 - Inmutabilidad y Libro Contable]
    // Mapeo público que asocia la dirección (wallet pública) del egresado con su certificado respectivo.
    // [IE5 - Uso de Wallets y Llaves] Las llaves públicas (address) sirven como identificador y método de consulta.
    mapping(address => Certificado) public certificados;

    // Eventos para interactuar con sistemas web (Frontend/dApp) off-chain
    event CertificadoEmitido(address indexed studentWallet, uint256 idCertificado, bytes32 hashContenido);
    event CertificadoInvalidado(address indexed studentWallet, uint256 idCertificado);

    /**
     * @dev Constructor del Smart Contract.
     * En OpenZeppelin v5.0+, el constructor de Ownable requiere la dirección del owner inicial.
     * Para este boilerplate, designamos al creador del contrato (msg.sender) como el owner inicial.
     * Si usas OpenZeppelin v4.x en ambientes locales heredados, puedes usar 'Ownable()' sin argumentos.
     */
    constructor() Ownable(msg.sender) {}

    /**
     * @notice Emite un nuevo certificado académico asociándolo a la wallet del egresado.
     * @dev Restringido únicamente a la Institución Educativa Autorizada (Owner).
     * @param studentWallet Dirección (wallet pública) del egresado que recibirá el certificado.
     * @param idCertificado Número correlativo o folio único del certificado académico.
     * @param nombreGraduado Nombre completo del alumno.
     * @param hashContenido Hash SHA-256 o Keccak-256 del diploma en formato digital para verificar su integridad.
     */
    function emitirCertificado(
        address studentWallet,
        uint256 idCertificado,
        string memory nombreGraduado,
        bytes32 hashContenido
    ) external onlyOwner nonReentrant {
        
        // =========================================================================
        // --- SECCIÓN: COMPLETAR POR EL ALUMNO (TODOs de Validación y Seguridad) ---
        // =========================================================================

        // 1. TODO: [IE5 - Uso de Wallets y Llaves]
        // Escribe un requerimiento (require) para asegurar que la wallet del estudiante no sea la dirección nula.
        // Pista: studentWallet no debe ser igual a address(0).
        // [ESCRIBE_TU_CODIGO_AQUI]

        // 2. TODO: [IE4 - Inmutabilidad y Libro Contable]
        // Evitar duplicidades: Valida que la wallet del estudiante no posea ya un certificado previamente emitido.
        // Pista: Verifica que certificados[studentWallet].idCertificado sea igual a 0.
        // [ESCRIBE_TU_CODIGO_AQUI]

        // 3. TODO: [IE2 - Criptografía Aplicada]
        // Valida que el hash del contenido no sea un hash vacío para asegurar la integridad de la prueba digital.
        // Pista: hashContenido debe ser diferente de bytes32(0).
        // [ESCRIBE_TU_CODIGO_AQUI]


        // =========================================================================
        // --- FIN SECCIÓN COMPLETAR ---
        // =========================================================================

        // Guardado de datos en el Libro de Estado de Ethereum / EVM.
        // [IE4 - Inmutabilidad y Libro Contable] El almacenamiento del estado en la EVM es inalterable.
        certificados[studentWallet] = Certificado({
            idCertificado: idCertificado,
            nombreGraduado: nombreGraduado,
            hashContenido: hashContenido,
            activo: true
        });

        // Notificar a la red de la emisión exitosa
        emit CertificadoEmitido(studentWallet, idCertificado, hashContenido);
    }

    /**
     * @notice Invalida el estado de validez de un certificado emitido previamente.
     * @dev Restringido únicamente al Administrador (Institución Educativa).
     * [IE4 - Inmutabilidad y Libro Contable] Nótese que por diseño de Blockchain, los datos
     * históricos de la emisión siguen grabados en los bloques antiguos, pero cambiamos el estado
     * actual a 'activo = false' para inhabilitar el título en consultas futuras.
     * @param studentWallet Wallet pública del alumno a quien se le revocará el certificado.
     */
    function invalidarCertificado(address studentWallet) external onlyOwner nonReentrant {
        
        // =========================================================================
        // --- SECCIÓN: COMPLETAR POR EL ALUMNO (TODOs de Control de Flujo) ---
        // =========================================================================

        // 4. TODO: [IE4 - Inmutabilidad y Libro Contable]
        // Valida que el certificado de la wallet provista exista actualmente y se encuentre activo.
        // Pista: El atributo 'activo' del certificado asociado a studentWallet debe ser true.
        // [ESCRIBE_TU_CODIGO_AQUI]


        // =========================================================================
        // --- FIN SECCIÓN COMPLETAR ---
        // =========================================================================

        // Desactivamos la credencial en el estado actual
        certificados[studentWallet].activo = false;

        // Emitir evento de invalidación académica
        emit CertificadoInvalidado(studentWallet, certificados[studentWallet].idCertificado);
    }

    /**
     * @notice Permite verificar en tiempo real si una wallet posee un certificado válido.
     * @dev Función pública de solo lectura (view), no consume gas a menos que sea invocada por otro contrato.
     * [IE5 - Uso de Wallets y Llaves] Cualquier validador externo puede consultar el estado usando la wallet del egresado.
     * @param studentWallet Dirección de la wallet que se desea consultar.
     * @return idCertificado Folio interno del certificado.
     * @return nombreGraduado Nombre legible de la persona egresada.
     * @return hashContenido Hash criptográfico representativo del documento físico/digital.
     * @return activo Boolean indicando la vigencia y veracidad del certificado.
     */
    function verificarCertificado(address studentWallet)
        external
        view
        returns (
            uint256 idCertificado,
            string memory nombreGraduado,
            bytes32 hashContenido,
            bool activo
        )
    {
        // =========================================================================
        // --- SECCIÓN: COMPLETAR POR EL ALUMNO (TODOs de Consulta Pública) ---
        // =========================================================================

        // 5. TODO: [IE5 - Uso de Wallets y Llaves]
        // Escribe una cláusula require para asegurar que el certificado consultado realmente exista.
        // Pista: Valida que certificados[studentWallet].activo sea true. De lo contrario, retorna un error.
        // [ESCRIBE_TU_CODIGO_AQUI]


        // =========================================================================
        // --- FIN SECCIÓN COMPLETAR ---
        // =========================================================================

        // Extraemos y retornamos los datos almacenados en el contrato
        Certificado memory cert = certificados[studentWallet];
        return (cert.idCertificado, cert.nombreGraduado, cert.hashContenido, cert.activo);
    }

    // =========================================================================
    // [IE11 - Marco Normativo y Ético - PREGUNTAS DE REFLEXIÓN PARA LA DEFENSA]
    // =========================================================================
    // Alumno de la asignatura BCY0010: Analice críticamente los siguientes puntos para su defensa individual:
    //
    // A. Privacidad de Datos en Chile (Ley N° 19.628 sobre Protección de la Vida Privada):
    //    El almacenamiento público e inmutable del nombre de los egresados ('nombreGraduado') entra en conflicto 
    //    directo con el "Derecho al Olvido". En un entorno productivo real, ¿qué alternativas técnicas existen?
    //    (Pista: Zero-Knowledge Proofs o almacenar los datos personales off-chain y mapear solo el hash criptográfico).
    //
    // B. Ley de Infraestructura Crítica (Ley N° 21.542):
    //    Si este sistema se masificara a nivel país por el Ministerio de Educación, la red Blockchain subyacente
    //    y la wallet administradora del contrato serían designadas como Infraestructura Crítica de Información.
    //    ¿Qué consecuencias tiene esto en cuanto a la custodia de la clave privada institucional y la resiliencia ante ciberataques?
    //
    // C. El Rol Social de la Inmutabilidad:
    //    Discuta cómo la inmutabilidad de la red descentralizada elimina los incentivos al fraude de títulos profesionales
    //    (como el caso de firmas falsificadas en papel), pero a la vez, introduce el desafío ético de qué hacer ante 
    //    un error institucional al momento del registro original.
}
