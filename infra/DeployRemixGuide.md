# Guía de Despliegue e Interacción en Remix IDE

Esta guía detalla paso a paso el proceso para compilar, desplegar e interactuar con el Smart Contract [`AcademicCertificates.sol`](./src/AcademicCertificates.sol) utilizando **Remix IDE** y la máquina virtual local (**Remix VM**).

---

## 🛠️ Paso 1: Acceso a Remix IDE
1. Abre tu navegador web y dirígete a [Remix Ethereum IDE](https://remix.ethereum.org/).
2. En el panel lateral izquierdo, asegúrate de estar en el explorador de archivos (**File Explorer**).

---

## 📂 Paso 2: Creación del Archivo e Importación de Dependencias
1. En la carpeta `contracts` (o directamente en el workspace activo de Remix), haz clic en el ícono de **Crear Nuevo Archivo** y nómbralo `AcademicCertificates.sol`.
2. Copia todo el código fuente del contrato desde [`src/AcademicCertificates.sol`](./src/AcademicCertificates.sol) de este repositorio y pégalo en el editor de Remix.
3. **Resolución de Dependencias**: Remix IDE resolverá automáticamente las importaciones de OpenZeppelin Contracts:
   - `import "@openzeppelin/contracts/access/Ownable.sol";`
   - `import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";`
   No necesitas realizar ninguna instalación adicional en la herramienta web, ya que las descarga directamente desde npm.

---

## ⚙️ Paso 3: Compilación del Smart Contract
1. Dirígete a la pestaña **Solidity Compiler** (el ícono del compilador de Solidity en la barra lateral izquierda).
2. Selecciona la versión del compilador: **`0.8.20`** (o superior, según lo definido en el `pragma solidity` del archivo).
3. (Opcional) Expande el menú de *Advanced Configuration* y asegúrate de activar el optimizador si lo deseas, aunque para simulación no es mandatorio.
4. Presiona el botón azul **Compile AcademicCertificates.sol**.
5. Asegúrate de ver un check verde sobre el ícono del compilador, lo que indica que no hay errores de sintaxis.

---

## 🚀 Paso 4: Despliegue del Contrato en Remix VM
1. Ve a la pestaña **Deploy & Run Transactions** (el ícono de la red con un logo de Ethereum en la barra lateral).
2. Configura los siguientes campos:
   - **Environment**: Selecciona `Remix VM (Cancun)` o `Remix VM (Shanghai)`. Esto te proveerá de 10 cuentas de prueba ficticias, cada una cargada con 100 Ether virtuales.
   - **Account**: Por defecto, se selecciona la primera dirección de la lista. Esta cuenta actuará como la **Institución Educativa Autorizada** (el `Owner` del contrato).
   - **Contract**: Asegúrate de que esté seleccionado `AcademicCertificates - contracts/AcademicCertificates.sol`.
3. Haz clic en el botón naranja **Deploy**.
4. En la consola inferior de Remix verás el registro de la transacción exitosa y, en la sección **Deployed Contracts** (esquina inferior izquierda), aparecerá tu contrato desplegado con el nombre `ACADEMICCERTIFICATES AT 0x...`.

---

## 🔄 Paso 5: Interacción con el Contrato
Expande el contrato desplegado para visualizar todos sus métodos públicos. Los botones naranjas representan funciones que modifican el estado (transacciones que consumen gas) y los botones azules representan consultas gratuitas de solo lectura (`view`).

### 1. Emitir un Certificado (`emitirCertificado`)
*   **Quién lo ejecuta**: Solo la cuenta `Owner` (la misma cuenta que desplegó el contrato).
*   **Parámetros**:
    - `studentWallet` (address): La dirección de otra cuenta de Remix (puedes copiar una de la lista de *Account* arriba).
    - `idCertificado` (uint256): Un folio numérico único (ej. `101`).
    - `nombreGraduado` (string): Nombre del egresado (ej. `Juan Perez`).
    - `hashContenido` (bytes32): Un hash hexadecimal de 32 bytes para representar la integridad del diploma (ej. `0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef`).
*   Haz clic en **transact**. La transacción debe ser exitosa y emitir el evento `CertificadoEmitido`.

### 2. Verificar un Certificado (`verificarCertificado` / `certificados`)
*   **Quién lo ejecuta**: Cualquier usuario de la red (público).
*   **Parámetros**:
    - `studentWallet` (address): La misma dirección a la que le emitiste el certificado en el paso anterior.
*   Haz clic en **call**. El contrato retornará los campos: `idCertificado`, `nombreGraduado`, `hashContenido` y `activo` (que debería ser `true`).
*   *Nota*: Si consultas una wallet que no tiene certificados, el contrato revertirá con el error personalizado: `"No existe un certificado activo para esta wallet"`.

### 3. Invalidar un Certificado (`invalidarCertificado`)
*   **Quién lo ejecuta**: Solo el `Owner` del contrato en caso de error administrativo o fraude académico verificado.
*   **Parámetros**:
    - `studentWallet` (address): La dirección de la wallet del egresado cuyo título se revoca.
*   Haz clic en **transact**. La función cambiará el estado lógico a inactivo (`activo = false`) y emitirá el evento `CertificadoInvalidado`. Si vuelves a consultar esa wallet, la verificación fallará.

---

## 🔗 Recursos Adicionales
*   Guía de Estudio de la EFT: [`docs/GUIA_EFT_ESTUDIANTE.md`](./docs/GUIA_EFT_ESTUDIANTE.md)
*   Requisitos de Desarrollo Local: [`README.md`](./README.md)
