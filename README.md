# Práctica Final RDSV

Clonar este repositorio en la carpeta ~/shared de la máquina K8s y OSM.

>__Note__ Si algún script no tiene permisos de ejecución hacer `chmod 775 <script>`

## K8S

### Creación de la carpeta rdsv-final

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
./folder/initFolder.sh
```

### Arranque de las máquinas del escenario en K8s

Con este fichero se automatiza el arranque de las máquinas en K8s asegurando que tienen una ip asignada:

```
./scenario/initScenario.sh
```

Con este fichero se automatiza la obtención de las ips de las máquinas de la red residencial:

```
./scenario/getIps.sh
```

Se deben anotar para su posterior uso en el servicio OSM.

#### (Opcional) Destrucción de las máquinas del escenario en K8s

```
./scenario/stopScenario.sh
```

## OSM

### Definición de IPs de las redes residenciales

Con este fichero se ponen las hx1 y hx2 en los ficheros de ejecución de renes para su posterior uso en la definición del QoS.

>__Note__ Debe introducir las IPs obtenidas gracias al script `getIps.sh` ejecutado en K8s.

```
./folder/includeIps.sh -a <h11> -b <h12> -c <h21> -d <h22>
```

### Creación de la carpeta rdsv-final

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
./folder/initFolder.sh
```

### Creación del servicio renes

Con este fichero se automatizan los apartados 3, 4, 5, 7 y 9 de la práctica 4.

Se crean los servicios `renes1` y `renes2`.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
source ./renes/createRenes.sh
```

### Inicio del servicio renes para dar conectividad a las redes residenciales

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales.

```
./renes/runRenes.sh
```

#### (Opcional) Acceder a los pods

>__Note__ Sustituir <type> por el tipo del pod al que se desee acceder {access, cpe}

```
./renes/handlePods.sh -p <type>
```

#### (Opcional) Destruir los servicios renes y sus pods

>__Note__ Sustituir <id> por el identificador renes que se desee destruir {1, 2}

```
./renes/destroyRenes.sh -r <id>
```
