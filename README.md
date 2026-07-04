# Guía del Estudiante: EFT Registro Inmutable de Títulos Académicos

**Asignatura:** Fundamentos de Blockchain (BCY0010)  
**Evaluación:** Evaluación Final Transversal (EFT).  

Este repositorio contiene la plantilla base de código (*boilerplate*) para los estudiantes de pregrado de la asignatura **Fundamentos de Blockchain (BCY0010)** en preparación para su **Evaluación Final Transversal (EFT)**.

---

## 🎯 Objetivo Pedagógico

El propósito de esta plantilla es **reducir al mínimo el esfuerzo de codificación sintáctica pura** en Solidity. Esto evita bloqueos técnicos innecesarios en el laboratorio, permitiendo que los estudiantes concentren su atención en:
1.  La conceptualización del diseño de la base de datos distribuida.
2.  El cumplimiento del marco normativo y legal vigente en Chile.
3.  El debate ético de la inmutabilidad y la privacidad de datos.

---

## 📂 Estructura del Proyecto

*   **[`src/`](./src/):** Contiene el código fuente del Smart Contract en Solidity (`AcademicCertificates.sol`) listo para compilar en Remix IDE con marcadores `TODO` estructurados para el andamiaje del estudiante.
*   **[`docs/`](./docs/):** Guía de apoyo completa (`GUIA_EFT_ESTUDIANTE.md`) que incluye el diagrama de arquitectura, la pauta de evaluación asociada a cada indicador, y las soluciones a los retos del código.
*   **[`infra/`](./infra/):** Contiene la guía de despliegue paso a paso para Remix IDE ([`infra/DeployRemixGuide.md`](./infra/DeployRemixGuide.md)).

---

## 💻 Requerimientos del Sistema y Desarrollo Local

Para compilar, ejecutar pruebas y simular el despliegue de este proyecto de manera local, asegúrate de contar con los siguientes requerimientos e instrucciones:

### ⚙️ Requisitos de Instalación
*   **Node.js**: Versión `18.x` o superior (se recomienda LTS).
*   **npm**: Gestor de paquetes integrado con Node.js.

### 🚀 Instrucciones de Pruebas Locales
1.  **Instalar Dependencias**: Instala las dependencias del proyecto (incluyendo Hardhat y OpenZeppelin) ejecutando en la raíz del proyecto:
    ```bash
    npm install
    ```
2.  **Compilar Contratos**: Compila el código Solidity del Smart Contract con:
    ```bash
    npm run compile
    ```
3.  **Ejecutar Pruebas Unitarias**: Corre la suite de pruebas automatizadas sobre el contrato utilizando:
    ```bash
    npm test
    ```

---

## 🛠️ Cómo Utilizar este Repositorio

### Paso 1: Importar y Completar el Contrato
1.  Copia el archivo [`src/AcademicCertificates.sol`](./src/AcademicCertificates.sol) en Remix IDE.
2.  Resuelve los **5 TODOs** de programación utilizando las pistas indicadas en la guía detallada de estudiantes: [`docs/GUIA_EFT_ESTUDIANTE.md`](./docs/GUIA_EFT_ESTUDIANTE.md).

### Paso 2: Despliegue en Remix
El contrato utiliza las librerías estándares de **OpenZeppelin Contracts** (`Ownable` y `ReentrancyGuard`) mediante resoluciones automáticas nativas en Remix IDE. Para más detalles, consulta la guía en [`infra/DeployRemixGuide.md`](./infra/DeployRemixGuide.md).
*   **Compilador:** Solidity `0.8.20` o superior.
*   **Red de Pruebas:** Remix VM (Cancun o Shanghai) para simulación local, o Sepolia Testnet mediante MetaMask.

### Paso 3: Preparación de la Defensa (80% de la nota)
Estudia las secciones de la guía dedicadas a las normativas chilenas:
*   **Ley N° 19.628** (Protección de la Vida Privada / Derecho al Olvido vs. Inmutabilidad).
*   **Ley N° 21.542** (Infraestructura Crítica de Información aplicada a Blockchain).
*   **Impacto Ético** del fraude académico y la inmutabilidad de los registros públicos.

---

## 🔗 Enlaces de Interés
*   **Remix IDE:** [https://remix.ethereum.org/](https://remix.ethereum.org/)
*   **Documentación de OpenZeppelin:** [https://docs.openzeppelin.com/](https://docs.openzeppelin.com/)
*   **Biblioteca del Congreso Nacional (BCN) - Ley 19.628:** [https://www.bcn.cl/leychile/navegar?idNorma=141505](https://www.bcn.cl/leychile/navegar?idNorma=141505)
