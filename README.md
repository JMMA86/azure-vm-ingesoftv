# Azure VM Infrastructure - Modularized DevOps Solution

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/Microsoft_Azure-0089D0?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)

>Readme creado con IA

>**Prompt utilizado**: Soy un experto en DevOps y quiero aplicar las mejores prácticas actuales, modularizando este proyecto para que sea escalable. Modifica la estructura del proyecto tanto a nivel de código como de carpetas y archivos para cumplir con lo establecido. Procura usar recursos económicos, y finaliza con un script en powershell que permita ejecutar fácilmente el environment deseado.

Una solución escalable y modular para desplegar infraestructura de máquinas virtuales en Azure usando Terraform, siguiendo las mejores prácticas de DevOps.

## 📚 Tabla de Contenidos

- [🎯 Características](#-características)
- [🏗️ Arquitectura](#️-arquitectura)
- [📁 Estructura del Proyecto](#-estructura-del-proyecto)
- [🚀 Guía de Inicio Rápido](#-guía-de-inicio-rápido)
- [🌍 Environments](#-environments)
- [💰 Optimización de Costos](#-optimización-de-costos)
- [🔧 Scripts de Automatización](#-scripts-de-automatización)
- [📖 Documentación Detallada](#-documentación-detallada)

## 🎯 Características

✅ **Modular y Escalable**: Arquitectura basada en módulos reutilizables  
✅ **Multi-Environment**: Configuraciones específicas para Dev, Staging y Prod  
✅ **Cost-Optimized**: Recursos económicos especialmente para desarrollo  
✅ **DevOps Ready**: Scripts automatizados con validaciones  
✅ **Security First**: Grupos de seguridad configurados por environment  
✅ **Infrastructure as Code**: 100% código versionable

## 🏗️ Arquitectura

```
┌──────────────────────────────────────────────────────────────┐
│                    AZURE SUBSCRIPTION                        │
├──────────────────────────────────────────────────────────────┤
│  DEV ENV           │  STAGING ENV       │  PROD ENV          │
│  ┌─────────────┐   │  ┌─────────────┐   │  ┌─────────────┐   │
│  │ 1x B1ls VM  │   │  │ 2x B1s VMs  │   │  │ 4x Mixed    │   │
│  │ ~$6.80/mon  │   │  │ ~$21.18/mon │   │  │ ~$92.13/mon │   │
│  └─────────────┘   │  └─────────────┘   │  └─────────────┘   │
└──────────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
terraform-vm/
├── 📁 modules/                   # Módulos reutilizables
│   ├── 📁 networking/            # VNet, Subnets, IPs
│   ├── 📁 compute/               # VMs, NICs
│   └── 📁 security/              # NSGs, Rules
├── 📁 environments/              # Configuraciones por ambiente
│   ├── 📁 dev/                   # Desarrollo (cost-optimized)
│   ├── 📁 staging/               # Testing (balanced)
│   └── 📁 prod/                  # Producción (performance)
├── 📁 scripts/                   # Scripts de automatización
│   └── 🚀 terraform.ps1          # Script principal de Terraform
└── 📖 README.md                  # Este archivo
```

## 🚀 Guía de Inicio Rápido

### Prerrequisitos

```powershell
# Verificar Terraform
terraform --version

# Verificar Azure CLI y login
az --version
az login
az account set --subscription "41407763-5cf1-45a1-b9fb-8865e49063e5"
```

### Despliegue Rápido

```powershell
# 1. Inicializar Terraform para desarrollo
.\scripts\terraform.ps1 -Action init -Environment dev

# 2. Planificar cambios
.\scripts\terraform.ps1 -Action plan -Environment dev

# 3. Aplicar infraestructura (con confirmación)
.\scripts\terraform.ps1 -Action apply -Environment dev

# 4. Ver outputs del environment
.\scripts\terraform.ps1 -Action output -Environment dev
```

## 🌍 Environments

### 🔧 Development

**Propósito**: Desarrollo y pruebas iniciales  
**Costo**: ~$6.80/mes  
**Configuración**:

- 1x Standard_B1ls (0.5GB RAM, 1 vCPU)
- Standard_LRS storage
- Configuración mínima de red

```powershell
.\scripts\terraform.ps1 -Action plan -Environment dev
```

### 🧪 Staging

**Propósito**: Testing y QA  
**Costo**: ~$21.18/mes  
**Configuración**:

- 2x Standard_B1s (1GB RAM, 1 vCPU cada una)
- Standard_LRS storage
- Arquitectura multi-tier

```powershell
.\scripts\terraform.ps1 -Action apply -Environment staging
```

### 🏭 Production

**Propósito**: Cargas de trabajo productivas  
**Costo**: ~$92.13/mes  
**Configuración**:

- 2x Standard_B2s (Web + App servers)
- 1x Standard_B1s (Database)
- 1x Standard_B1ls (Bastion)
- Premium_LRS storage
- Arquitectura de alta disponibilidad

```powershell
.\scripts\terraform.ps1 -Action apply -Environment production
```

## 💰 Optimización de Costos

| Environment | VMs      | Storage      | Costo Mensual | Uso Recomendado       |
| ----------- | -------- | ------------ | ------------- | --------------------- |
| **Dev**     | 1x B1ls  | Standard_LRS | ~$6.80        | Desarrollo individual |
| **Staging** | 2x B1s   | Standard_LRS | ~$21.18       | Testing/QA            |
| **Prod**    | 4x Mixed | Premium_LRS  | ~$92.13       | Producción 24/7       |

### 💡 Tips de Ahorro:

- Destruir environments cuando no se usen
- Usar `dev` para desarrollo diario
- Usar `staging` solo para testing importante
- Considerar Azure Reserved Instances para producción

## 🔧 Scripts de Automatización

### 🚀 terraform.ps1 - Script Principal de Terraform

Script centralizado para gestionar todas las operaciones de Terraform en diferentes environments.

```powershell
# Inicializar Terraform para un environment
.\scripts\terraform.ps1 -Action init -Environment dev

# Planificar cambios
.\scripts\terraform.ps1 -Action plan -Environment dev

# Aplicar cambios (con confirmación automática)
.\scripts\terraform.ps1 -Action apply -Environment dev

# Destruir infraestructura (requiere confirmación)
.\scripts\terraform.ps1 -Action destroy -Environment dev

# Validar configuración
.\scripts\terraform.ps1 -Action validate -Environment dev

# Formatear archivos Terraform
.\scripts\terraform.ps1 -Action fmt -Environment dev

# Mostrar estado actual
.\scripts\terraform.ps1 -Action show -Environment dev

# Ver outputs del environment
.\scripts\terraform.ps1 -Action output -Environment dev

# Limpiar archivos temporales
.\scripts\terraform.ps1 -Action clean -Environment dev
```

### 📋 Acciones Disponibles

| Acción     | Descripción                                    | Confirmación |
| ---------- | ---------------------------------------------- | ------------ |
| `init`     | Inicializa Terraform en el environment         | No           |
| `plan`     | Muestra los cambios que se aplicarán           | No           |
| `apply`    | Aplica los cambios a la infraestructura        | Sí           |
| `destroy`  | Destruye todos los recursos del environment    | Sí (doble)   |
| `validate` | Valida la sintaxis de los archivos             | No           |
| `fmt`      | Formatea todos los archivos .tf del proyecto   | No           |
| `show`     | Muestra el estado actual de la infraestructura | No           |
| `output`   | Muestra los outputs del environment            | No           |
| `clean`    | Limpia archivos temporales (.terraform, etc.)  | No           |

### 🌍 Environments Soportados

- `dev`: Environment de desarrollo
- `staging`: Environment de testing
- `production`: Environment de producción (usando 'production' en lugar de 'prod')

## 📖 Documentación Detallada

### 🔧 Configuración de Módulos

Los módulos están diseñados para ser reutilizables:

- **Networking**: Gestiona VNets, subnets y IPs públicas
- **Security**: Maneja NSGs y reglas de seguridad
- **Compute**: Administra VMs y interfaces de red

### 🔒 Seguridad

- Grupos de seguridad específicos por environment
- Reglas restrictivas para producción
- Acceso SSH controlado
- Segregación de red por capas

### 📊 Monitoreo y Logging

Cada environment incluye tags para:

- Environment classification
- Cost center tracking
- Resource lifecycle management
- Automated backup policies (prod)

## 👨‍💻 Estudiante

**Nombre**: Juan Manuel Marín Angarita  
**Código**: A00382037  
**Proyecto**: Ingeniería de Software V - DevOps Infrastructure

## 🤝 Contribución

Este proyecto sigue las mejores prácticas de DevOps:

1. Infrastructure as Code
2. Environment separation
3. Cost optimization
4. Automated deployment
5. Comprehensive documentation

## 📄 Licencia

Este proyecto está desarrollado para fines académicos en el programa de Ingeniería de Software V.
