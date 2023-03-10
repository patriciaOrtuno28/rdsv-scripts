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

### 5. Pruebas Arpwatch

Para comprobar la funcionalidad de arpwatch se deben realizar 2 pasos. Se propone un ejemplo para un caso concreto.

El primero es ejecutar un ping a una IP desconocida desde un equipo de la red residencial. Ya que DHCP otorga IPs en el rango 192.168.255.20 - 30, ejecutar el siguiente comando en h11:

```
ping -c3 192.168.255.32
```

Entrar al POD KNF:cpe de renes1:

```
./osm/handlePods.sh -p cpe -r 1
```

Dentro del mismo ejecutar el fichero automatizado que permite conocer el contenido de brint.dat con los pares mac/ip obtenidos:

```
./captureArp.sh
```

### 6. Pruebas de QoS de bajada

Para comprobar que las reglas de QoS se han aplicado correctamente deberemos ejecutar los siguientes comandos, utilizando las IPs obtenidas previamente para los equipos de la red residencial.

>__Note__ Se debe acceder al pod CPE asociado a la instancia renes para esa red residencial. No se puede mezclar el pod CPE de renes2 con la máquina h11.

:arrow_forward: **(Acceso POD)** Acceder a los pods: sustituir `<type>` por el tipo del pod al que se desee acceder {access, cpe}, y `<renes_id>` por 1 o 2 según la instancia renes a la que se desee acceder.

```
./osm/handlePods.sh -p <type> -r <renes_id>
```

##### hxy

```
iperf3 -s -i 1
```

##### KNF:cpe

```
iperf3 -c <ip> -b 12M -l 1200
```

### 7. Pruebas de QoS de subida

Se proporciona un fichero adicional para probar el QoS de subida, para separar su funcionalidad del de bajada por motivos logísiticos de la entrega. En este caso se usan las direcciones MAC de los equipos de la red residencial por lo que no es necesario introducir las IPs previas. Así, se muestra otra opción de funcionamiento pero también podría hacerse con IPs.

Comenzar ejecutando el siguiente comando para definir las reglas del tráfico:

```
./osm/upQos.sh
```

A continuación, ejecutar iperf3 para comprobar las prestaciones.

>__Note__ Se debe acceder al pod CPE asociado a la instancia renes para esa red residencial. No se puede mezclar el pod CPE de renes2 con la máquina h11.

##### KNF:cpe

```
iperf3 -s -i 1
```

##### hxy

```
iperf3 -c 192.168.255.1 -b 6M -l 1200
```

### 8. Destrucción del escenario y los servicios de red

:warning: **(Opcional)** Destrucción de las máquinas del escenario en K8s

```
./kubernetes/stopScenario.sh
```

:warning: **(Opcional)** Destruir los servicios renes, sus pods y el onboarding asociado en OSM

```
./osm/destroyRenes.sh
```
