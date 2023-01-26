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
./kubernetes/initScenario.sh
```

:warning: **(Opcional)** Destrucción de las máquinas del escenario en K8s

```
./kubernetes/stopScenario.sh
```

### 2. Dar conectividad a las redes residenciales ``` OSM ```

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
./folder/initFolder.sh
```

Con este fichero se crean de forma automatizada los servicios `renes1` y `renes2` junto con el onboarding.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
source ./osm/createRenes.sh
```

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales. Adicionalmente, se inicia el servicio arpwatch en el CPE.

```
./osm/runRenes.sh
```

### 3. Preparar equipos de la red residencial para su uso con QoS ``` K8s ```

Con este fichero se automatiza la ejecución de `dhclient` en las hx1 y hx2 de las redes residenciales, para su posterior obtención:

```
./kubernetes/getIps.sh
```

Instalar iperf3 para realizar pruebas de prestaciones:

```
./kubernetes/installIperf3.sh
```

> Se deben anotar para su posterior uso en el servicio OSM.

### 4. Definir IPs para OpenFlow ``` OSM ```

Con este fichero se asegura que los clientes de las redes residenciales tienen asignada una IP en su eth1, y se ponen las hx1 y hx2 en los ficheros de ejecución de renes para su posterior uso en la definición del QoS.

>__Note__ Debe introducir las IPs obtenidas gracias al script `getIps.sh` ejecutado en K8s.

```
./osm/configureOpenFlow.sh -a <h11> -b <h12> -c <h21> -d <h22>
```

### 5. Pruebas de QoS de bajada

Para comprobar que las reglas de QoS se han aplicado correctamente deberemos ejecutar los siguientes comandos, utilizando las IPs obtenidas previamente para los equipos de la red residencial.

>__Note__ Se debe acceder al pod CPE asociado a la instancia renes para esa red residencial. No se puede mezclar el pod CPE de renes2 con la máquina h11.

##### hxy

```
iperf3 -s -i 1
```

##### KNF:cpe

```
iperf3 -c <ip> -b 12M -l 1200
```

:heavy_plus_sign: **(Opcional)** Acceder a los pods: sustituir `<type>` por el tipo del pod al que se desee acceder {access, cpe}, y `<renes_id>` por 1 o 2 según la instancia renes a la que se desee acceder.

```
./osm/handlePods.sh -p <type> -r <renes_id>
```

:warning: **(Opcional)** Destruir los servicios renes, sus pods y el onboarding asociado

```
./osm/destroyRenes.sh
```
