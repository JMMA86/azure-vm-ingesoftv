# VM en Azure con Terraform

Proyecto que crea una máquina virtual en Azure usando Terraform.

## Estudiante

- Nombre: Juan Manuel Marín Angarita
- Código: A00382037

## ¿Qué incluye?

- VM Ubuntu 20.04 (Standard_B1ls: 1 vCPU, 0.5GB RAM)
- Red, IP pública y acceso SSH
- Usuario: `marinadmin` | Contraseña: `MarinVM2025@`

## Pasos para ejecutar

### 1. Comandos para desplegar la VM

```powershell
terraform init
terraform plan
terraform apply
```

### 2. Conectarse a la VM

```powershell
ssh marinadmin@<IP_MOSTRADA>
```

**Contraseña:** `MarinVM2025@`

### 3. Eliminar al finalizar

```powershell
terraform destroy
```
