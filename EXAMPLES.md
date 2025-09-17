# Azure VM Infrastructure - Ejemplos de Uso

Este documento proporciona ejemplos prácticos de cómo usar la infraestructura modularizada.

## 📋 Comandos Básicos

### Validar todo el proyecto

```powershell
.\scripts\manage.ps1 -Operation validate-all
```

### Ver estado de todos los environments

```powershell
.\scripts\manage.ps1 -Operation status
```

### Ver análisis de costos

```powershell
.\scripts\manage.ps1 -Operation costs
```

## 🚀 Flujo de Trabajo por Environment

### Development (Desarrollo Individual)

```powershell
# 1. Planificar
.\scripts\deploy.ps1 -Environment dev -Action plan

# 2. Aplicar cambios
.\scripts\deploy.ps1 -Environment dev -Action apply

# 3. Ver outputs
.\scripts\manage.ps1 -Operation outputs -Environment dev

# 4. Conectarse por SSH
.\scripts\manage.ps1 -Operation ssh -Environment dev

# 5. Destruir al finalizar el día
.\scripts\deploy.ps1 -Environment dev -Action destroy -AutoApprove
```

### Staging (Testing/QA)

```powershell
# 1. Desplegar para testing
.\scripts\deploy.ps1 -Environment staging -Action apply

# 2. Ver todas las VMs y sus IPs
.\scripts\manage.ps1 -Operation outputs -Environment staging

# 3. Conectarse a cada VM
.\scripts\manage.ps1 -Operation ssh -Environment staging

# 4. Mantener activo durante testing
# (Destruir solo cuando termine el sprint)
```

### Production (Carga de Trabajo Real)

```powershell
# 1. Planificar con revisión detallada
.\scripts\deploy.ps1 -Environment prod -Action plan -Verbose

# 2. Aplicar con confirmación manual
.\scripts\deploy.ps1 -Environment prod -Action apply

# 3. Verificar estado después del despliegue
.\scripts\manage.ps1 -Operation status

# 4. Documentar outputs para el equipo
.\scripts\manage.ps1 -Operation outputs -Environment prod > prod-infrastructure.txt
```

## 🔧 Ejemplos de Troubleshooting

### Error: Terraform not initialized

```powershell
.\scripts\deploy.ps1 -Environment dev -Action init -ForceInit
```

### Error: Lock file issues

```powershell
.\scripts\manage.ps1 -Operation cleanup
```

### Error: Subscription issues

```powershell
az account set --subscription "41407763-5cf1-45a1-b9fb-8865e49063e5"
az account show
```

## 💰 Optimización de Costos - Casos de Uso

### Scenario 1: Desarrollador Individual

```powershell
# Mañana: Crear environment de desarrollo
.\scripts\deploy.ps1 -Environment dev -Action apply -AutoApprove

# Trabajar durante el día...

# Noche: Destruir para ahorrar costos
.\scripts\deploy.ps1 -Environment dev -Action destroy -AutoApprove

# Costo: ~$0.23/día (solo durante las horas de trabajo)
```

### Scenario 2: Equipo de Testing (1 semana)

```powershell
# Lunes: Crear staging para sprint testing
.\scripts\deploy.ps1 -Environment staging -Action apply

# Martes-Jueves: Mantener activo para testing
# (Sin comandos - environment persistente)

# Viernes: Destroy después de testing
.\scripts\deploy.ps1 -Environment staging -Action destroy

# Costo: ~$5.30/semana de testing
```

### Scenario 3: Producción (24/7)

```powershell
# Despliegue inicial
.\scripts\deploy.ps1 -Environment prod -Action apply

# Mantener activo permanentemente
# Monitoring y backups automáticos

# Costo: ~$92.13/mes constante
```

## 🏗️ Personalización de Configuraciones

### Modificar VMs en Development

1. Editar `environments/dev/terraform.tfvars`
2. Cambiar size de VM si necesitas más recursos:

```hcl
virtual_machines = {
  main = {
    size = "Standard_B1s"  # Upgrade from B1ls
    # ... resto de configuración
  }
}
```

3. Aplicar cambios:

```powershell
.\scripts\deploy.ps1 -Environment dev -Action apply
```

### Agregar una VM adicional en Staging

1. Editar `environments/staging/terraform.tfvars`
2. Agregar nueva VM:

```hcl
virtual_machines = {
  web = { ... }  # VM existente
  app = { ... }  # VM existente
  db = {         # Nueva VM
    size                 = "Standard_B1s"
    admin_username       = "marinadmin"
    admin_password       = "MarinVM2025@"
    # ... configuración completa
  }
}
```

## 🔒 Mejores Prácticas de Seguridad

### Cambiar contraseñas por defecto

1. Editar archivos `.tfvars` en cada environment
2. Cambiar `admin_password = "TuNuevaContraseña2025@"`
3. Aplicar cambios con `terraform apply`

### Usar SSH Keys en lugar de contraseñas

1. Generar SSH key:

```powershell
ssh-keygen -t rsa -b 4096 -f ~/ssh-key-azure
```

2. Modificar configuración de VM:

```hcl
disable_password_authentication = true
ssh_public_key = file("~/ssh-key-azure.pub")
```

## 📊 Monitoreo y Logging

### Ver logs de despliegue

```powershell
.\scripts\deploy.ps1 -Environment dev -Action apply -Verbose
```

### Estado detallado de recursos

```powershell
# Desde el directorio de environment
cd environments/dev
terraform state list
terraform show
```

### Outputs en formato JSON para integración

```powershell
.\scripts\manage.ps1 -Operation outputs -Environment prod | ConvertFrom-Json
```

## 🚨 Comandos de Emergencia

### Destruir todo inmediatamente (PELIGROSO)

```powershell
# SOLO en caso de emergencia - destruye TODA la infraestructura
.\scripts\deploy.ps1 -Environment dev -Action destroy -AutoApprove
.\scripts\deploy.ps1 -Environment staging -Action destroy -AutoApprove
.\scripts\deploy.ps1 -Environment prod -Action destroy -AutoApprove
```

### Recrear desde cero

```powershell
# Limpiar estado
.\scripts\manage.ps1 -Operation cleanup

# Reinicializar
.\scripts\deploy.ps1 -Environment dev -Action init -ForceInit

# Recrear
.\scripts\deploy.ps1 -Environment dev -Action apply
```

---

💡 **Tip**: Siempre ejecuta `plan` antes de `apply` para revisar los cambios que se van a realizar.
