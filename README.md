# Terraform VM Súper Económica en Azure## Recursos creados

- **Grupo de recursos** con todos los componentes
- **Red virtual** y subred
- **IP pública** dinámica
- **Grupo de seguridad** (permite SSH en puerto 22)
- **VM Linux Ubuntu 20.04** "marinvm" (Standard_B1ls - ultra económica)

## 💰 Costos estimados (Chile Central)

- **VM Standard_B1ls**: ~$3.80 USD/mes
- **Almacenamiento 30GB**: ~$1.54 USD/mes
- **IP pública**: ~$3.65 USD/mes
- **Total estimado**: ~$8-10 USD/mes

## Personalización

- Cambia `name_function` en `variables.tf` para personalizar nombres
- El tipo de VM es `Standard_B1ls` (LA MÁS ECONÓMICA: 1 vCPU, 0.5GB RAM)
- Región por defecto: Chile Centralcto crea una máquina virtual de ultra bajo costo (Standard_B1ls) en Azure usando Terraform.

## Archivos principales

- `main.tf`: Define el proveedor Azure, red, seguridad y la VM Linux.
- `variables.tf`: Variables para nombre y región.
- `outputs.tf`: Muestra IP pública y comando SSH.

## Requisitos

- Tener una cuenta de Azure activa
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) instalado y autenticado
- [Terraform](https://www.terraform.io/) instalado
- **Clave SSH generada:** Ejecuta `ssh-keygen -t rsa -b 4096 -C "tu-email@ejemplo.com"`

## Autenticación en Azure

Inicia sesión en Azure CLI:

```powershell
az login
```

## Uso rápido

1. Inicializa el proyecto:
   ```powershell
   terraform init
   ```
2. Revisa el plan de despliegue:
   ```powershell
   terraform plan
   ```
3. Aplica la infraestructura:
   ```powershell
   terraform apply
   ```

## Recursos creados

- **Grupo de recursos** con todos los componentes
- **Red virtual** y subred
- **IP pública** dinámica
- **Grupo de seguridad** (permite SSH en puerto 22)
- **VM Linux Ubuntu 20.04** (Standard_B1s - económica)

## Personalización

- Cambia `name_function` en `variables.tf` para personalizar nombres
- El tipo de VM es `Standard_B1s` (más económica disponible)
- Región por defecto: Chile Central

## Conexión SSH

Después del despliegue, usa el comando que aparece en `ssh_connection`:

```powershell
ssh azureuser@<IP_PUBLICA>
```

## Limpieza

Para eliminar todos los recursos:

```powershell
terraform destroy
```
