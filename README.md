# Práctica Final RDSV

Clonar este repositorio en la carpeta ~/shared de la máquina K8s y OSM.

>__Note__ Si algún script no tiene permisos de ejecución hacer `chmod 775 <script>`



### 1. Lanzar escenario ``` K8s ```

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
./folder/initFolder.sh
```

Con este fichero se automatiza el arranque de las máquinas en K8s:

```
./scenario/initScenario.sh
```

> Se deben anotar para su posterior uso en el servicio OSM.

:warning: **(Opcional)** Destrucción de las máquinas del escenario en K8s

```
./scenario/stopScenario.sh
```

### 2. Dar conectividad a las redes residenciales ``` OSM ```

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
./folder/initFolder.sh
```

Con este fichero se crean de forma automatizada los servicios `renes1` y `renes2` junto con el onboarding.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
source ./renes/createRenes.sh
```

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales. Adicionalmente, se inicia el servicio arpwatch en el CPE.

```
./renes/runRenes.sh
```

### 3. Asegurarse de que las IPs se han definido ``` K8s ```

Con este fichero se automatiza la ejecución de `dhclient` en las hx1 y hx2 de las redes residenciales, para su posterior obtención:

```
./scenario/getIps.sh
```

### 4. Definir IPs para OpenFlow ``` OSM ```

Con este fichero se asegura que los clientes de las redes residenciales tienen asignada una IP en su eth1, y se ponen las hx1 y hx2 en los ficheros de ejecución de renes para su posterior uso en la definición del QoS.

>__Note__ Debe introducir las IPs obtenidas gracias al script `getIps.sh` ejecutado en K8s.

```
./folder/configureOpenFlow.sh -a <h11> -b <h12> -c <h21> -d <h22>
```

:heavy_plus_sign: **(Opcional)** Acceder a los pods: sustituir <type> por el tipo del pod al que se desee acceder {access, cpe}

```
./renes/handlePods.sh -p <type>
```

:warning: **(Opcional)** Destruir los servicios renes y sus pods: sustituir <id> por el identificador renes que se desee destruir {1, 2}

```
./renes/destroyRenes.sh -r <id>
```
