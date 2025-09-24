# SERVIDOR-NGINX

## Introducción
El presente proyecto tiene como propósito poner en práctica conceptos de **Infraestructura como Código (IaC)** y **automatización de configuraciones**.  
Para ello, se implementa un servidor web NGINX sobre una máquina virtual desplegada en la nube, haciendo uso de **Terraform** como herramienta de aprovisionamiento y **Ansible** para la automatización de la instalación y configuración del servicio.

## Herramientas utilizadas
- **Terraform**: encargado de definir y crear la infraestructura de manera declarativa.
- **Ansible**: responsable de la automatización en la instalación y configuración del servidor.
- **NGINX**: servidor web utilizado como servicio principal del despliegue.
- **Llaves SSH**: medio de autenticación segura para acceder a la máquina creada.

## Estructura del proyecto
- `main.tf`: definición de la infraestructura con Terraform.
- `terraform.tfstate` y `terraform.tfstate.backup`: archivos de estado que registran la infraestructura creada.
- `.terraform.lock.hcl`: asegura las versiones de los proveedores utilizados.
- `terraform-key.pem`: llave privada generada para acceso vía SSH.
- `hosts.ini`: inventario de Ansible con las direcciones IP de los servidores.
- `playbook.yml`: contiene las tareas de automatización para instalar y configurar NGINX.

## Desarrollo

### 1. Aprovisionamiento con Terraform
Se inicializó el proyecto y se desplegó la infraestructura ejecutando:
```bash
terraform init
terraform plan
terraform apply
```

Con esto se creó una máquina virtual accesible vía SSH con la llave terraform-key.pem.

## 2. Configuración con Ansible

Una vez desplegado el servidor:

- Se definió la IP en `hosts.ini`.
- Se creó el `playbook.yml` con tareas para:
  - Actualizar repositorios.
  - Instalar **NGINX**.
  - Verificar el servicio.

Ejecución del playbook:
```bash
ansible-playbook -i hosts.ini playbook.yml --key-file terraform-key.pem
```

## 3. Validación

- Se accedió a la **IP pública** del servidor desde el navegador.  
- Se comprobó la correcta instalación de **NGINX**, visualizando la página de bienvenida por defecto.

## 4. Evidencias

A continuación, se presentan las evidencias del despliegue y configuración realizados:

1. **Creación de la infraestructura con Terraform**

   Se muestra la ejecución del comando `terraform apply`, donde se despliega la máquina virtual en AWS y se asigna una IP pública.  
   
   ![Despliegue de Terraform](https://raw.githubusercontent.com/EmmanuelS23/SERVIDOR-NGINX/main/imagenes/7c37267a-2972-4581-bdf5-62e86796e435.jpg)

2. **Configuración automática con Ansible**  

   Evidencia de la ejecución del `playbook.yml` en Ansible, donde se instalan y configuran NGINX y PHP-FPM de manera automatizada.  
   
   ![Configuracion con Ansible](https://raw.githubusercontent.com/EmmanuelS23/SERVIDOR-NGINX/main/imagenes/6ef576b3-4f9e-493b-a12b-d905de3e9992.jpg)

3. **Validación en el navegador**  

   Se accedió a la IP pública y se comprobó el correcto funcionamiento del servidor mostrando la página de PHP con la información de la versión y módulos cargados. 
   
   ![Evidencia del funcionamiento del servidor web](https://raw.githubusercontent.com/EmmanuelS23/SERVIDOR-NGINX/main/imagenes/b9bd8f74-bc13-4692-a6cf-20a01937266c.jpg)

4. **Destrucción de la infraestructura**  

   Finalmente, se ejecutó `terraform destroy` para eliminar los recursos creados, dejando la infraestructura limpia.  
   
   ![Destrucción de la infraestructura](https://raw.githubusercontent.com/EmmanuelS23/SERVIDOR-NGINX/main/imagenes/abeef7c2-d705-45f8-8f90-742b1a68436f.jpg)
